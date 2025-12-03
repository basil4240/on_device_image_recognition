import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:on_device_image_recognition/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:on_device_image_recognition/features/camera/presentation/bloc/camera_event.dart';
import 'package:on_device_image_recognition/features/camera/presentation/bloc/camera_state.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(InitializeCamera()),
      child: BlocListener<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is CameraFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is CameraCaptureSuccess) {
            context.go('/classify', extra: state.path);
          }
        },
        child: const _CameraView(),
      ),
    );
  }
}

class _CameraView extends StatelessWidget {
  const _CameraView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture')),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is CameraReady) {
            return CameraPreview(state.controller);
          } else if (state is CameraFailure) {
            return Center(child: Text(state.error));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CameraBloc>().add(CaptureImage()),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

