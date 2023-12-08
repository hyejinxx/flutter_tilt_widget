import 'package:flutter/services.dart';

import 'gyroscope_event.dart';

class GyroscopeStream {
  static final GyroscopeStream _instance = GyroscopeStream._internal();

  factory GyroscopeStream() {
    return _instance;
  }

  GyroscopeStream._internal();

  final EventChannel _gyroscopeEventChannel =
      const EventChannel('flutter_tilt_widget_event_channel');

  Stream<GyroscopeEvent>? get gyroscopeStream {
    return _gyroscopeEventChannel.receiveBroadcastStream().map((dynamic event) {
      final list = event.cast<double>();

      return GyroscopeEvent(x: list[0] ?? 0, y: list[1] ?? 0, z: list[2] ?? 0);
    });
  }
}
