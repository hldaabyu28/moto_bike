// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({
    Key? key,
    required this.uid,
    required this.userName,
  }) : super(key: key);
  final String uid;
  final String userName;
  
  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}