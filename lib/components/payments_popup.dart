import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/auth_page.dart';
import '../pages/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentsPopup extends StatefulWidget {
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  const PaymentsPopup({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.userAddress}) : super(key: key);

  @override
  State<PaymentsPopup> createState() => _PaymentsPopupState();
}

class _PaymentsPopupState extends State<PaymentsPopup> {
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
      title: const Center(child: Text('Lipia')),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            // malipo ya serikali
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await FlutterPhoneDirectCaller.callNumber('*152*00#');
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
                      Icon(Icons.call_outlined,color: Colors.green,),
                      Text(
                        'Serikali',
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
            // malipo ya ada ya application
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await FlutterPhoneDirectCaller.callNumber('*150*88#');
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
                      Icon(Icons.call_outlined,color: Colors.green,),
                      Text(
                        'Ada ya app',
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
            // malipo ya kusajili kampuni
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await FlutterPhoneDirectCaller.callNumber('*150*88#');
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
                      Icon(Icons.call_outlined,color: Colors.green,),
                      Text(
                        'Sajili kampuni',
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
            // malipo ya kampuni iliyosajiliwa
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await FlutterPhoneDirectCaller.callNumber('*150*88#');
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
                      Icon(Icons.call_outlined,color: Colors.green,),
                      Text(
                        'Kampuni iliyosajiliwa',
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
