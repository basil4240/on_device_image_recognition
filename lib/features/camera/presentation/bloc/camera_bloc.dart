import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:on_device_image_recognition/features/camera/presentation/bloc/camera_event.dart';
import 'package:on_device_image_recognition/features/camera/presentation/bloc/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? _controller;

  CameraBloc() : super(CameraInitial()) {
    on<InitializeCamera>(_onInitializeCamera);
    on<CaptureImage>(_onCaptureImage);
  }

  void _onInitializeCamera(
    InitializeCamera event,
    Emitter<CameraState> emit,
  ) async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(const CameraFailure('No cameras found'));
        return;
      }
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
      emit(CameraReady(_controller!));
    } catch (e) {
      emit(CameraFailure(e.toString()));
    }
  }

  void _onCaptureImage(
    CaptureImage event,
    Emitter<CameraState> emit,
  ) async {
    if (_controller == null || !_controller!.value.isInitialized) {
      emit(const CameraFailure('Camera not initialized'));
      return;
    }
    emit(CameraCaptureInProgress());
    try {
      final image = await _controller!.takePicture();
      emit(CameraCaptureSuccess(image.path));
    } catch (e) {
      emit(CameraFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
