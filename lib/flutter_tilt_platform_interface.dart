import 'package:flutter_tilt_widget_widget/models/gyroscope_event.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_tilt_method_channel.dart';

abstract class FlutterTiltPlatform extends PlatformInterface {
  /// Constructs a FlutterTiltPlatform.
  FlutterTiltPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterTiltPlatform _instance = MethodChannelFlutterTilt();

  /// The default instance of [FlutterTiltPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterTilt].
  static FlutterTiltPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterTiltPlatform] when
  /// they register themselves.
  static set instance(FlutterTiltPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<GyroscopeEvent?> getGyroscope() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<GyroscopeEvent> get gyroscopeStream {
    throw UnimplementedError('gyroscopeStream has not been implemented.');
  }
}
