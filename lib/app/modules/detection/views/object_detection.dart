import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class ObjectDetection {
  late Interpreter _interpreter;
  late List<String> _labels;
  bool _isModelLoaded = false;
  List<dynamic>? _recognitions;

  Future<void> loadModel() async {
    try {
      final interpreterOptions = InterpreterOptions();
      _interpreter = await Interpreter.fromAsset('assets/x/gas.tflite',
          options: interpreterOptions);
      _labels = await loadLabels();
      _isModelLoaded = true;
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  Future<List<String>> loadLabels() async {
    try {
      String labelsPath =
          'assets/x/classes.txt'; // Ubah sesuai dengan path file yang benar
      String labelsContent = await rootBundle.loadString(labelsPath);
      List<String> labels = labelsContent.split('\n');
      return labels;
    } catch (e) {
      print('Error loading labels: $e');
      return [];
    }
  }

  Future<void> detectObjects(CameraImage cameraImage) async {
    if (!_isModelLoaded) {
      return;
    }

    // Preprocess the camera image
    var inputImage = preprocessCameraImage(cameraImage);

    // Run inference
    var output = runInference(inputImage);

    // Postprocess the output
    var recognitions = postprocessOutput(output);

    // Set the recognitions
    _setRecognitions(recognitions);
  }

  dynamic preprocessCameraImage(CameraImage cameraImage) {
    // Implement preprocessing logic here
    // Convert cameraImage to a format that can be used by the model
    // Example: convert to TensorImage or Bitmap
    // Return the preprocessed image
  }

  dynamic runInference(dynamic inputImage) {
    // Implement inference logic here
    // Run the model inference on the preprocessed image
    // Return the output of the inference
  }

  List<dynamic> postprocessOutput(dynamic output) {
    // Implement postprocessing logic here
    // Process the output of the inference and convert it into a list of recognitions
    // Each recognition should contain label, confidence, and bounding box coordinates
    // Return the list of recognitions
    return []; // Ganti dengan implementasi sesuai kebutuhan Anda
  }

  void _setRecognitions(List<dynamic> recognitions) {
    _recognitions = recognitions;
    print("NGENTSOT $_recognitions"); // Cetak hasil deteksi ke dalam debug console
  }

  List<dynamic> getRecognitions() {
    return _recognitions ?? [];
  }
}