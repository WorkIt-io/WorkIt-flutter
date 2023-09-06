import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/community/community_id.dart';


final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository(FirebaseFirestore.instance, ref);
});


class CommunityRepository {
  final FirebaseFirestore firestore;
  final ProviderRef _ref;

  CommunityRepository(this.firestore, this._ref);

  String get path => 'communities/${_ref.read(communityIdProvider)}';
  String get basePath => 'communities';



  Future<List<Community>> getAllCommunitiesFromDatabase() async {
    List<Community> communityList = [];
    final QuerySnapshot<Map<String, dynamic>> collection =
        await firestore.collection(basePath).get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> communityDoc
        in collection.docs) {
      Map<String, dynamic> map = communityDoc.data();
      Community community = Community.fromMap(map);
      communityList.add(community);
    }

    return communityList;
  }

  Future<Community> getSelectedCommunity() async {
    final DocumentReference<Map<String, dynamic>> ref = firestore.doc(path);

    final doc = await ref.get();

    if (doc.exists) {
      return Community.fromMap(doc.data()!);
    } else {
      throw Exception("no Community id found");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCommunityById(
      String communityId) async {
    final DocumentReference<Map<String, dynamic>> ref =
        firestore.collection(basePath).doc(communityId);
    final doc = await ref.get();

    if (doc.exists) {
      return doc;
    } else {
      throw Exception("no Community id found");
    }
  }  

  Future<void> addCommunityToDatabase(Community community) async {
    final DocumentReference<Map<String, dynamic>> ref =
        firestore.collection(basePath).doc(community.id);

    final doc = await ref.get();

    if (!doc.exists) {
      return await ref.set(community.toMap());
    } else {
      throw Exception("Community already exists");
    }
  }

  Future<void> updateCommunityDetail(Map<String, dynamic> map) async {
    final DocumentReference<Map<String, dynamic>> ref = firestore.doc(path);
    final doc = await ref.get();

    if (doc.exists) {
      final communityMap = doc.data()!;
      map.forEach((key, value) async {
        if (communityMap.containsKey(key)) {
          if (key == 'images') {
            communityMap[key].isEmpty
                ? await ref.update({
                    key: value is List ? value : [value]
                  })
                : await ref.update({
                    key: value is List ? value : [...communityMap[key], value]
                  });
          } else {
            await ref.update({key: value});
          }
        } else {
          throw Exception("no such key named: $key");
        }
      });
    } else {
      throw Exception("there is not such Community");
    }
  }
}
