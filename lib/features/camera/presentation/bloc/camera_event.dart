import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class InitializeCamera extends CameraEvent {}

class CaptureImage extends CameraEvent {}
