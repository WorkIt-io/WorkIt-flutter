import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/colors.dart';
import 'package:workit/providers/search_notifier.dart';
import 'package:workit/screens/model_column_search.dart';

class CategoryRow extends ConsumerWidget {
  const CategoryRow(this.categories, {super.key});

  final List<String> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 125,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref
                  .read(searchNotifierProvider.notifier)
                  .searchByCategory(categories[index]);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ModelColumnSearch(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Container(
                width: 100,
                decoration: BoxDecoration(                  
                  color: lightColor,

                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  categories[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
