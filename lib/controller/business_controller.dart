import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/business_repository.dart';
import 'package:workit/models/business.dart';

final businessControllerProvider = Provider<BusinessController>((ref) {
  final businessRepository = ref.watch(businessRepositoryProvider);
  return BusinessController(businessRepository);
});

class BusinessController {
  final BusinessRepository _businessRepository;

  BusinessController(this._businessRepository);

  Future<void> addBusinessToDatabase(BusinessModel business)
  async {
    await _businessRepository.addBusinessToDatabase(business);
  }
}