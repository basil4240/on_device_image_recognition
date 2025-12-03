import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object?> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;

  const CameraReady(this.controller);

  @override
  List<Object?> get props => [controller];
}

class CameraFailure extends CameraState {
  final String error;

  const CameraFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CameraCaptureSuccess extends CameraState {
  final String path;

  const CameraCaptureSuccess(this.path);

  @override
  List<Object?> get props => [path];
}

class CameraCaptureInProgress extends CameraState {}
