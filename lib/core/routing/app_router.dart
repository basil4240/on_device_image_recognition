import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:on_device_image_recognition/features/home/presentation/pages/home_page.dart';
import 'package:on_device_image_recognition/features/camera/presentation/pages/camera_page.dart';
import 'package:on_device_image_recognition/features/classification/presentation/pages/classification_result_page.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/pages/gallery_page.dart';


final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/camera',
      builder: (BuildContext context, GoRouterState state) {
        return const CameraPage();
      },
    ),
    GoRoute(
      path: '/classify',
      builder: (BuildContext context, GoRouterState state) {
        final String imagePath = state.extra! as String;
        return ClassificationResultPage(imagePath: imagePath);
      },
    ),
    GoRoute(
      path: '/gallery',
      builder: (BuildContext context, GoRouterState state) {
        return const GalleryPage();
      },
    ),
  ],
);

