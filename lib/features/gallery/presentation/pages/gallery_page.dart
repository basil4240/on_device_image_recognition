import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_device_image_recognition/features/gallery/domain/entities/cataloged_item.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_event.dart';
import 'package:on_device_image_recognition/features/gallery/presentation/bloc/gallery_state.dart';
import 'package:on_device_image_recognition/core/service_locator.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<CatalogedItem> _allItems = [];
  List<CatalogedItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.tag.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GalleryBloc>()..add(LoadGallery()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image Gallery'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search by tag',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<GalleryBloc, GalleryState>(
                listener: (context, state) {
                  if (state is GalleryLoaded) {
                    setState(() {
                      _allItems = state.items;
                      _filteredItems = _allItems;
                      _onSearchChanged(); // Apply search filter
                    });
                  }
                },
                builder: (context, state) {
                  if (state is GalleryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GalleryLoaded) {
                    if (_filteredItems.isEmpty) {
                      return const Center(child: Text('No items found.'));
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text(item.tag),
                            subtitle: Text(item.notes ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                context.read<GalleryBloc>().add(DeleteItem(imagePath: item.imagePath));
                              },
                            ),
                          ),
                          child: Image.file(
                            File(item.imagePath),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  } else if (state is GalleryError) {
                    return Center(child: Text('Error: ${state.failure}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

