import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/community/community_repository.dart';
import 'package:workit/models/community.dart';

final communitiesStateNotifierProvider =
    StateNotifierProvider<CommunitiesNotifier, List<Community>>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunitiesNotifier(communityRepository);
});

class CommunitiesNotifier extends StateNotifier<List<Community>> {
  final CommunityRepository _communityRepository;

  CommunitiesNotifier(this._communityRepository) : super([]);

  Future<void> addCommunity(Community community)
  async {
    await _communityRepository.addCommunityToDatabase(community);
    state = [...state, community];
  }

  Future<void> getAllCommunityFromDatabase()
  async {
    state = await _communityRepository.getAllCommunitiesFromDatabase();
  }

  Future<Community> getCommunityById(String communityId)
  async {
    final communityDoc = await _communityRepository.getCommunityById(communityId);
    return Community.fromMap(communityDoc.data()!);
  }

  Community getCommunityFromState(String communityId)
  {
     return state.firstWhere((community) => community.id == communityId);
  }


  Future<void> _updateLocalCommunity() async
  {
    Community updateCommunity = await _communityRepository.getSelectedCommunity();

    state = state.map((community) {
      if (community.id == updateCommunity.id)
      {
        return updateCommunity;
      }
      return community;
    }).toList();   
  }  

  Future<void> updateCommunity(Map<String, dynamic> map) async
  {
    await _communityRepository.updateCommunityDetail(map);
    await _updateLocalCommunity();
  }
}


