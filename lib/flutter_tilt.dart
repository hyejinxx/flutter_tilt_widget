import 'package:flutter/material.dart';
import 'package:flutter_tilt_widget/models/gyroscope_event.dart';
import 'package:flutter_tilt_widget/models/gyroscope_stream.dart';

/// FlutterTilt widget
class FlutterTilt extends StatefulWidget {
  const FlutterTilt({Key? key, required this.child}) : super(key: key);

  /// The Target Widget
  final Widget child;

  @override
  _FlutterTiltState createState() => _FlutterTiltState();
}

class _FlutterTiltState extends State<FlutterTilt> {
  /// Instance of the GyroscopeStream class
  final GyroscopeStream _gyroscopeStreamClass = GyroscopeStream();
  /// Matrix4 to apply the transform
  final matrix = Matrix4.identity();

  @override
  void initState() {
    super.initState();

    /// Start the gyroscope stream
    _gyroscopeStreamClass.gyroscopeStream?.listen((event) {
      setMatrixTransform(event);
    });
  }

  /// Set the matrix transform to the container
  setMatrixTransform(GyroscopeEvent event) {
    setState(() {
      matrix.setRotationX(event.x * 0.2);
      matrix.setRotationY(event.y * 0.2);
      matrix.setRotationZ(event.z * 0.2);
      matrix.translate(event.x * 10, event.y * 10, event.z * 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: Container(child: widget.child),
    );
  }
}
