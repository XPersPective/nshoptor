package com.crazypenguin.nshoptor

import android.content.Context
import android.graphics.Paint
import android.graphics.Typeface
import android.graphics.pdf.PdfDocument
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.text.Layout
import android.text.StaticLayout
import android.text.TextDirectionHeuristics
import android.text.TextPaint
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.IOException
import java.io.OutputStream
import java.util.concurrent.Executors
import java.util.concurrent.Future
import java.util.concurrent.atomic.AtomicBoolean

/** Public Android PDF APIs only. Text comes from the same report snapshot as
 * HTML; Android print-adapter result callback constructors are not public API. */
internal class ReportPdfRenderer(private val context: Context) {
    private val handler = Handler(Looper.getMainLooper())
    private val worker = Executors.newSingleThreadExecutor()
    private var active: Job? = null
    private var disposed = false
    val busy: Boolean get() = active != null

    private class Job(val result: MethodChannel.Result) {
        val cancelled = AtomicBoolean(false)
        val deadline = SystemClock.elapsedRealtime() + 30_000
        var task: Future<*>? = null
        var timeout: Runnable? = null
    }
    private class PdfFailure(val code: String) : IOException()

    fun render(html: String, title: String, text: String?, result: MethodChannel.Result) {
        check(Looper.myLooper() == Looper.getMainLooper())
        if (disposed) { result.error("print_unavailable", "PDF rendering unavailable", null); return }
        if (busy) { result.error("print_busy", "A report is already active", null); return }
        if (html.isBlank() || html.length > 2_000_000 || title.isBlank() || title.length > 200 ||
            text.isNullOrBlank() || text.length > 2_000_000) {
            result.error("invalid_report", "Invalid report", null); return
        }
        val job = Job(result)
        active = job
        job.timeout = Runnable { finish(job, null, "render_timeout") }
        handler.postDelayed(job.timeout!!, 30_000)
        try {
            job.task = worker.submit {
                try {
                    val bytes = renderDocument(job, title, text)
                    handler.post { finish(job, bytes, null) }
                } catch (error: PdfFailure) {
                    handler.post { finish(job, null, error.code) }
                } catch (_: Exception) {
                    handler.post { finish(job, null, "render_failed") }
                }
            }
        } catch (_: Exception) { finish(job, null, "render_failed") }
    }

