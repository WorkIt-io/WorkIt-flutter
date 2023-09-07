import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({super.key});

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("user screen"),
      ),
    );
  }
}
