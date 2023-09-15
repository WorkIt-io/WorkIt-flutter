import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final storageApiProvider = Provider<StorageApi>((ref) {
  return StorageApi(FirebaseStorage.instance);
});

class StorageApi {
  StorageApi(this._storage);

  final FirebaseStorage _storage;

  Reference getRefrence(String path)
  {
    return _storage.ref(path);
  }  

  Future<ListResult> retriveAll(String path) {
    final list = _storage.ref(path).list();
    return list;
  }

  Future<void> uploadFile(String path, File file)
  async {
    await _storage.ref(path).putFile(file);
  }

  Future<void> deleteFile(String path)
  async {
    _storage.ref(path).delete();
  }  


}
