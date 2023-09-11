import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:workit/models/business.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/search_notifier.dart';
import 'package:workit/widgets/home/business/business_card.dart';
import 'package:workit/widgets/home/community/community_card.dart';

class ModelColumnSearch extends ConsumerWidget {
  const ModelColumnSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Object> result = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: result.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            )
          : ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                if (result[index] is BusinessModel) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: BusinessCard(result[index] as BusinessModel, addShadow: true,),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: CommunityCard(result[index] as Community),
                  );
                }
              },
            ),
    );
  }
}
