package be.vrt.adobe_analytics_example

import android.util.Log
import com.adobe.marketing.mobile.Analytics
import com.adobe.marketing.mobile.Identity
import com.adobe.marketing.mobile.LoggingMode
import com.adobe.marketing.mobile.MobileCore
import io.flutter.app.FlutterApplication

class MainApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()

        MobileCore.setLogLevel(LoggingMode.VERBOSE)
        MobileCore.setApplication(this)
        MobileCore.configureWithAppID("launch-EN6d9dd10dfef34db8b0c44ea88e8372c2-staging")

        try {
            Analytics.registerExtension()
            Identity.registerExtension()
        } catch (e: Exception) { // handle exception
            Log.e("Error", e.message)
        }

        MobileCore.start(null)
    }

}