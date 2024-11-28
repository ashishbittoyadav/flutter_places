import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  PlacesList({super.key, required this.places});

  List<Place> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'no place added yet.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      );
    }

    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: places[index],
              child: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(places[index].image),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlacesDetail(
                    place: places[index],
                  ),
                ),
              );
            },
            subtitle: Text(
              places[index].address,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          );
        });
  }
}
