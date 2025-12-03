import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_event.dart';
import 'package:on_device_image_recognition/features/classification/presentation/bloc/classification_state.dart';
import 'package:on_device_image_recognition/core/service_locator.dart'; // Import service locator
import 'package:go_router/go_router.dart';

class ClassificationResultPage extends StatefulWidget {
  final String imagePath;

  const ClassificationResultPage({super.key, required this.imagePath});

  @override
  State<ClassificationResultPage> createState() => _ClassificationResultPageState();
}

class _ClassificationResultPageState extends State<ClassificationResultPage> {
  String? _selectedTag;
  final TextEditingController _customTagController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _customTagController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classification Results'),
      ),
      body: BlocProvider<ClassificationBloc>(
        create: (context) => sl<ClassificationBloc>()
          ..add(ClassifyImage(imagePath: widget.imagePath)),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocBuilder<ClassificationBloc, ClassificationState>(
                      builder: (context, state) {
                        if (state is ClassificationLoading) {
                          return const Expanded(child: Center(child: CircularProgressIndicator()));
                        } else if (state is ClassificationLoaded) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.results.length,
                              itemBuilder: (context, index) {
                                final result = state.results[index];
                                return RadioListTile<String>(
                                  title: Text(result.label),
                                  subtitle: Text('${(result.confidence * 100).toStringAsFixed(2)}%'),
                                  value: result.label,
                                  groupValue: _selectedTag,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedTag = value;
                                      _customTagController.clear(); // Clear custom tag if a suggested one is selected
                                    });
                                  },
                                );
                              },
                            ),
                          );
                        } else if (state is ClassificationError) {
                          return Expanded(child: Center(child: Text('Error: ${state.failure}')));
                        } else {
                          return const Expanded(child: Center(child: Text('Press the button to classify the image.')));
                        }
                      },
                    ),
                    const Divider(),
                    TextField(
                      controller: _customTagController,
                      decoration: const InputDecoration(
                        labelText: 'Or enter a custom tag',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedTag = value; // Use custom tag as selected tag
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Add notes (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedTag != null && _selectedTag!.isNotEmpty) {
                          // TODO: Implement save logic (Phase 5)
                          print('Saving: Tag - $_selectedTag, Notes - ${_notesController.text}');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Saving "$_selectedTag" with notes: "${_notesController.text}"')),
                          );
                          context.go('/'); // Go back to home for now
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select or enter a tag.')),
                          );
                        }
                      },
                      child: const Text('Save Item'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

