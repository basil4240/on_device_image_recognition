import 'package:equatable/equatable.dart';

abstract class ClassificationEvent extends Equatable {
  const ClassificationEvent();

  @override
  List<Object> get props => [];
}

class ClassifyImage extends ClassificationEvent {
  final String imagePath;

  const ClassifyImage({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
