import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/components/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/add_data.dart';

class UploadPopup extends StatefulWidget {
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  const UploadPopup({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.userAddress}) : super(key: key);

  @override
  State<UploadPopup> createState() => _UploadPopupState();
}

class _UploadPopupState extends State<UploadPopup> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<Uint8List>? _image = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  void selectImage() async {
    List<Uint8List> img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async{
    String name = nameController.text;
    String bio = bioController.text;
    String message = await StoreData().saveData(name: name, bio: bio, file: _image!,userFirstName: widget.userFirstName,userLastName: widget.userLastName,userPhone: widget.userPhone,userId: widget.userId);
  }

  // sign user out method
  Future<void> signUserOut() async {
    // await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    // return showDialog(context: context, builder: (BuildContext context) { return SimpleDialog(title: Text(''),children: [],); });
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Center(child: Text('Pakia taarifa za kiwanja')),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _image!.isNotEmpty?
                SizedBox(
                height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                        // mainAxisSpacing:8.0,
                        // crossAxisSpacing:8.0,
                        childAspectRatio:1,
                        crossAxisCount: 1,
                      ),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // padding: const EdgeInsets.only(right: 25.0),
                      primary: false,
                      itemCount: _image!.length,
                      itemBuilder: (context, index) {
                        return  CircleAvatar(
                            radius: 65,
                            backgroundImage: MemoryImage(_image!.elementAt(index))
                        );
                      }
                  ),
                )
                :
                const CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.green,
                      backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/128/10364/10364853.png'),//AssetImage('assets/images/location_icon.png'),
                    ),
            Center(
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo,color: Colors.black,)
                  ),
                ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Ingiza jina',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  hintText: 'Ingiza wasifu',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),

            // malipo ya serikali
            InkWell(
              onTap: () {
                Navigator.pop(context);
                saveProfile();
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.cloud_upload_rounded,color: Colors.green,),
                      Text(
                        'hifadhi wasifu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),

            //close
            InkWell(
              onTap: ()=>Navigator.pop(context),
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),



      ],
    );
  }
}
