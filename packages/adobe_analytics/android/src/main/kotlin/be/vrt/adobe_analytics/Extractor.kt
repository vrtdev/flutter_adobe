package be.vrt.adobe_analytics

import io.flutter.plugin.common.MethodCall

object Extractor {
    private enum class AdobePluginCall(val rawMethodName: String? = null) {
        TRACK("track"),
        APPEND_VISITOR_INFO("appendVisitorInfo"),
        GET_EXPERIENCE_CLOUD_ID("getExperienceCloudId"),
        UNKNOWN(null);
    }

    sealed class AdobeCall {
        data class TrackAction(val action: String, val contextData: Map<String, String>?) : AdobeCall()
        data class TrackState(val state: String, val contextData: Map<String, String>?) : AdobeCall()
        data class AppendVisitorInfo(val url: String) : AdobeCall()
        object GetExperienceCloudId : AdobeCall()
        object Unknown : AdobeCall()
    }

    private const val typeKey = "type"
    private const val keyKey = "key"
    private const val stateKey = "state"
    private const val actionKey = "action"
    private const val contextDataKey = "data"
    private const val urlKey = "url"

    private fun callFromRawMethodName(rawMethodName: String?): AdobePluginCall =
            AdobePluginCall.values()
                    .filter { !it.rawMethodName.isNullOrEmpty() }
                    .firstOrNull { it.rawMethodName == rawMethodName }
                    ?: AdobePluginCall.UNKNOWN

    fun adobeCallFromCall(call: MethodCall): AdobeCall =
            when (callFromRawMethodName(call.method)) {
                AdobePluginCall.TRACK ->
                    adobeCallFromTrackCall(call)
                AdobePluginCall.APPEND_VISITOR_INFO -> adobeCallFromAppendVisitorInfoCall(call)
                AdobePluginCall.GET_EXPERIENCE_CLOUD_ID -> AdobeCall.GetExperienceCloudId
                AdobePluginCall.UNKNOWN -> AdobeCall.Unknown
            }

    private fun adobeCallFromAppendVisitorInfoCall(call: MethodCall): AdobeCall =
            AdobeCall.AppendVisitorInfo(
                    call.argument<String>(urlKey)!!
            )

    private fun adobeCallFromTrackCall(call: MethodCall): AdobeCall =
            when (call.argument<String>(typeKey)) {
                actionKey -> AdobeCall.TrackAction(
                        call.argument<String>(keyKey)!!,
                        call.argument<Map<String, String>>(contextDataKey)
                )
                stateKey -> AdobeCall.TrackState(
                        call.argument<String>(keyKey)!!,
                        call.argument<Map<String, String>>(contextDataKey)
                )
                else -> AdobeCall.Unknown
            }
}