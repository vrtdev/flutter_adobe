package be.vrt.adobe_analytics

import com.adobe.marketing.mobile.MobileCore

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
        val exhaustMe: Any = when (val data = Extractor.adobeCallFromCall(call)) {
            is Extractor.AdobeCall.TrackState -> trackState(data, result)
            is Extractor.AdobeCall.TrackAction -> trackAction(data, result)
            Extractor.AdobeCall.Unknown -> result.notImplemented()
        }
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
