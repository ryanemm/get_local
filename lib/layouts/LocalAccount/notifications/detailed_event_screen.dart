import 'package:flutter/material.dart';

class DetailedEventScreen extends StatefulWidget {
  final String title;
  final String notification;
  final String time;
  const DetailedEventScreen({
    super.key,
    required this.title,
    required this.notification,
    required this.time,
  });

  @override
  State<DetailedEventScreen> createState() => _DetailedEventScreenState();
}

class _DetailedEventScreenState extends State<DetailedEventScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
