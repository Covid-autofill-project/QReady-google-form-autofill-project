import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

// User informatino Storage Class
@JsonSerializable(explicitToJson: true)
class Content {
  String name = "";
  String phone = "";
  String email = "";
  String id = "";

  Content(this.name, this.phone, this.email, this.id);

  Content.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        id = json['id'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'phone': phone, 'email': email, 'id': id};
}

// Json File Storeage Definition
class ContentStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/content.json');
  }

  Future<Content> readContent() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      Map<String, dynamic> infoMap = jsonDecode(contents);
      return Content.fromJson(infoMap);
    } catch (e) {
      // If encountering an error, return 0
      print("Error");
      return new Content("", "", "", "");
    }
  }

  Future<File> writeContent(Content info) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(jsonEncode(info));
  }
}
