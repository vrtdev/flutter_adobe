package be.vrt.adobe_analytics

import android.os.Handler
import com.adobe.marketing.mobile.MobileCore
import com.adobe.marketing.mobile.Identity

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.concurrent.Executors

class AdobeAnalyticsPlugin : MethodCallHandler {
    companion object {
        private const val METHOD_CHANNEL_NAME = "adobe_analytics"
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
            channel.setMethodCallHandler(AdobeAnalyticsPlugin())
        }
    }

    private val backgroundExecutor by lazy { Executors.newCachedThreadPool() }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (val data = Extractor.adobeCallFromCall(call)) {
            is Extractor.AdobeCall.TrackState -> trackState(data, result)
            is Extractor.AdobeCall.TrackAction -> trackAction(data, result)
            is Extractor.AdobeCall.GetExperienceCloudId -> {
                val handler = Handler()
                backgroundExecutor.execute {
                    Identity.getExperienceCloudId {
                        handler.post {
                            result.success(it)
                        }
                    }
                }
            }
            Extractor.AdobeCall.Unknown -> result.notImplemented()
        }.exhaustive
    }

    private fun trackAction(trackAction: Extractor.AdobeCall.TrackAction, result: Result) {
        MobileCore.trackAction(trackAction.action, trackAction.contextData)
        result.success(true)
    }

    private fun trackState(trackState: Extractor.AdobeCall.TrackState, result: Result) {
        MobileCore.trackState(trackState.state, trackState.contextData)
        result.success(true)
    }
}

val <T> T.exhaustive: T
    get() = this