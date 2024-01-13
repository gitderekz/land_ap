import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/components/personalize_button.dart';
import 'package:health_ai_test/firebase/hifadhi_shughuli.dart';
import 'package:health_ai_test/pages/map/map_page.dart';
import 'package:lottie/lottie.dart';
import 'package:health_ai_test/components/service_mini_card.dart';
import 'package:health_ai_test/pages/report.dart';

import '../components/appointment_and_report.dart';
import '../components/job_cards.dart';
import '../components/make_call.dart';
import '../components/options_popup.dart';
import '../components/request_report.dart';
import '../provider/provider.dart';
import 'appointment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HospitalPage extends StatefulWidget {
  String hospitalId, hospitalName, hospitalImage, hospitalLocation, hospitalDescription;
  var hospitalSnapshot, receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userImage;
  final userId;
  // List<QueryDocumentSnapshot<Map<String, dynamic>>> hospitalSnapshot;
  HospitalPage({super.key, required this.hospitalId, required this.hospitalName, required this.hospitalImage, required this.hospitalLocation, required this.hospitalDescription, required this.hospitalSnapshot, required this.userFirstName, required this.userLastName, required this.userGender, required this.userPhone, required this.userImage, required this.userId, required this.receptionPhone, required this.userAddress});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late CollectionReference doctorsReference;
  var looper, listSize = 0;
  List<String> doctorName = [], doctorImage = [], doctorProfession = [];
  Color rangiToroli = Colors.white;
  Color rangiPenda = Colors.white;
  List<bool> badiliRangi = [false, false];
  bool maongezi = false, lipa = false;
  var safu_njia = [];
  var kilicho_pendwa = '';

  matukioKurasaYaChini(dhumuni, bidhaaId) async {
    if (dhumuni == 'maongezi') {
      setState(() {
        maongezi = !maongezi;
        print(maongezi);
      });
    }
    if (dhumuni == 'lipa') {
      setState(() {
        lipa = !lipa;
      });
    }
    if (dhumuni == 'toroli') {
      badiliRangi[0] = !badiliRangi[0];
      String message = await hifadhiShughuli().saveData(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userPhone: widget.userPhone, userId: widget.userId, njia: 'widget.kiwanjaNjia', muda_asili: safu_njia[5], shughuli: dhumuni, kazi: badiliRangi[0], context: context);
      setState(() {
        badiliRangi[0] == true ? rangiToroli = Colors.deepOrangeAccent.shade700 : rangiToroli = Colors.white;
      });
      if (message == 'haijafanikiwa') {
        setState(() {
          badiliRangi[0] == true ? rangiToroli = Colors.deepOrangeAccent.shade700 : rangiToroli = Colors.white;
        });
      }
    }
    if (dhumuni == 'penda') {
      badiliRangi[1] = !badiliRangi[1];
      String message = await hifadhiShughuli().saveData(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userPhone: widget.userPhone, userId: widget.userId, njia: 'widget.kiwanjaNjia', muda_asili: safu_njia[5], shughuli: dhumuni, kazi: badiliRangi[1], context: context);
      setState(() {
        badiliRangi[1] == true ? rangiPenda = Colors.deepOrangeAccent.shade700 : rangiPenda = Colors.white;
      });
      if (message == 'haijafanikiwa') {
        setState(() {
          badiliRangi[1] == true ? rangiPenda = Colors.deepOrangeAccent.shade700 : rangiPenda = Colors.white;
        });
      }
    }
  }

  DocumentReference<Map<String, dynamic>> getUser() {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return userDoc;
  }

  @override
  void initState() {
    widget.hospitalSnapshot.docs.forEach((element) {
      if (/*element.id*/ widget.hospitalId == element.id) {
        doctorsReference = element.reference.collection('doctors');
        doctorsReference.get().then((value) {
          setState(() {
            looper = value.size;
            for (int x = 0; x < looper; x++) {
              doctorName.add(value.docs[x].get('name'));
              doctorImage.add(value.docs[x].get('image'));
              doctorProfession.add(value.docs[x].get('description'));
            }
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //back button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  //Name
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.hospitalName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ]),
                  //profile
                  PersonalizeButton(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userAddress: widget.userAddress, userGender: widget.userGender, userPhone: widget.userPhone, userImage: widget.userImage, userId: widget.userId),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // height: 200,                             //commented
                            child: Padding(
                              //added
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                //ListView -> Column
                                // scrollDirection: Axis.vertical,      //commented
                                children: [
                                  //picture
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child:
                                        // Container(height:150,child: Lottie.asset(widget.hospitalImagePath)),
                                        Container(
                                      height: 150,
                                      child: Image.network(
                                        widget.hospitalImage,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //hospital name
                                  Text(
                                    widget.hospitalName,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, overflow: TextOverflow.clip),
                                  ),

                                  //hospital location
                                  Text(widget.hospitalLocation),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //hospital description
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.hospitalDescription,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      // AppLocalizations.of(context)!.close,
                                      'Back',
                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => matukioKurasaYaChini('maongezi', widget.hospitalId),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(
                                              maongezi ? Icons.expand_less : Icons.chat_outlined,
                                              color: Colors.white,
                                            )),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white,
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 0,
                                      ),
                                      InkWell(
                                        onTap: () => matukioKurasaYaChini('mahali', widget.hospitalId),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Icon(Icons.money,color: Colors.white,),
                                      InkWell(
                                        onTap: () => matukioKurasaYaChini('lipa', widget.hospitalId),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: lipa
                                                ? Icon(
                                                    Icons.expand_less,
                                                    color: Colors.white,
                                                  )
                                                : Text('lipa',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ))),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white,
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 0,
                                      ),
                                      InkWell(
                                        onTap: () => matukioKurasaYaChini('toroli', widget.hospitalId),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(
                                              Icons.shopping_cart_rounded,
                                              color: rangiToroli,
                                            )),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white,
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 0,
                                      ),
                                      InkWell(
                                        onTap: () => matukioKurasaYaChini('penda', widget.hospitalId),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: rangiPenda,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
