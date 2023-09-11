import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:workit/providers/search_notifier.dart';
import 'package:workit/widgets/search/category_grid_view.dart';
import 'package:workit/widgets/search/search_list_tile.dart';
import 'package:workit/widgets/search/search_text_filed.dart';

class SearchFeed extends ConsumerStatefulWidget {
  const SearchFeed({super.key});

  @override
  ConsumerState<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends ConsumerState<SearchFeed> {
  @override
  Widget build(BuildContext context) {
    List<Object> result = ref.watch(searchNotifierProvider);
    bool isSelecting = ref.watch(isSelectingProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchTextFiled(),
          if (!isSelecting)
            ...[const Flexible(
              fit: FlexFit.loose,
              child: CategoryGridView()
            ),
            Lottie.asset('assets/images/animation/search_animation.json',
                height: 350, width: double.infinity),
            ],
          if (result.isEmpty && isSelecting) ...[
            const SizedBox(
              height: 30,
            ),
            Text(
              'Nothing found... keep the search!',
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
            Lottie.asset('assets/images/animation/not_found_animation.json',
                height: 350, width: double.infinity),
          ],
          if (result.isNotEmpty)
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return SearchListTile(result[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}
