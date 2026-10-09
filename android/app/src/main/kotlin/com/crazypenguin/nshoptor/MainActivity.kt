package com.crazypenguin.nshoptor

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.speech.SpeechRecognizer
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.RecognitionSupport
import android.speech.RecognitionSupportCallback
import java.util.Locale
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
    private val mainHandler = Handler(Looper.getMainLooper())
    private val printTimeout = Runnable { failPrint("load_timeout") }

    private var speechChannel: MethodChannel? = null
    private var recognizer: SpeechRecognizer? = null
    private var speechOwner = 0L
    private var speechGeneration = 0L
    private var speechActive = false
    private var speechResumed = false
    private var speechInitResult: MethodChannel.Result? = null
    private var speechLocalesResult: MethodChannel.Result? = null
    private var speechStopResult: MethodChannel.Result? = null
    private var speechLocales = emptyList<String>()
    private val speechTimeout = Runnable {
        if (speechActive) {
            emitSpeech("error", mapOf("code" to "recognition_timeout"))
            finishSpeech()
            recognizer?.cancel()
        } else {
            speechLocalesResult?.success(emptyList<String>())
            speechLocalesResult = null
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        speechChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "nshoptor/speech")
        speechChannel?.setMethodCallHandler { call, result ->
            val owner = call.argument<Number>("sessionId")?.toLong()
            if (owner == null || owner <= 0) { result.error("invalid_session", "Invalid session", null); return@setMethodCallHandler }
            if (call.method == "initialize") {
                cancelSpeech()
                if (Build.VERSION.SDK_INT < 31 || !SpeechRecognizer.isOnDeviceRecognitionAvailable(this) || !speechResumed) {
                    result.success(false)
                } else {
                    speechOwner = owner
                    speechInitResult = result
                    if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                        requestPermissions(arrayOf(Manifest.permission.RECORD_AUDIO), 4102)
                    } else { initializeSpeech() }
                }
            } else if (owner != speechOwner) {
                if (call.method == "cancel" || call.method == "stop") result.success(null)
                else result.error("inactive_session", "Inactive session", null)
            } else {
                try {
                    when (call.method) {
                        "locales" -> installedSpeechLocales(result)
                        "start" -> startSpeech(call.argument<String>("locale"), result)
                        "stop" -> if (!speechActive) result.success(null) else {
                            speechStopResult?.success(null)
                            speechStopResult = result
                            recognizer?.stopListening()
                        }
                        "cancel" -> { cancelSpeech(); result.success(null) }
                        else -> result.notImplemented()
                    }
                } catch (_: Exception) {
                    if (speechLocalesResult === result) speechLocalesResult = null
                    if (speechStopResult === result) speechStopResult = null
                    result.error("serviceUnavailable", "On-device speech unavailable", null)
                    cancelSpeech()
                }
            }
        }
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
                mainHandler.removeCallbacks(printTimeout)
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
        mainHandler.postDelayed(printTimeout, 30_000)
        view.loadDataWithBaseURL(null, html, "text/html", "UTF-8", null)
    }

    private fun failPrint(code: String) {
        printResult?.error(code, "Unable to open report", null)
        printResult = null
        releasePrint()
    }
    private fun releasePrint() {
        mainHandler.removeCallbacks(printTimeout)
        printView?.destroy()
        printView = null
    }
    private fun initializeSpeech() {
        if (Build.VERSION.SDK_INT < 31 || speechInitResult == null || !speechResumed) return
        try {
            recognizer = SpeechRecognizer.createOnDeviceSpeechRecognizer(this)
            recognizer?.setRecognitionListener(speechListener(speechOwner, speechGeneration))
            speechInitResult?.success(true)
        } catch (_: Exception) { speechInitResult?.success(false) }
        speechInitResult = null
    }
    private fun speechIntent(locale: String) = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH)
        .putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
        .putExtra(RecognizerIntent.EXTRA_LANGUAGE, locale)
        .putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true)
        .putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1)

    private fun installedSpeechLocales(result: MethodChannel.Result) {
        val engine = recognizer ?: run { result.success(emptyList<String>()); return }
        if (Build.VERSION.SDK_INT < 33) {
            // ponytail: API31–32 cannot enumerate installed models; expose only device locale.
            // API33 recognition support provides the full installed language list.
            speechLocales = listOf(Locale.getDefault().toLanguageTag())
            result.success(speechLocales)
            return
        }
        speechLocalesResult?.success(emptyList<String>())
        speechLocalesResult = result
        val generation = speechGeneration
        mainHandler.postDelayed(speechTimeout, 15_000)
        engine.checkRecognitionSupport(speechIntent(Locale.getDefault().toLanguageTag()), mainExecutor,
            object : RecognitionSupportCallback {
                override fun onSupportResult(support: RecognitionSupport) {
                    if (generation != speechGeneration || speechLocalesResult !== result) return
                    mainHandler.removeCallbacks(speechTimeout)
                    speechLocales = support.installedOnDeviceLanguages
                    result.success(speechLocales)
                    speechLocalesResult = null
                }
                override fun onError(error: Int) {
                    if (generation != speechGeneration || speechLocalesResult !== result) return
                    mainHandler.removeCallbacks(speechTimeout)
                    result.success(emptyList<String>())
                    speechLocalesResult = null
                }
            })
    }
    private fun startSpeech(locale: String?, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < 31 || recognizer == null || !speechResumed) {
            result.error("serviceUnavailable", "On-device speech unavailable", null); return
        }
        if (speechActive) { result.error("recognizer_busy", "Wait for final recognition", null); return }
        fun tag(value: String) = value.replace('_', '-').lowercase(Locale.ROOT)
        if (locale == null || speechLocales.none { tag(it) == tag(locale) }) {
            result.error("unsupportedLanguage", "No installed model for this language", null); return
        }
        // A fresh recognizer owns its callback binder: old provider events cannot reach a new listener.
        recognizer?.destroy()
        recognizer = SpeechRecognizer.createOnDeviceSpeechRecognizer(this)
        speechGeneration++
        recognizer?.setRecognitionListener(speechListener(speechOwner, speechGeneration))
        speechActive = true
        // ponytail: cap a stuck provider/session at 60s; make configurable for long dictation.
        mainHandler.postDelayed(speechTimeout, 60_000)
        emitSpeech("status", mapOf("listening" to true))
        recognizer?.startListening(speechIntent(locale))
        result.success(null)
    }
    private fun speechListener(owner: Long, generation: Long) = object : RecognitionListener {
        fun current() = owner == speechOwner && generation == speechGeneration && speechActive
        override fun onReadyForSpeech(params: Bundle?) { if (current()) emitSpeech("status", mapOf("listening" to true)) }
        override fun onBeginningOfSpeech() {}
        override fun onRmsChanged(rms: Float) {}
        override fun onBufferReceived(buffer: ByteArray?) {}
        override fun onEndOfSpeech() {} // Audio ended; final recognition has not necessarily arrived.
        override fun onEvent(event: Int, params: Bundle?) {}
        override fun onError(error: Int) {
            if (!current()) return
            val code = when (error) {
                SpeechRecognizer.ERROR_LANGUAGE_NOT_SUPPORTED, SpeechRecognizer.ERROR_LANGUAGE_UNAVAILABLE -> "unsupportedLanguage"
                SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS -> "serviceUnavailablePermission"
                else -> "recognition_$error"
            }
            emitSpeech("error", mapOf("code" to code))
            finishSpeech()
        }
        override fun onResults(results: Bundle?) {
            if (!current()) return
            val text = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)?.firstOrNull().orEmpty()
            if (text.isEmpty()) emitSpeech("error", mapOf("code" to "recognition_no_match"))
            else emitSpeech("result", mapOf("text" to text, "final" to true))
            finishSpeech()
        }
        override fun onPartialResults(results: Bundle?) {
            if (!current()) return
            val text = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)?.firstOrNull().orEmpty()
            if (text.isNotEmpty()) emitSpeech("result", mapOf("text" to text, "final" to false))
        }
    }
    private fun emitSpeech(type: String, values: Map<String, Any>) {
        speechChannel?.invokeMethod("event", values + mapOf("type" to type, "sessionId" to speechOwner))
    }
    private fun finishSpeech() {
        speechActive = false
        mainHandler.removeCallbacks(speechTimeout)
        emitSpeech("status", mapOf("listening" to false))
        speechStopResult?.success(null)
        speechStopResult = null
    }
    private fun cancelSpeech() {
        if (speechActive) finishSpeech()
        speechGeneration++
        speechOwner = 0L
        mainHandler.removeCallbacks(speechTimeout)
        speechInitResult?.success(false); speechInitResult = null
        speechLocalesResult?.success(emptyList<String>()); speechLocalesResult = null
        speechStopResult?.success(null); speechStopResult = null
        val engine = recognizer
        recognizer = null
        try { engine?.cancel() } catch (_: Exception) { /* Already disconnected. */ }
        try { engine?.destroy() } catch (_: Exception) { /* Activity teardown still completes. */ }
        speechLocales = emptyList()
    }
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != 4102 || speechInitResult == null) return
        if (grantResults.firstOrNull() != PackageManager.PERMISSION_GRANTED) cancelSpeech()
        else if (speechResumed) initializeSpeech()
    }
    override fun onResume() {
        super.onResume()
        speechResumed = true
        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) initializeSpeech()
    }
    override fun onPause() {
        speechResumed = false
        if (speechActive) cancelSpeech()
        super.onPause()
    }
    override fun onStop() { cancelSpeech(); super.onStop() }
    override fun onDestroy() {
        cancelSpeech()
        failPrint("activity_destroyed")
        super.onDestroy()
    }
}
