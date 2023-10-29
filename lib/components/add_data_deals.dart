import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Deals {
  Future<List> uploadImageToStorage(String parentName,String uid,String muda,List<Uint8List> file) async {
    Reference ref = _storage.ref().child(parentName).child(uid).child(muda);
    var index = 1, downloadUrl = [];
    for(var kiwanja in file){
      UploadTask uploadTask = ref.child('$index').putData(kiwanja);
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl.add(await snapshot.ref.getDownloadURL());
      if(index >= file.length){
        return downloadUrl;
      }
      index++;
    }
    return downloadUrl;
  }

  Future<String> saveData({
    required String aina,
    required String name,
    required String bio,
    required String bei,
    required List<Uint8List> file,
    required String userFirstName,
    required String userLastName,
    required String userPhone,
    required String userId,
    required String kundi,
    required String kundiDogo,
  }) async {
    String message = " Some Error Occurred";
    try{
      if(name.isNotEmpty || bio.isNotEmpty) {
        List imageUrls = await uploadImageToStorage(aina,userId,'${Timestamp.now().toDate()}', file);
        if(imageUrls.isNotEmpty){
          await _firestore.collection(aina).doc('${Timestamp.now().toDate()}')/*.collection(kundi).doc(kundiDogo).collection(userId).doc('${Timestamp.now().toDate()}')*/
              .set({
            'name': name,
            'kundi':kundi,
            'kundiDogo': kundiDogo,
            'bio': bio,
            'bei': bei,
            'image': imageUrls,
            'time':Timestamp.now(),
            'first_name': userLastName,
            'last_name': userLastName,
            'user_phone': userPhone,
            'user_id': userId,
          })
          // .add({
          //     'name': name,
          //     'bio': bio,
          //     'image': imageUrls,
          //     'time':Timestamp.now(),
          //     'first_name': userLastName,
          //     'last_name': userLastName,
          //     'user_phone': userPhone,
          //     'user_id': userId,
          //   })
              .whenComplete(() {
            Fluttertoast.showToast(
                msg: 'Wasifu umehifadhiwa kikamilifu',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepOrangeAccent[100],
                textColor: Colors.white,
                fontSize: 16.0
            );
            print('Cheeeeh!!');
          }
          );
        }
        message = 'profile updated';
      }
    }
    catch(err){
      message =err.toString();
    }
    return message;
  }
}