// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

import 'package:flutter/material.dart';

class CardListModel {
  String? userid;
  String? firstName;
  String? surname;
  late String imageUrl;
  late Color spaceColor;

  CardListModel({
    this.userid,
    this.firstName,
    this.surname,
    required this.imageUrl,
    required this.spaceColor,
  });

  CardListModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    firstName = json['firstName'];
    surname = json['surname'];
    imageUrl = json['imageUrl'];
    spaceColor = json['spaceColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
