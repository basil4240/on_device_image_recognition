import 'package:equatable/equatable.dart';
import 'package:on_device_image_recognition/features/classification/domain/entities/classification_result.dart';
import 'package:on_device_image_recognition/core/errors/failures.dart';

abstract class ClassificationState extends Equatable {
  const ClassificationState();

  @override
  List<Object> get props => [];
}

class ClassificationEmpty extends ClassificationState {}

class ClassificationLoading extends ClassificationState {}

class ClassificationLoaded extends ClassificationState {
  final List<ClassificationResult> results;

  const ClassificationLoaded({required this.results});

  @override
  List<Object> get props => [results];
}

class ClassificationError extends ClassificationState {
  final Failure failure;

  const ClassificationError({required this.failure});

  @override
  List<Object> get props => [failure];
}
