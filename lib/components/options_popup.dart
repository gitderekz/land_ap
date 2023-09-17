import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/auth_page.dart';
import '../pages/settings_page.dart';

class OptionsPopup extends StatefulWidget {
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  const OptionsPopup({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.userAddress}) : super(key: key);

  @override
  State<OptionsPopup> createState() => _OptionsPopupState();
}

class _OptionsPopupState extends State<OptionsPopup> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
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
      title: const Center(child: Text('Actions')),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            //settings
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings(
                    userFirstName:widget.userFirstName,
                    userLastName:widget.userLastName,
                    userAddress:widget.userAddress,
                    userGender:widget.userGender,
                    userPhone:widget.userPhone,
                    userId:widget.userId)));
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.settings,color: Colors.green,),
                      Text(
                        'Settings',
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

            //logout
            InkWell(
              onTap: (){
                // Navigator.pop(context);
                signUserOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthPage()));
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.logout,color: Colors.green,),
                      Text(
                        'Logout',
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
            SizedBox(height: 20,),

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
