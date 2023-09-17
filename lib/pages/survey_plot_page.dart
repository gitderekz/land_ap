import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_ai_test/components/doctor_card.dart';
import '../components/options_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/survey_card.dart';

class SurveyPlotPage extends StatefulWidget {
  String hospitalId,hospitalName,hospitalImage,hospitalLocation,hospitalDescription;
  var hospitalSnapshot,receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  // List<QueryDocumentSnapshot<Map<String, dynamic>>> hospitalSnapshot;
  SurveyPlotPage({super.key,required this.hospitalId,required this.hospitalName,required this.hospitalImage,required this.hospitalLocation,required this.hospitalDescription,required this.hospitalSnapshot,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.receptionPhone,required this.userAddress});

  @override
  State<SurveyPlotPage> createState() => _SurveyPlotPageState();
}

class _SurveyPlotPageState extends State<SurveyPlotPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late CollectionReference doctorsReference;
  var looper,listSize = 0;
  List<String> doctorName = [],doctorImage = [],doctorProfession = [];

  DocumentReference<Map<String, dynamic>> getUser(){
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return userDoc;
  }

  @override
  void initState() {
    widget.hospitalSnapshot.docs.forEach((element) {
      if(/*element.id*/widget.hospitalId == element.id){
        doctorsReference = element.reference.collection('doctors');
        doctorsReference.get().then((value) {
          setState(() {
            looper = value.size;
            for(int x=0;x<looper;x++){
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
                      IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Navigator.pop(context); },),
                    ],
                  ),
                  //Name
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Text(widget.hospitalName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ]
                  ),
                  //profile
                  InkWell(
                    onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return OptionsPopup(
                        userFirstName:widget.userFirstName,
                        userLastName:widget.userLastName,
                        userAddress:widget.userAddress,
                        userGender:widget.userGender,
                        userPhone:widget.userPhone,
                        userId:widget.userId); }),
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //viwanja nya makazi kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_hatimiliki,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja nya makazi card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya biashara kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_mipaka,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya biashara card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya viwanda kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_topografia,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya viwanda card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya mashamba kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_ujenzi,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya mashamba card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya michezo kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_kujengwa,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya michezo card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya michezo kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_njia,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya michezo card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    //viwanja vya michezo kichwa
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tafiti_za_mafuriko,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    //viwanja vya michezo card
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: doctorImage.length,
                        itemBuilder: (BuildContext context, int index) {
                          // widget.hospitalSnapshot.docs.forEach((element) {
                          //   if(element.id == 'kigamboni'){
                          //     doctorsReference = element.reference.collection('doctors');
                          //     doctorsReference.get().then((value) {
                          //       setState(() {
                          //         doctorName = value.docs[index].get('name');
                          //         doctorImage = value.docs[index].get('image');
                          //         doctorProfession = value.docs[index].get('description');
                          //       });
                          //     });
                          //   }
                          // });
                          // var data = widget.hospitalSnapshot?.docs?[index].data();
                          // print("data = $data");

                          return SurveyCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
                              // user details
                              userFirstName:widget.userFirstName,
                              userLastName:widget.userLastName,
                              userAddress:widget.userAddress,
                              userGender:widget.userGender,
                              userPhone:widget.userPhone,
                              userId:widget.userId);

                        },
                      ),
                    ),
                    SizedBox(height: 20,),


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
