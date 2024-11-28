import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key, required this.onSelectAddress});

  final void Function(String address) onSelectAddress;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  String? _currentAddress;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      _isGettingLocation = false;
    });

    await geocoding.GeocodingPlatform.instance
        ?.placemarkFromCoordinates(
            locationData.latitude!, locationData.longitude!)
        .then((place) {
      setState(() {
        _currentAddress =
            '${place[0].street} ${place[0].subLocality} ${place[0].locality} ${place[0].postalCode} ${place[0].administrativeArea} ${place[0].country}';

            widget.onSelectAddress(_currentAddress!);
      });
    });

    // if (kDebugMode) {
    //   print('hello address');
    //   print(address[0]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Widget _previewContent = Text(
      'No location selected',
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.primary),
      textAlign: TextAlign.center,
    );

    if (_isGettingLocation) {
      _previewContent = const CircularProgressIndicator();
    }

    if (_currentAddress != null) {
      _previewContent = Text(
        _currentAddress!,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: _previewContent,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text(
                'get current location',
              ),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text(
                'pick on the map',
              ),
              icon: const Icon(Icons.map),
            )
          ],
        ),
      ],
    );
  }
}
