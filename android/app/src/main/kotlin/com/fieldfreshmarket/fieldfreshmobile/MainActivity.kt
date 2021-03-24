package com.fieldfreshmarket.fieldfreshmobile
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

private const val kchannel = "flavor"
private const val kMethodFlavor = "getFlavor"

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, kchannel).setMethodCallHandler {
            call, result ->
            if (call.method == kMethodFlavor) {
                result.success(BuildConfig.FLAVOR)
            }
        }
    }
}
