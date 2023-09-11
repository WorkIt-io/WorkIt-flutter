

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/business.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/business/businesses_notifier.dart';
import 'package:workit/providers/community/communities_notifier.dart';

class SearchNotifier extends StateNotifier<List<Object>> {
  SearchNotifier(this.ref): super([]);
  
  final StateNotifierProviderRef ref;

  bool _isSearch = false;  
  bool get isSearch => _isSearch;

  List<BusinessModel>? businesses;  
  List<Community>? communities;  

  

  @override
  void dispose() {
    state = [];
    super.dispose();
  }

   searchByCategory(String type)
  {
    _isSearch = true;
    _getLocalData();
    List<BusinessModel> resBusiness = businesses!.where((element) => element.category.compareTo(type) == 0).toList();
    List<Community> resCommunity = communities!.where((element) => element.category.compareTo(type) == 0).toList();  
    List<Object> combiendList = [...resBusiness , ...resCommunity];    
    state = combiendList;
    _isSearch = false;
  }

  search(String query)
  {
    _isSearch = true;
    _getLocalData();
    List<BusinessModel> resBusiness = businesses!.where((element) => element.name.contains(query) || query.contains(element.name)).toList();
    List<Community> resCommunity = communities!.where((element) => element.name.contains(query) || query.contains(element.name)).toList();  
    List<Object> combiendList = [...resBusiness , ...resCommunity];
    state = combiendList;
    _isSearch = false;
  }

  void reset()
  {
    state = [];
  }



  void _getLocalData()
  {
    businesses ??= ref.read(businessesStateNotifierProvider);
    communities ??= ref.read(communitiesStateNotifierProvider);
  }

}

final searchNotifierProvider = StateNotifierProvider.autoDispose<SearchNotifier, List<Object>>((ref) {
  return SearchNotifier(ref);
});

final isSelectingProvider = StateProvider<bool>((ref) {
  return false;
});