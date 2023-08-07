import 'package:flutter/material.dart';
import '../models/business.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessesNotifier extends StateNotifier<List<Business>> {
  BusinessesNotifier(): super([]);

}

final businessesProvider = StateNotifierProvider<BusinessesNotifier, List<Business>>(
  (ref) => BusinessesNotifier(),
);

