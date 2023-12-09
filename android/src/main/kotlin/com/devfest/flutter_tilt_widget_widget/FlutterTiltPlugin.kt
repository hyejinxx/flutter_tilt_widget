package com.devfest2023.flutter_tilt_widget_widget // ktlint-disable package-name

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** FlutterTiltPlugin */
class FlutterTiltPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    private lateinit var gyroscopeChannel: EventChannel
    private lateinit var gyroScopeStreamHandler: StreamHandlerImpl

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)
        channel.setMethodCallHandler(this)

        gyroScopeStreamHandler = StreamHandlerImpl(
            sensorManager = flutterPluginBinding.applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager,
            sensorType = Sensor.TYPE_GYROSCOPE,
            updateInterval = 200,
        )
        gyroscopeChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, GYROSCOPE_CHANNEL_NAME)
        gyroscopeChannel.setStreamHandler(gyroScopeStreamHandler)
    }

    companion object {
        private const val GYROSCOPE_CHANNEL_NAME = "flutter_tilt_widget_event_channel"
        private const val METHOD_CHANNEL_NAME = "flutter_tilt_widget_method_channel"
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    private fun teardownEventChannels() {
        gyroscopeChannel.setStreamHandler(null)
        gyroScopeStreamHandler.onCancel(null)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        teardownEventChannels()
    }


}
