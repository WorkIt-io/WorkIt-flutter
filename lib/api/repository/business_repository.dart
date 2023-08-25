
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/business.dart';
import 'package:workit/providers/business.dart';

final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  return BusinessRepository(FirebaseFirestore.instance);
});


class BusinessRepository {
  final FirebaseFirestore firestore;  

  BusinessRepository(this.firestore);

  Future<List<BusinessModel>> getAllBusinessFromDatabase()
  async {
    List<BusinessModel> businessList = [];
    final QuerySnapshot<Map<String, dynamic>> collection = await firestore.collection('businesses').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> businessDoc in collection.docs) {
      Map<String, dynamic> map = businessDoc.data();
      BusinessModel business = BusinessModel.fromMap(map);
      businessList.add(business);
    }
    return businessList;
  }

  Future<BusinessModel> getSelectedBusiness()
  async {
    final businessId = selectedBusiness!.id;
    final DocumentReference<Map<String, dynamic>> ref = firestore.collection('businesses').doc(businessId); 
    final doc = await ref.get();

    if (doc.exists) 
    {
      return BusinessModel.fromMap(doc.data()!);
    }
    else
    {
      throw Exception("no business id found");
    }
  }

  Future<void> addBusinessToDatabase(BusinessModel business) async
  {
    final DocumentReference<Map<String, dynamic>> ref = firestore.collection('businesses').doc(business.id);
    final doc = await ref.get();

    if (!doc.exists) {
      return await ref.set(business.toMap());
    }
    else
    {
      throw Exception("Business already exists");
    }
      
  }

  Future<void> updateBusinessImageId(String imageId) async {
    final businessId = selectedBusiness!.id;
    final DocumentReference<Map<String, dynamic>> ref = firestore.collection('businesses').doc(businessId);
    final doc = await ref.get();

    if(doc.exists)
    {
      final images = doc.data()?['images'] as List<String>?;

      if(images == null) {
        await ref.update({'images': [imageId]});
      }
      else{
        await ref.update({'images': [...images, imageId]});
      }
    }
    else
    {
      throw Exception("there is not such business");
    }
  }
}