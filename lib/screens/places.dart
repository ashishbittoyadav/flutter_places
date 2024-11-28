import 'package:favorite_places/providers/user_place_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _ConsumerState();
  }
}

class _ConsumerState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPlaceScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlacesList(places: placesList),
      ),
    );
  }
}
