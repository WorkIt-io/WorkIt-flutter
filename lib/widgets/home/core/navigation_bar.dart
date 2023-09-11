import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/providers/search_notifier.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.onSelectItem,
  });

  final void Function(int index) onSelectItem;

  @override
  ConsumerState<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
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
          icon: Icon(Icons.search_sharp, size: 30,),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Communities',
        ),
      ],
      onTap: (index) {   
        ref.read(isSelectingProvider.notifier).state = false;   
        ref.read(searchNotifierProvider.notifier).reset();  
        setState(() {
          currentFeedIndex = index;
        });
        widget.onSelectItem(index);
      },
    );
  }
}
