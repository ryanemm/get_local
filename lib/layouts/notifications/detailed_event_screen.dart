import 'package:flutter/material.dart';

class DetailedEventScreen extends StatefulWidget {
  final String title;
  final String detailedContent;
  final String dateTimestamp;
  const DetailedEventScreen({super.key, required this.title, required this.detailedContent, required this.dateTimestamp});

  @override
  State<DetailedEventScreen> createState() => _DetailedEventScreenState();
}

class _DetailedEventScreenState extends State<DetailedEventScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}