import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetail extends StatelessWidget {
  PlacesDetail({super.key, required this.place});

  Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place detail'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Text(
            //   place.title,
            //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //         color: Theme.of(context).colorScheme.error,
            //       ),
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            Hero(
              tag: place,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 45),
                child: Text(
                  place.address,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                        decoration: TextDecoration.underline
                      ),
                      textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
