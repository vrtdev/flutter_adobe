package be.vrt.adobe_analytics_example

import android.os.Bundle
import android.util.Log
import com.adobe.marketing.mobile.Analytics
import com.adobe.marketing.mobile.Identity
import com.adobe.marketing.mobile.LoggingMode
import com.adobe.marketing.mobile.MobileCore
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MobileCore.setLogLevel(LoggingMode.VERBOSE)
        MobileCore.setApplication(application)
        MobileCore.configureWithAppID("<Your Adobe Environment ID>")

        try {
            Analytics.registerExtension()
            Identity.registerExtension()
        } catch (e: Exception) { // handle exception
            Log.e("Error", e.message)
        }

        MobileCore.start(null)
    }
}
