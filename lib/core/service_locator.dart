import 'package:get_it/get_it.dart';
import 'package:on_device_image_recognition/features/classification/data/repositories/tflite_image_classification_repository_impl.dart';
import 'package:on_device_image_recognition/features/classification/domain/repositories/image_classification_repository.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:on_device_image_recognition/features/gallery/data/repositories/hive_catalog_repository_impl.dart';
import 'package:on_device_image_recognition/features/gallery/domain/repositories/catalog_repository.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_bloc.dart';

final GetIt sl = GetIt.instance; // sl is short for Service Locator

void init() {
  // Features - Classification
  sl.registerFactory(() => ClassificationBloc(repository: sl()));

  sl.registerLazySingleton<ImageClassificationRepository>(
    () => TfliteImageClassificationRepositoryImpl(),
  );

  // Features - Gallery
  sl.registerFactory(() => GalleryBloc(repository: sl()));

  sl.registerLazySingleton<CatalogRepository>(
    () => HiveCatalogRepositoryImpl(),
  );

  // You can register other dependencies here as needed
}
