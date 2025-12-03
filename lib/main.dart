import 'package:flutter/material.dart';
import 'package:on_device_image_recognition/core/routing/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_device_image_recognition/core/service_locator.dart' as sl;
import 'package:on_device_image_recognition/features/gallery/domain/entities/cataloged_item.g.dart'; // Import generated adapter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatalogedItemAdapter()); // Register the generated adapter
  sl.init(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

