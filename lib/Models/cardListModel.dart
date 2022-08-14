import 'package:flutter/material.dart';

class CardListModel {
  String userid;
  String firstName;
  String surname;
  String? imageUrl;
  Color? spaceColor;

  CardListModel({
    required this.userid,
    required this.firstName,
    required this.surname,
    this.imageUrl,
    this.spaceColor,
  });
}
