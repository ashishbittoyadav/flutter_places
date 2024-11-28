import 'dart:io';

import 'package:favorite_places/providers/user_place_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddPlaceScreenState();
  }
  // @override
  // State<AddPlaceScreen> createState() {
  //   return _AddPlaceScreenState();
  // }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  String? _selectedAddress;

  void _addPlace() {
    if (_titleController == null || _titleController.text.isEmpty || _selectedImage==null) {
      return;
    }

    ref
        .read(userPlaceProvider.notifier)
        .addPlace(_titleController.text, _selectedImage!,_selectedAddress!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place.'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Place'),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
            }),
            const SizedBox(height: 16,),
            LocationInput(onSelectAddress: (address) { _selectedAddress = address; },),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _addPlace,
              label: const Text(
                'add place',
              ),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
