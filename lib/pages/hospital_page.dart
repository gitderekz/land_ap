import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/pages/map/map_page.dart';
import 'package:lottie/lottie.dart';
import 'package:health_ai_test/components/doctor_card.dart';
import 'package:health_ai_test/pages/report.dart';

import '../components/appointment_and_report.dart';
import '../components/clinic_cards.dart';
import '../components/make_call.dart';
import '../components/options_popup.dart';
import '../components/request_report.dart';
import '../provider/provider.dart';
import 'appointment.dart';

class HospitalPage extends StatefulWidget {
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
  HospitalPage({super.key,required this.hospitalId,required this.hospitalName,required this.hospitalImage,required this.hospitalLocation,required this.hospitalDescription,required this.hospitalSnapshot,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.receptionPhone,required this.userAddress});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
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
                    //card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Row(
                          children: [
                            //animation
                            Container(
                              height: 100,
                              width: 100,
                              child: Lottie.asset('assets/jsons/beating-heart.json'),
                            ),
                            SizedBox(width: 20.0,),

                            //about hospital
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About our hospital',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Text(
                                    'Fill your medical card right now',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  InkWell(
                                    onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return MapPage(); }),
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Open on map',
                                            style: TextStyle(color: Colors.green),),
                                          Icon(Icons.location_on_outlined,color: Colors.green,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  InkWell(
                                    onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return MakeCall(receptionPhone: widget.receptionPhone); }),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Call reception',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Icon(Icons.call_outlined,color: Colors.white,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    //AppointmentAndReport
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointment(
                                hospitalId:widget.hospitalId,
                                hospitalName:widget.hospitalName,
                                hospitalSnapshot:widget.hospitalSnapshot,
                              // user details
                                userFirstName:widget.userFirstName,
                                userLastName:widget.userLastName,
                                userAddress:widget.userAddress,
                                userGender:widget.userGender,
                                userPhone:widget.userPhone,
                                userId:widget.userId
                            ))),
                            child: AppointmentAndReport(
                              iconImagePath: 'assets/icons/medical-team.png',
                              categoryName: 'make\nappointment',
                            ),
                          ),
                          InkWell(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Report(
                                hospitalId:widget.hospitalId,
                                hospitalName:widget.hospitalName,
                                hospitalSnapshot:widget.hospitalSnapshot,
                                // user details
                                userFirstName:widget.userFirstName,
                                userLastName:widget.userLastName,
                                userAddress:widget.userAddress,
                                userGender:widget.userGender,
                                userPhone:widget.userPhone,
                                userId:widget.userId
                            ))),
                            child: AppointmentAndReport(
                              iconImagePath: 'assets/icons/capsules.png',
                              categoryName: 'request\nreport',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    //clinic list title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clinic List',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),

                    //clinic list cards
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ClinicCard(
                            iconImagePath: 'assets/icons/medical-team.png',
                            categoryName: 'dentist',
                            receptionPhone: widget.receptionPhone,
                          ),
                          ClinicCard(
                            iconImagePath: 'assets/icons/capsules.png',
                            categoryName: 'dematologist',
                            receptionPhone: widget.receptionPhone,
                          ),
                          ClinicCard(
                            iconImagePath: 'assets/icons/healthcare.png',
                            categoryName: 'radiologist',
                            receptionPhone: widget.receptionPhone,
                          ),
                          ClinicCard(
                            iconImagePath: 'assets/icons/capsules.png',
                            categoryName: 'cardiologist',
                            receptionPhone: widget.receptionPhone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),

                    //doctor list title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Doctor List',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'see all',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),

                    //doctor list cards
                    // Expanded(
                    //     child: ListView(
                    //       scrollDirection: Axis.horizontal,
                    //       children: [
                    //         DoctorCard(doctorImagePath: 'assets/images/doc1.jpg',doctorName: 'Dr. Moureen',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                    //         DoctorCard(doctorImagePath: 'assets/images/doc2.jpg',doctorName: 'Dr. Doreen',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                    //         DoctorCard(doctorImagePath: 'assets/images/doc3.jpg',doctorName: 'Dr. Theo',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                    //         DoctorCard(doctorImagePath: 'assets/images/doc1.jpg',doctorName: 'Dr. Emmy',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                    //       ],
                    //     )
                    // ),

                    Container(
                      height: 250,
                      child:
                      // ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     shrinkWrap: true,
                      //     primary: false,
                      //     itemCount: widget.hospitalSnapshot.size,
                      //     itemBuilder: (context, index){
                      //       return DoctorCard(doctorImagePath: widget.hospitalSnapshot., doctorName: doctorName, doctorRate: doctorRate, doctorProfession: doctorProfession);
                      //     },
                      // ),
                      ListView.builder(
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

                            return DoctorCard(
                                kiwanjaImagePath: doctorImage[index],
                                kiwanjaName: doctorName[index],
                                kiwanjaMahali: doctorProfession[index],
                                kiwanjaId:widget.hospitalId,
                                kiwanjaNjia:"snap[index].reference.path",
                                kiwanjaBio:"snap[index]['bio']",
                                kiwanjaBei:"snap[index]['bei']",
                                kiwanjaSnapshot:widget.hospitalSnapshot,
                                receptionPhone: '',
                                // user details
                                userFirstName:widget.userFirstName,
                                userLastName:widget.userLastName,
                                userAddress:widget.userAddress,
                                userGender:widget.userGender,
                                userPhone:widget.userPhone,
                                userId:widget.userId);

                        },
                      ),

                      // ListView(
                      //   scrollDirection: Axis.horizontal,
                      //   children: [
                      //     DoctorCard(doctorImagePath: 'assets/images/doc1.jpg',doctorName: 'Dr. Moureen',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                      //     DoctorCard(doctorImagePath: 'assets/images/doc2.jpg',doctorName: 'Dr. Doreen',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                      //     DoctorCard(doctorImagePath: 'assets/images/doc3.jpg',doctorName: 'Dr. Theo',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                      //     DoctorCard(doctorImagePath: 'assets/images/doc1.jpg',doctorName: 'Dr. Emmy',doctorRate: '4.3',doctorProfession: 'Therapist, 3 yrs'),
                      //   ],
                      // ),
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
