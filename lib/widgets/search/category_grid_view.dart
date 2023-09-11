import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/categories.dart';
import 'package:workit/providers/search_notifier.dart';

class CategoryGridView extends ConsumerWidget {
  const CategoryGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 2.5,
          mainAxisSpacing: 5),
      itemCount: allCategories.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          ref.read(isSelectingProvider.notifier).state = true;
          ref
              .read(searchNotifierProvider.notifier)
              .searchByCategory(allCategories[index]);
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50), right: Radius.circular(50))),
          alignment: Alignment.center,
          child: Text(
            allCategories[index],
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
