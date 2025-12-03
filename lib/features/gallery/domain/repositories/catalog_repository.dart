import 'package:dartz/dartz.dart';
import 'package:on_device_image_recognition/core/errors/failures.dart';
import 'package:on_device_image_recognition/features/gallery/domain/entities/cataloged_item.dart';

abstract class CatalogRepository {
  Future<Either<Failure, void>> saveCatalogedItem(CatalogedItem item);
  Future<Either<Failure, List<CatalogedItem>>> getCatalogedItems();
  Future<Either<Failure, void>> deleteCatalogedItem(String imagePath);
}
