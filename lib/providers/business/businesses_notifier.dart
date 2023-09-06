import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/business/business_repository.dart';
import 'package:workit/models/business.dart';

final businessesStateNotifierProvider =
    StateNotifierProvider<BusinessesNotifier, List<BusinessModel>>((ref) {
  final businessRepository = ref.watch(businessRepositoryProvider);
  return BusinessesNotifier(businessRepository);
});

class BusinessesNotifier extends StateNotifier<List<BusinessModel>> {
  final BusinessRepository _businessRepository;

  BusinessesNotifier(this._businessRepository) : super([]);

  Future<void> addBusiness(BusinessModel business)
  async {
    await _businessRepository.addBusinessToDatabase(business);
    state = [...state, business];
  }

  Future<void> getAllBusinessFromDatabase()
  async {
    state = await _businessRepository.getAllBusinessFromDatabase();
  }

  Future<BusinessModel> getBusinessById(String businessId)
  async {
    final businessDoc = await _businessRepository.getBusinessById(businessId);
    return BusinessModel.fromMap(businessDoc.data()!);
  }

  BusinessModel getBusinessFromState(String businessId)
  {
     return state.firstWhere((business) => business.id == businessId);
  }


  Future<void> _updateLocalBusiness() async
  {
    BusinessModel updateBusiness = await _businessRepository.getSelectedBusiness();        

    state = state.map((business) {
      if (business.id == updateBusiness.id)
      {
        return updateBusiness;
      }
      return business;
    }).toList();   
  }  

  Future<void> updateBusiness(Map<String, dynamic> map) async
  {
    await _businessRepository.updateBusinessDetail(map);
    await _updateLocalBusiness();
  }
}


