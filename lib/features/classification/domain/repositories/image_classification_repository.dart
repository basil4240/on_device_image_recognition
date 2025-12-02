import 'package:dartz/dartz.dart';
import 'package:on_device_image_recognition/core/errors/failures.dart';
import 'package:on_device_image_recognition/features/classification/domain/entities/classification_result.dart';

abstract class ImageClassificationRepository {
  Future<Either<Failure, List<ClassificationResult>>> classifyImage(String imagePath);
}
