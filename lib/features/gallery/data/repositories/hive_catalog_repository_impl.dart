import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_device_image_recognition/core/errors/failures.dart';
import 'package:on_device_image_recognition/features/gallery/domain/entities/cataloged_item.dart';
import 'package:on_device_image_recognition/features/gallery/domain/repositories/catalog_repository.dart';

class HiveCatalogRepositoryImpl implements CatalogRepository {
  static const String _boxName = 'catalogedItems';

  @override
  Future<Either<Failure, void>> saveCatalogedItem(CatalogedItem item) async {
    try {
      final box = await Hive.openBox<CatalogedItem>(_boxName);
      await box.put(item.imagePath, item); // Using imagePath as unique key
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CatalogedItem>>> getCatalogedItems() async {
    try {
      final box = await Hive.openBox<CatalogedItem>(_boxName);
      return Right(box.values.toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCatalogedItem(String imagePath) async {
    try {
      final box = await Hive.openBox<CatalogedItem>(_boxName);
      await box.delete(imagePath);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
