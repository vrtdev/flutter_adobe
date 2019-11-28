package com.example.adobe_analytics

import io.flutter.plugin.common.MethodCall

object Extractor {
    private enum class AdobePluginCall(val rawMethodName: String? = null) {
        TRACK("track"),
        UNKNOWN(null);
    }

    sealed class AdobeCall {
        data class TrackAction(val action: String, val contextData: Map<String, String>) : AdobeCall()
        data class TrackState(val state: String, val contextData: Map<String, String>) : AdobeCall()
        object Unknown : AdobeCall()
    }

    private const val typeKey = "type"
    private const val keyKey = "key"
    private const val stateKey = "state"
    private const val actionKey = "action"
    private const val contextDataKey = "data"

    private fun callFromRawMethodName(rawMethodName: String?): AdobePluginCall =
            AdobePluginCall.values()
                    .filter { !it.rawMethodName.isNullOrEmpty() }
                    .firstOrNull { it.rawMethodName == rawMethodName }
                    ?: AdobePluginCall.UNKNOWN

    fun adobeCallFromCall(call: MethodCall): AdobeCall =
            when (callFromRawMethodName(call.method)) {
                AdobePluginCall.TRACK ->
                    adobeCallFromTrackCall(call)
                AdobePluginCall.UNKNOWN -> AdobeCall.Unknown
            }

    private fun adobeCallFromTrackCall(call: MethodCall): AdobeCall {
        when (call.argument<String>(typeKey)) {
            actionKey -> AdobeCall.TrackAction(
                    call.argument<String>(keyKey)!!,
                    call.argument<Map<String, String>>(contextDataKey)!!
            )
            stateKey -> AdobeCall.TrackState(
                    call.argument<String>(keyKey)!!,
                    call.argument<Map<String, String>>(contextDataKey)!!
            )
        }
        return AdobeCall.Unknown
    }
}