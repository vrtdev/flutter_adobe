package be.vrt.adobe_analytics

import android.os.Handler
import android.os.Looper
import com.adobe.marketing.mobile.MobileCore
import com.adobe.marketing.mobile.Identity

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class AdobeAnalyticsPlugin : MethodCallHandler {
    companion object {
        private const val METHOD_CHANNEL_NAME = "adobe_analytics"
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
            channel.setMethodCallHandler(AdobeAnalyticsPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (val data = Extractor.adobeCallFromCall(call)) {
            is Extractor.AdobeCall.TrackState -> trackState(data, result)
            is Extractor.AdobeCall.TrackAction -> trackAction(data, result)
            is Extractor.AdobeCall.AppendVisitorInfo -> {
                Identity.appendVisitorInfoForURL(data.url) {
                    runOnUiThread {
                        result.success(it)
                    }
                }
            }
            is Extractor.AdobeCall.GetExperienceCloudId -> {
                Identity.getExperienceCloudId {
                    runOnUiThread {
                        result.success(it)
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

private val <T> T.exhaustive: T
    get() = this

private fun runOnUiThread(block: () -> Unit) =
        Handler(Looper.getMainLooper()).post {
            block()
        }
