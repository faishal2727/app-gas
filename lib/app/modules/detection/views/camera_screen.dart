import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'object_detection.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late ObjectDetection _objectDetection;
  List<dynamic>? _recognitions;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _objectDetection = ObjectDetection();
    _objectDetection.loadModel();

    _controller.initialize().then((_) {
      if (!_isDisposed) {
        setState(() {});
        _controller.startImageStream((cameraImage) {
          _detectObjects(cameraImage);
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  Future<void> _detectObjects(CameraImage cameraImage) async {
    await _objectDetection.detectObjects(cameraImage);

    if (!_isDisposed) {
      setState(() {
        _recognitions = _objectDetection.getRecognitions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        children: [
          CameraPreview(_controller),
          if (_recognitions != null)
            CustomPaint(
              painter: ObjectPainter(
                recognitions: _recognitions!,
                previewSize: Size(
                  _controller.value.previewSize!.height,
                  _controller.value.previewSize!.width,
                ),
                imageSize: Size(
                  _controller.value.previewSize!.height,
                  _controller.value.previewSize!.width,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ObjectPainter extends CustomPainter {
  final List<dynamic> recognitions;
  final Size previewSize;
  final Size imageSize;

  ObjectPainter({
    required this.recognitions,
    required this.previewSize,
    required this.imageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Implement your custom painting logic here
    // Use the canvas and other provided parameters to draw the bounding boxes or overlays on the image
    // Example implementation:
    for (var recognition in recognitions) {
      String label = recognition['label'];
      double confidence = recognition['confidence'];
      dynamic boundingBox = recognition['boundingBox'];

      // Draw the bounding box on the canvas
      // Example code:
      Rect rect = Rect.fromLTRB(
        boundingBox['left'],
        boundingBox['top'],
        boundingBox['right'],
        boundingBox['bottom'],
      );
      Paint paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawRect(rect, paint);

      // Draw label and confidence text
      // Example code:
      TextSpan labelSpan = TextSpan(
        text: '$label (${(confidence * 100).toStringAsFixed(2)}%)',
        style: TextStyle(color: Colors.red, fontSize: 14.0),
      );
      TextPainter labelPainter = TextPainter(
        text: labelSpan,
        textDirection: TextDirection.ltr,
      );
      labelPainter.layout();
      labelPainter.paint(
        canvas,
        Offset(rect.left, rect.top - labelPainter.height - 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}