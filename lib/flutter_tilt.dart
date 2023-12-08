import 'package:flutter/material.dart';
import 'package:flutter_tilt_widget_widget/models/gyroscope_stream.dart';

class FlutterTilt extends StatefulWidget {
  const FlutterTilt({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _FlutterTiltState createState() => _FlutterTiltState();
}

class _FlutterTiltState extends State<FlutterTilt> {
  final GyroscopeStream _gyroscopeStreamClass = GyroscopeStream();
  final matrix = Matrix4.identity();

  @override
  void initState() {
    super.initState();
    setMatrixTransform();
  }

  setMatrixTransform() {
    _gyroscopeStreamClass.gyroscopeStream?.listen((event) {
      matrix.setRotationX(event.x * 0.2);
      matrix.setRotationY(event.y * 0.2);
      matrix.setRotationZ(event.z * 0.2);
      matrix.translate(event.x * 10, event.y * 10, event.z * 10);
      setState(() {});
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
