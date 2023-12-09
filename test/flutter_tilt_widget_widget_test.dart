import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tilt_widget/flutter_tilt_method_channel.dart';
import 'package:flutter_tilt_widget/flutter_tilt_platform_interface.dart';
import 'package:flutter_tilt_widget/models/gyroscope_event.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTiltPlatform
    with MockPlatformInterfaceMixin
    implements FlutterTiltPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<GyroscopeEvent?> getGyroscope() {
    // TODO: implement getGyroscope
    throw UnimplementedError();
  }

  @override
  // TODO: implement gyroscopeStream
  Stream<GyroscopeEvent> get gyroscopeStream => throw UnimplementedError();
}

void main() {
  final FlutterTiltPlatform initialPlatform = FlutterTiltPlatform.instance;

  test('$MethodChannelFlutterTilt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTilt>());
  });

  test('getPlatformVersion', () async {});
}
