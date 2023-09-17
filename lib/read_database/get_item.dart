import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetItem extends StatefulWidget {
  final String documentId;
  const GetItem({Key? key,required this.documentId}) : super(key: key);

  @override
  State<GetItem> createState() => _GetItemState();
}

class _GetItemState extends State<GetItem> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('First Name: ${data['first_name']}');
        }
        return Text('loading..');
    });
  }
}
