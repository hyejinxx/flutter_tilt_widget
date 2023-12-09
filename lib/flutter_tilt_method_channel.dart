import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_tilt_platform_interface.dart';
import 'models/gyroscope_event.dart';

/// An implementation of [FlutterTiltPlatform] that uses method channels.
class MethodChannelFlutterTilt extends FlutterTiltPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('flutter_tilt_widget_method_channel');

  /// Returns a [Future] with the platform version.
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Returns a [Future] with the gyroscope event.
  @override
  Future<GyroscopeEvent?> getGyroscope() async {
    final gyroscope =
        await methodChannel.invokeMethod<GyroscopeEvent>('getGyroscope');
    return gyroscope;
  }
}
