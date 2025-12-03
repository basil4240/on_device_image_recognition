import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class LoadGallery extends GalleryEvent {}

class DeleteItem extends GalleryEvent {
  final String imagePath;

  const DeleteItem({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
