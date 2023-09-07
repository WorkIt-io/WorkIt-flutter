import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.onSelectItem, });

  final void Function(int index) onSelectItem;
  
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  var currentFeedIndex = 0;

  @override
  void initState() {    
    super.initState();
    currentFeedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentFeedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Communities',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentFeedIndex = index;
          });
          widget.onSelectItem(index);
        },
      );
  }
}