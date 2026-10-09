package com.crazypenguin.nshoptor

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.os.CancellationSignal
import android.os.Handler
import android.os.Looper
import android.os.ParcelFileDescriptor
import android.print.PageRange
import android.print.PrintAttributes
import android.print.PrintDocumentAdapter
import android.print.PrintManager
import android.webkit.WebView
import android.webkit.WebViewClient
import android.webkit.WebResourceRequest
import android.webkit.WebResourceError

class MainActivity : FlutterActivity() {
    private var printView: WebView? = null
    private var printResult: MethodChannel.Result? = null
    private val printHandler = Handler(Looper.getMainLooper())
    private val printTimeout = Runnable { failPrint("load_timeout") }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "nshoptor/print")
            .setMethodCallHandler { call, result ->
                if (call.method != "print") { result.notImplemented(); return@setMethodCallHandler }
                val html = call.argument<String>("html")
                val title = call.argument<String>("title")
                if (html == null || html.length > 2_000_000 || title.isNullOrBlank() || title.length > 200) {
                    result.error("invalid_report", "Invalid report", null)
                } else if (printView != null) {
                    result.error("print_busy", "A print job is already active", null)
                } else {
                    printResult = result
                    try { printHtml(html, title) } catch (_: Exception) { failPrint("print_failed") }
                }
            }
    }

    private fun printHtml(html: String, title: String) {
        val view = WebView(this)
        printView = view
        view.settings.apply {
            javaScriptEnabled = false
            allowFileAccess = false
            allowContentAccess = false
            blockNetworkLoads = true
        }
        view.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest) = true
            override fun onReceivedError(view: WebView, request: WebResourceRequest, error: WebResourceError) {
                if (request.isForMainFrame) failPrint("load_failed")
            }
            override fun onPageFinished(view: WebView, url: String) {
                if (printResult == null || printView !== view) return
                printHandler.removeCallbacks(printTimeout)
                try {
                    val delegate = view.createPrintDocumentAdapter(title)
                    val adapter = object : PrintDocumentAdapter() {
                        override fun onStart() = delegate.onStart()
                        override fun onLayout(old: PrintAttributes?, new: PrintAttributes?, cancel: CancellationSignal?,
                            callback: LayoutResultCallback?, extras: Bundle?) = delegate.onLayout(old, new, cancel, callback, extras)
                        override fun onWrite(pages: Array<out PageRange>?, destination: ParcelFileDescriptor?,
                            cancel: CancellationSignal?, callback: WriteResultCallback?) = delegate.onWrite(pages, destination, cancel, callback)
                        override fun onFinish() {
                            try { delegate.onFinish() } finally { releasePrint() }
                        }
                    }
                    val manager = getSystemService(PRINT_SERVICE) as PrintManager
                    manager.print(title, adapter, PrintAttributes.Builder().setMediaSize(PrintAttributes.MediaSize.ISO_A4).build())
                    printResult?.success(null) // The system dialog opened; it does not prove a saved PDF.
                    printResult = null
                } catch (_: Exception) { failPrint("print_failed") }
            }
        }
        printHandler.postDelayed(printTimeout, 30_000)
        view.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null)
    }

    private fun failPrint(code: String) {
        printResult?.error(code, "Unable to open report", null)
        printResult = null
        releasePrint()
    }
    private fun releasePrint() {
        printHandler.removeCallbacks(printTimeout)
        printView?.destroy()
        printView = null
    }
    override fun onDestroy() {
        failPrint("activity_destroyed")
        super.onDestroy()
    }
}