    private fun renderDocument(job: Job, title: String, text: String): ByteArray {
        val document = PdfDocument()
        var destination: File? = null
        var page: PdfDocument.Page? = null
        try {
            val bodyPaint = TextPaint(Paint.ANTI_ALIAS_FLAG or Paint.SUBPIXEL_TEXT_FLAG).apply {
                color = 0xff202124.toInt()
                textSize = 11f
                typeface = Typeface.create("sans-serif", Typeface.NORMAL)
            }
            val titlePaint = TextPaint(bodyPaint).apply {
                textSize = 14f
                typeface = Typeface.create("sans-serif", Typeface.BOLD)
            }
            val titleLayout = layout(title, titlePaint)
            val footerPaint = Paint(bodyPaint).apply { textSize = 9f; textAlign = Paint.Align.CENTER }
            val bodyTop = MARGIN + titleLayout.height + 10f
            val bodyBottom = PAGE_HEIGHT - MARGIN - 16f
            val freshHeight = bodyBottom - bodyTop
            if (freshHeight <= bodyPaint.textSize) throw PdfFailure("invalid_report")
            var y = bodyTop
            var pageCount = 0
            fun finishPage() {
                val current = page ?: return
                current.canvas.drawText(pageCount.toString(), PAGE_WIDTH / 2f,
                    PAGE_HEIGHT - MARGIN, footerPaint)
                document.finishPage(current)
                page = null
            }
            fun startPage() {
                ensureActive(job)
                finishPage()
                if (pageCount >= MAX_PAGES) throw PdfFailure("report_too_large")
                pageCount++
                val next = document.startPage(PdfDocument.PageInfo.Builder(PAGE_WIDTH, PAGE_HEIGHT, pageCount).create())
                page = next
                next.canvas.save()
                next.canvas.translate(MARGIN, MARGIN)
                titleLayout.draw(next.canvas)
                next.canvas.restore()
                y = bodyTop
            }
            startPage()
            // Blank lines delimit the localized per-product groups supplied by
            // Dart. Keep a complete group on one page whenever it can fit.
            val paragraphs = text.replace("\r\n", "\n").replace('\r', '\n').split(Regex("\n[\\t ]*\n"))
            for (paragraph in paragraphs) {
                ensureActive(job)
                if (paragraph.isBlank()) continue
                val body = layout(paragraph, bodyPaint)
                ensureActive(job)
                if (body.height <= freshHeight && body.height > bodyBottom - y && y > bodyTop) startPage()
                var firstLine = 0
                while (firstLine < body.lineCount) {
                    ensureActive(job)
                    val lineTop = body.getLineTop(firstLine)
                    var endLine = firstLine
                    while (endLine < body.lineCount &&
                        body.getLineBottom(endLine) - lineTop <= bodyBottom - y) endLine++
                    if (endLine == firstLine) {
                        if (y <= bodyTop) throw PdfFailure("invalid_report")
                        startPage()
                        continue
                    }
                    val height = body.getLineBottom(endLine - 1) - lineTop
                    val canvas = page!!.canvas
                    canvas.save()
                    canvas.clipRect(MARGIN, y, PAGE_WIDTH - MARGIN, y + height)
                    canvas.translate(MARGIN, y - lineTop)
                    body.draw(canvas)
                    canvas.restore()
                    y += height
                    firstLine = endLine
                    if (firstLine < body.lineCount) startPage()
                }
                y += 7f
            }
            finishPage()
            ensureActive(job)
            val file = File.createTempFile("report-", ".pdf", context.cacheDir)
            destination = file
            file.outputStream().use { output ->
                document.writeTo(object : OutputStream() {
                    private var count = 0
                    override fun write(value: Int) {
                        ensureActive(job)
                        if (count >= MAX_BYTES) throw PdfFailure("report_too_large")
                        output.write(value); count++
                    }
                    override fun write(bytes: ByteArray, offset: Int, length: Int) {
                        ensureActive(job)
                        if (length > MAX_BYTES - count) throw PdfFailure("report_too_large")
                        output.write(bytes, offset, length); count += length
                    }
                })
            }
            ensureActive(job)
            if (file.length() !in 5..MAX_BYTES.toLong()) throw PdfFailure("invalid_pdf")
            val bytes = ByteArrayOutputStream()
            file.inputStream().use { input ->
                val buffer = ByteArray(16 * 1024)
                while (true) {
                    ensureActive(job)
                    val count = input.read(buffer)
                    if (count == -1) break
                    if (count > MAX_BYTES - bytes.size()) throw PdfFailure("report_too_large")
                    bytes.write(buffer, 0, count)
                }
            }
            return bytes.toByteArray().also {
                if (it.size < 5 || !it.copyOfRange(0, 5).contentEquals(PDF_HEADER)) throw PdfFailure("invalid_pdf")
            }
        } finally {
            // The worker owns these resources, including after UI cancellation.
            // Never close a native canvas/file concurrently from the main thread.
            try { page?.let(document::finishPage) } catch (_: Exception) {}
            try { document.close() } catch (_: Exception) {}
            try { destination?.delete() } catch (_: Exception) {}
        }
    }

    private fun layout(text: String, paint: TextPaint): StaticLayout =
        StaticLayout.Builder.obtain(text, 0, text.length, paint, CONTENT_WIDTH)
            .setAlignment(Layout.Alignment.ALIGN_NORMAL)
            .setTextDirection(TextDirectionHeuristics.FIRSTSTRONG_LTR)
            .setIncludePad(true)
            .setLineSpacing(2f, 1f)
            .build()

    private fun ensureActive(job: Job) {
        if (SystemClock.elapsedRealtime() >= job.deadline) throw PdfFailure("render_timeout")
        if (job.cancelled.get() || Thread.currentThread().isInterrupted) throw PdfFailure("render_cancelled")
    }
    private fun finish(job: Job, bytes: ByteArray?, error: String?) {
        if (active !== job) return
        active = null
        job.cancelled.set(true)
        job.timeout?.let { handler.removeCallbacks(it) }
        job.task?.cancel(true)
        if (error == null && bytes != null) job.result.success(bytes)
        else job.result.error(error ?: "invalid_pdf", "Unable to render report", null)
    }
    fun dispose() {
        check(Looper.myLooper() == Looper.getMainLooper())
        disposed = true
        active?.let { finish(it, null, "activity_destroyed") }
        worker.shutdownNow()
    }
    private companion object {
        const val MAX_BYTES = 20 * 1024 * 1024
        const val MAX_PAGES = 500
        const val PAGE_WIDTH = 595
        const val PAGE_HEIGHT = 842
        const val MARGIN = 28f
        const val CONTENT_WIDTH = 539
        val PDF_HEADER = byteArrayOf(37, 80, 68, 70, 45)
    }
}
