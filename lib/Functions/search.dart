import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/user.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future searchAll(String query) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/search?q=$query'));

  List<SearchData> committees = [];
  List<SearchData> events = [];

  var decodedData = jsonDecode(response.body);

  decodedData['events'].forEach((e) =>
      events.add(SearchData(id: e['_id'], name: e['name'], photo: e['photo'])));
  decodedData['committees'].forEach((e) => committees
      .add(SearchData(id: e['_id'], name: e['name'], photo: e['photo'])));
  print(committees.length);
  ListBox listBox = ListBox(committees: committees, events: events);
  return listBox;
}

class ListBox {
  List<SearchData> committees;
  List<SearchData> events;
  ListBox({
    required this.committees,
    required this.events,
  });
}

class SearchData {
  String photo;
  String id;
  String name;
  SearchData({
    required this.photo,
    required this.id,
    required this.name,
  });

  SearchData copyWith({
    String? photo,
    String? id,
    String? name,
  }) {
    return SearchData(
      photo: photo ?? this.photo,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'id': id,
      'name': name,
    };
  }

  factory SearchData.fromMap(Map<String, dynamic> map) {
    return SearchData(
      photo: map['photo'],
      id: map['_id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchData.fromJson(String source) =>
      SearchData.fromMap(json.decode(source));
}
