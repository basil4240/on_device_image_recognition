import 'package:bloc/bloc.dart';
import 'package:on_device_image_recognition/features/gallery/domain/repositories/catalog_repository.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_event.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final CatalogRepository repository;

  GalleryBloc({required this.repository}) : super(GalleryInitial()) {
    on<LoadGallery>(_onLoadGallery);
    on<DeleteItem>(_onDeleteItem);
  }

  void _onLoadGallery(
    LoadGallery event,
    Emitter<GalleryState> emit,
  ) async {
    emit(GalleryLoading());
    final result = await repository.getCatalogedItems();
    result.fold(
      (failure) => emit(GalleryError(failure: failure)),
      (items) => emit(GalleryLoaded(items: items)),
    );
  }

  void _onDeleteItem(
    DeleteItem event,
    Emitter<GalleryState> emit,
  ) async {
    await repository.deleteCatalogedItem(event.imagePath);
    add(LoadGallery()); // Reload the gallery after deletion
  }
}
