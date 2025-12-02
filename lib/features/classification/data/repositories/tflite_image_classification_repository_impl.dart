import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:on_device_image_recognition/core/errors/failures.dart';
import 'package:on_device_image_recognition/features/classification/domain/entities/classification_result.dart';
import 'package:on_device_image_recognition/features/classification/domain/repositories/image_classification_repository.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TfliteImageClassificationRepositoryImpl implements ImageClassificationRepository {
  static const String _modelPath = 'assets/ml/MobileNet-v2.tflite';
  static const String _labelsPath = 'assets/ml/labels.txt';

  Interpreter? _interpreter;
  List<String>? _labels;

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(_modelPath);
      final labelsData = await rootBundle.loadString(_labelsPath);
      _labels = labelsData.split('\n');
    } catch (e) {
      // Handle model loading failure
    }
  }

  @override
  Future<Either<Failure, List<ClassificationResult>>> classifyImage(String imagePath) async {
    if (_interpreter == null || _labels == null) {
      await _loadModel();
      if (_interpreter == null || _labels == null) {
        return Left(TfliteFailure());
      }
    }

    try {
      final imageBytes = await File(imagePath).readAsBytes();
      final image = img.decodeImage(imageBytes)!;

      final inputSize = _interpreter!.getInputTensor(0).shape[1];
      final resizedImage = img.copyResize(image, width: inputSize, height: inputSize);

      final imageBuffer = Float32List(1 * inputSize * inputSize * 3);
      int bufferIndex = 0;
      for (int y = 0; y < resizedImage.height; y++) {
        for (int x = 0; x < resizedImage.width; x++) {
          final pixel = resizedImage.getPixel(x, y);
          imageBuffer[bufferIndex++] = (pixel.r - 127.5) / 127.5;
          imageBuffer[bufferIndex++] = (pixel.g - 127.5) / 127.5;
          imageBuffer[bufferIndex++] = (pixel.b - 127.5) / 127.5;
        }
      }
      
      final input = imageBuffer.reshape([1, inputSize, inputSize, 3]);
      final output = List.filled(1 * _labels!.length, 0.0).reshape([1, _labels!.length]);

      _interpreter!.run(input, output);

      final results = <ClassificationResult>[];
      for (var i = 0; i < output[0].length; i++) {
        if (output[0][i] > 0.5) { // Confidence threshold
          results.add(
            ClassificationResult(
              label: _labels![i],
              confidence: output[0][i],
            ),
          );
        }
      }

      results.sort((a, b) => b.confidence.compareTo(a.confidence));

      return Right(results);
    } catch (e) {
      return Left(TfliteFailure());
    }
  }
}
