import 'package:flutter/material.dart';

enum Weather {
  cloudy(icon: Icons.cloud_outlined, label: 'Cloudy'),
  rainy(icon: Icons.beach_access_sharp, label: 'Rainy'),
  sunny(icon: Icons.brightness_5_sharp, label: 'Sunny');

  final IconData icon;
  final String label;

  const Weather({required this.icon, required this.label});
}
