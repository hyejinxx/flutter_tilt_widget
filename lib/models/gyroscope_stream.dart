import 'package:flutter/services.dart';

import 'gyroscope_event.dart';

/// A class that exposes a [Stream] of gyroscope events.
class GyroscopeStream {
  static final GyroscopeStream _instance = GyroscopeStream._internal();

  factory GyroscopeStream() {
    return _instance;
  }

  GyroscopeStream._internal();

  /// The event channel used to interact with the native platform.
  /// This is the channel that will be used to receive gyroscope events.
  final EventChannel _gyroscopeEventChannel =
      const EventChannel('flutter_tilt_widget_event_channel');

  /// Returns a [Stream] of gyroscope events.
  Stream<GyroscopeEvent>? get gyroscopeStream {
    return _gyroscopeEventChannel.receiveBroadcastStream().map((dynamic event) {
      final list = event.cast<double>();

      return GyroscopeEvent(x: list[0] ?? 0, y: list[1] ?? 0, z: list[2] ?? 0);
    });
  }
}
