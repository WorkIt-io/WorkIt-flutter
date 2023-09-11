import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/providers/search_notifier.dart';

class SearchTextFiled extends ConsumerStatefulWidget {
  const SearchTextFiled({
    super.key,
  });

  @override
  ConsumerState<SearchTextFiled> createState() => _SearchTextFiledState();
}

class _SearchTextFiledState extends ConsumerState<SearchTextFiled> {

  late final TextEditingController controller;
  late final FocusNode _focusNode;

  @override
  void initState() {    
    super.initState();
    controller = TextEditingController();
    _focusNode = FocusNode();
  }
  

  @override
  Widget build(BuildContext context) {
    Timer? timer;

    if (ref.watch(isSelectingProvider) == false)
    {
      controller.clear();
      _focusNode.unfocus();
    }    
    
    return Padding(      
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller,
        focusNode: _focusNode,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
          suffixIcon: const Icon(Icons.search),
          fillColor: Colors.white70,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[500]!),
          ),
        ),
        onTap: () => ref.read(isSelectingProvider.notifier).state = true,
        onChanged: (value) {
          if (timer?.isActive ?? false) {
            timer!.cancel();
          }
          timer = Timer(const Duration(milliseconds: 800), () {
            if (value.isNotEmpty) {
              ref.read(searchNotifierProvider.notifier).search(value);
            } else {
              ref.read(searchNotifierProvider.notifier).reset();
            }
          });
        },
      ),
    );
  }
}
