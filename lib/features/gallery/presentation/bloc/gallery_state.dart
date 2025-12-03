import 'package:equatable/equatable.dart';
import 'package:on_device_image_recognition/features/gallery/domain/entities/cataloged_item.dart';
import 'package:on_device_image_recognition/core/errors/failures.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<CatalogedItem> items;

  const GalleryLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class GalleryError extends GalleryState {
  final Failure failure;

  const GalleryError({required this.failure});

  @override
  List<Object> get props => [failure];
}
