import 'package:flutter/material.dart';

class CommunityDetailScreenAdmin extends StatefulWidget {
  const CommunityDetailScreenAdmin({super.key});

  @override
  State<CommunityDetailScreenAdmin> createState() =>
      _CommunityDetailScreenAdminState();
}

class _CommunityDetailScreenAdminState
    extends State<CommunityDetailScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("admin screen"),
      ),
    );
  }
}
