import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/community.dart';
import 'package:workit/widgets/business/detail/location_section.dart';
import 'package:workit/widgets/business/detail/text_section.dart';
import 'package:workit/widgets/community/detail/communitiy_images.dart';
import 'package:workit/widgets/community/detail/participants.dart';

class CommunityDetailScreen extends ConsumerStatefulWidget {
  const CommunityDetailScreen({super.key, required this.community});

  final Community community;

  @override
  ConsumerState<CommunityDetailScreen> createState() =>
      _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.community.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommunityImages(),
            const Divider(),

            // About Section
            TextSection(
              "About",
              widget.community.description,
              theme,
            ),

            const Divider(),

            Participants(widget.community, theme),

            const Divider(),

            LocationSection(widget.community.address, theme),

            const Divider(),

            const SizedBox(height: 10),
            const Text("Coming soon - chat")
          ],
        ),
      ),
    );
  }
}
