package com.crazypenguin.nshoptor

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.Keep
import androidx.work.Constraints
import androidx.work.ExistingWorkPolicy
import androidx.work.NetworkType
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.Worker
import androidx.work.WorkerParameters
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean

@Keep
class ReceiptQueueWorker(
    appContext: Context,
    params: WorkerParameters,
) : Worker(appContext, params) {

    override fun doWork(): Result {
        val latch = CountDownLatch(1)
        val finishedOk = AtomicBoolean(false)
        val mainHandler = Handler(Looper.getMainLooper())
        var headlessEngine: FlutterEngine? = null

        val liveMessenger = foregroundMessenger
        if (liveMessenger != null) {
            mainHandler.post {
                MethodChannel(liveMessenger, CHANNEL).invokeMethod(
                    "drainQueue",
                    null,
                    object : MethodChannel.Result {
                        override fun success(result: Any?) {
                            finishedOk.set(true)
                            latch.countDown()
                        }

                        override fun error(
                            errorCode: String,
                            errorMessage: String?,
                            errorDetails: Any?,
                        ) {
                            latch.countDown()
                        }

                        override fun notImplemented() {
                            latch.countDown()
                        }
                    },
                )
            }
        } else {
            mainHandler.post {
                try {
                    val loader = FlutterInjector.instance().flutterLoader()
                    loader.startInitialization(applicationContext)
                    loader.ensureInitializationComplete(applicationContext, null)
                    val engine = FlutterEngine(applicationContext)
                    headlessEngine = engine
                    val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                    channel.setMethodCallHandler { call, res ->
                        when (call.method) {
                            "backgroundDrainFinished" -> {
                                val ok = (call.arguments as? Map<*, *>)?.get("ok") as? Boolean ?: true
                                finishedOk.set(ok)
                                res.success(null)
                                latch.countDown()
                            }
                            else -> res.notImplemented()
                        }
                    }
                    val entrypoint = DartExecutor.DartEntrypoint(
                        loader.findAppBundlePath(),
                        "receiptQueueBackgroundMain",
                    )
                    engine.dartExecutor.executeDartEntrypoint(entrypoint)
                } catch (_: Throwable) {
                    latch.countDown()
                }
            }
        }

        val completed = try {
            latch.await(9, TimeUnit.MINUTES)
        } catch (_: InterruptedException) {
            false
        } finally {
            mainHandler.post {
                headlessEngine?.destroy()
                headlessEngine = null
            }
        }

        if (completed && finishedOk.get()) {
            return Result.success()
        }
        return if (runAttemptCount >= 5) Result.failure() else Result.retry()
    }

    companion object {
        const val WORK_NAME = "nshoptor_receipt_queue"
        const val CHANNEL = "nshoptor/background_queue"

        @Volatile
        var foregroundMessenger: BinaryMessenger? = null

        fun enqueue(context: Context) {
            val constraints = Constraints.Builder()
                .setRequiredNetworkType(NetworkType.CONNECTED)
                .build()
            val request = OneTimeWorkRequestBuilder<ReceiptQueueWorker>()
                .setConstraints(constraints)
                .build()
            WorkManager.getInstance(context).enqueueUniqueWork(
                WORK_NAME,
                ExistingWorkPolicy.APPEND_OR_REPLACE,
                request,
            )
        }
    }
}
