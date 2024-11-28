import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    required this.address,
    String? id,
  }) : id = id ?? uuid.v4();

  String id;
  String title;
  String address;
  File image;
}
