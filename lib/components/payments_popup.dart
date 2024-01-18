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
  const PaymentsPopup({Key? key, required this.userFirstName, required this.userLastName, required this.userGender, required this.userPhone, required this.userId, required this.userAddress}) : super(key: key);

  @override
  State<PaymentsPopup> createState() => _PaymentsPopupState();
}

class _PaymentsPopupState extends State<PaymentsPopup> {
  String method = '-Pay using', filterString = '';
  TextEditingController titleController = TextEditingController();
  List orodhamethod = [
    '-Pay using',
    'Title number',
    'Plot number',
  ];
  String mkoa = '-Mkoa';
  List orodhaMkoa = [
    '-Mkoa',
    'Arusha',
    'Dar es salaam',
    'Dodoma',
    'Kilimanjaro',
    'Mwanza',
  ];
  String wilaya = '-Chagua Wilaya';
  List orodhaWilaya = ['-Chagua Wilaya', 'Kinondoni', 'Ilala', 'Temeke', 'Ubungo', 'Kawe', 'Arumeru', 'Arusha', 'Moshi', 'Hai', 'Kia', 'Same'];

  filtering(String filter) {
    filterString = '${filterString} ${filter}';
    // isFiltered = true;
    // filterString = '${filterString} ${mkoa}';
    // filterString = '${filterString} ${wilaya}';
  }

  bool isSerikali = false, showOptions = false;
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
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Center(child: Text('Lipia')),
      children: [
        showOptions
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //filter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        // method
                        Container(
                          margin: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Theme.of(context).cardColor, width: 1),
                            // color: Colors.orangeAccent,
                          ),
                          child: Padding(
                            // width: 240,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton(
                              hint: Text('Chagua method'),
                              isExpanded: true,
                              value: method,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              onChanged: (newValue) {
                                setState(() {
                                  method = newValue.toString();
                                  filtering(method);
                                });
                              },
                              items: orodhamethod.map((value) {
                                // jazaOrodhaKundi();
                                return DropdownMenuItem(value: value, child: Text(value, style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis)));
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),

                        // title
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              hintText: 'Title', //jina
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8.0,
                        ),
                        // mikoa
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton(
                              hint: Text('Chagua Mkoa'),
                              isExpanded: true,
                              value: mkoa,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              onChanged: (newValue) {
                                setState(() {
                                  mkoa = newValue.toString();
                                  filtering(mkoa);
                                });
                              },
                              items: orodhaMkoa.map((value) {
                                // jazaOrodhaKundi();
                                return DropdownMenuItem(value: value, child: Text(value, style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis)));
                              }).toList(),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8.0,
                        ),
                        // wilaya dropdown
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton(
                              hint: Text('Chagua Wilaya'),
                              isExpanded: true,
                              value: wilaya,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              onChanged: (newValue) {
                                setState(() {
                                  wilaya = newValue.toString();
                                });
                              },
                              items: orodhaWilaya.map((value) {
                                // jazaOrodhaKundi();
                                return DropdownMenuItem(value: value, child: Text(value));
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.mobile_screen_share_rounded,
                            color: Colors.red,
                          ),
                          Text('Airtel'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.mobile_screen_share_rounded,
                            color: Colors.yellow,
                          ),
                          Text('Halotel'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.mobile_screen_share_rounded,
                            color: Colors.blueGrey,
                          ),
                          Text('Tigo'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.mobile_screen_share_rounded,
                            color: Colors.pink,
                          ),
                          Text('Vodacom'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  //close
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // malipo ya serikali
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isSerikali = true;
                        showOptions = true;
                      });
                      // Navigator.pop(context);
                      // await FlutterPhoneDirectCaller.callNumber('*152*00#');
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                              'Serikali',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // malipo ya ada ya application
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await FlutterPhoneDirectCaller.callNumber('*150*88#');
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                              'Ada ya app',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // malipo ya kusajili kampuni
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await FlutterPhoneDirectCaller.callNumber('*150*88#');
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                              'Sajili kampuni',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // malipo ya kampuni iliyosajiliwa
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await FlutterPhoneDirectCaller.callNumber('*150*88#');
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                              'Kampuni iliyosajiliwa',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //close
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
