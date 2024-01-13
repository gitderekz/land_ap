import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:provider/provider.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<List> uploadImageToStorage(String parentName, String uid, String muda, List<Uint8List> file) async {
    Reference ref = _storage.ref().child(parentName).child(uid).child(muda);
    var index = 1, downloadUrl = [];
    for (var kiwanja in file) {
      UploadTask uploadTask = ref.child('$index').putData(kiwanja);
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl.add(await snapshot.ref.getDownloadURL());
      if (index >= file.length) {
        return downloadUrl;
      }
      index++;
    }
    return downloadUrl;
  }

  Future<String> saveData({required String name, required String bei, required String bio, required String nchi, required String mkoa, required String wilaya, required String matumizi, required List<Uint8List> file, required String userFirstName, required String userLastName, required String userPhone, required String userId, required context}) async {
    String message = " Some Error Occurred";
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        List imageUrls = await uploadImageToStorage('viwanja', userId, '${Timestamp.now().toDate()}', file);
        print('PIHA ZIKO: ${imageUrls.length}');
        if (imageUrls.isNotEmpty) {
          await _firestore.collection('viwanja').add({
            'name': name,
            'bio': bio,
            'nchi': nchi,
            'mkoa': mkoa,
            'wilaya': wilaya,
            'matumizi': matumizi,
            'image': imageUrls,
            'bei': bei,
            'mahali': '$wilaya, $mkoa',
            'latitude': '0.9',
            'longitude': '0.9',
            'time': Timestamp.now(),
            'first_name': userLastName,
            'last_name': userLastName,
            'user_phone': userPhone,
            'user_id': userId,
          }).whenComplete(() {
            Fluttertoast.showToast(msg: 'Successfully uploaded', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.orangeAccent, textColor: Colors.black, fontSize: 16.0);
            print('Cheeeeh!!');
          });
        }
        message = 'profile updated';
      }
    } catch (err) {
      message = err.toString();
    }
    return message;
  }
}

// SINGLE IMAGE STORAGE
class StoreSingleData {
  Future<String> uploadSingleImageToStorage(String parentName, String uid, String wasifu, Uint8List file) async {
    Reference ref = _storage.ref().child(parentName).child(uid).child(wasifu);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveSingleData({
    required String name,
    required String bio,
    required Uint8List file,
    required String userFirstName,
    required String userLastName,
    required String userPhone,
    required String userId,
    required context,
  }) async {
    String message = " Some Error Occurred";
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadSingleImageToStorage('profiles', userId, 'wasifu', file);
        await _firestore.collection('profiles').add({
          'name': name,
          'bio': bio,
          'image': imageUrl,
          'time': Timestamp.now(),
          'first_name': userLastName,
          'last_name': userLastName,
          'user_phone': userPhone,
          'user_id': userId,
        }).whenComplete(() {
          Fluttertoast.showToast(msg: 'Successfully uploaded', toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.orangeAccent, textColor: Colors.black, fontSize: 16.0);
          print('Cheeeeh!!');
        });

        message = 'profile updated';
      }
    } catch (err) {
      message = err.toString();
    }
    return message;
  }
}
