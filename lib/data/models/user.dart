import 'package:flutter/material.dart';

class User {
  final String name;
  final String address;

  User({required this.name, required this.address});

  static User mockUser() {
    return User(name: "John Doe", address: "123 Green Street, NY");
  }
}
