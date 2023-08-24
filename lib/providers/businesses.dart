import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/business_repository.dart';
import 'package:workit/models/business.dart';

class BusinessesNotifier extends StateNotifier<List<BusinessModel>> {
  final BusinessRepository businessRepository;

  BusinessesNotifier(this.businessRepository) : super([]);

  setBusinesses()
  async {
    List<BusinessModel> list = await businessRepository.getAllBusinessFromDatabase();
    state = list;
  }
}

final communitiesProvider =
    StateNotifierProvider<BusinessesNotifier, List<BusinessModel>>((ref) {
  final businessRepository = ref.watch(businessRepositoryProvider);
  return BusinessesNotifier(businessRepository);
});
