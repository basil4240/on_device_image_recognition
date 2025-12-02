import 'package:bloc/bloc.dart';
import 'package:on_device_image_recognition/features/classification/domain/repositories/image_classification_repository.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_event.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_state.dart';

class ClassificationBloc extends Bloc<ClassificationEvent, ClassificationState> {
  final ImageClassificationRepository repository;

  ClassificationBloc({required this.repository}) : super(ClassificationEmpty()) {
    on<ClassifyImage>(_onClassifyImage);
  }

  void _onClassifyImage(
    ClassifyImage event,
    Emitter<ClassificationState> emit,
  ) async {
    emit(ClassificationLoading());
    final result = await repository.classifyImage(event.imagePath);
    result.fold(
      (failure) => emit(ClassificationError(failure: failure)),
      (results) => emit(ClassificationLoaded(results: results)),
    );
  }
}
