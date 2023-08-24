import 'package:flutter/material.dart';

import '../widgets/business/add/form_add_business.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        appBar: AppBar(
          title: const Text("Add Your Business"),
          backgroundColor: Colors.blueGrey[500],
        ),
        backgroundColor: Colors.grey[200],
        body: const FormAddBusiness());
  }
}

