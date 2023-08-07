import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/community.dart';

class CommunitiesNotifier extends StateNotifier<List<Community>> {
  CommunitiesNotifier(): super([]);

}

final communitiesProvider = StateNotifierProvider<CommunitiesNotifier, List<Community>>(
  (ref) => CommunitiesNotifier(),
);

