import 'package:flutter/material.dart';

class SearchTextFiled extends StatelessWidget {
  const SearchTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(             
        style: const TextStyle(fontSize: 20),         
        decoration: InputDecoration(
          hintText: "Search",                            
          hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
          //contentPadding: const EdgeInsets.symmetric(horizontal: 10),              
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
          )
        )                    
      ),
    );
  }
}