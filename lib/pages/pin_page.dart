
import 'package:flutter/material.dart';

import 'package:rent_motor/models/bike.dart';

class PINPage extends StatefulWidget {
  const PINPage({
    Key? key,
    required this.bike,
  }) : super(key: key);
  final Bike bike;

  @override
  State<PINPage> createState() => _PINPageState();
}

class _PINPageState extends State<PINPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}