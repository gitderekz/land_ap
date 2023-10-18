import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_ai_test/components/options_popup.dart';
import 'package:health_ai_test/components/payments_popup.dart';
import 'package:health_ai_test/components/quick_deals.dart';
import 'package:health_ai_test/components/upload_popup_multi.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../components/clinic_cards.dart';
import '../components/gradient_animation_welcome.dart';
import '../components/hospital_card.dart';
import '../components/personalize_button.dart';
import '../components/read_more.dart';
import 'doctor_appointment.dart';
import 'hospital_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textController = TextEditingController();
  final userCollection = FirebaseFirestore.instance.collection('users');
  var hospitalSnapshot;
  String userFirstName = '';
  String userLastName = '';
  String userAddress = '';
  String userGender = '';
  String userImage = '';
  String userPhone = '';
  String userId = '';
  String doctorId = '';
  String hospitalId = '';
  String nearHospitalName = 'loading..';
  String nearHospitalImage = '';
  String nearHospitalLocation = '';
  String nearHospitalDescription = '';
  String receptionPhone = '';
  String role = 'patient';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController(/*text: 'wanaume'*/);
  }

  void openHospitalPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HospitalPage(
        hospitalId:hospitalId,hospitalName:nearHospitalName,hospitalImage:nearHospitalImage,hospitalLocation:nearHospitalLocation,hospitalDescription:nearHospitalDescription,hospitalSnapshot: hospitalSnapshot,// user details
        userFirstName:userFirstName,
        userLastName:userLastName,
        userAddress:userAddress,
        userGender:userGender,
        userPhone:userPhone,
        userId:userId,
        receptionPhone:receptionPhone
    )));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orangeCardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Colors.deepOrange[200]
        : Colors.deepOrange[100];
    final greenCardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Colors.green[200]
        : Colors.green[100];

    return FutureBuilder(
      future: _fetchUserDetails(),
      builder: (context,snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          return Center(child: Lottie.asset('assets/jsons/loading.json'));
        }
        return role=='patient'?
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                //app bar
                WelcomeGradientBackground(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Name
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: _fetchUserDetails(),
                                  builder: (context,snapshot) {
                                    if(snapshot.connectionState != ConnectionState.done){
                                      return Text('wait...');
                                    }
                                    return Text('Hi, $userFirstName',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 16,
                                        color: Colors.black38
                                      ),
                                    );
                                  }
                              ),
                              SizedBox(width: 8.0,),
                            ]
                        ),

                        //profile

                        //search bar
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                                height: 35,
                                margin: const EdgeInsets.only(right: 8.0,top: 4.0,bottom: 8.0),
                                // decoration: BoxDecoration(
                                //   color: Theme.of(context).cardColor,
                                //   borderRadius: BorderRadius.circular(20),
                                // ),
                                child: CupertinoSearchTextField(
                                  controller: textController,
                                  placeholder: 'Search',
                                  borderRadius: BorderRadius.circular(20),
                                )
                              // const TextField(
                              //   decoration: InputDecoration(
                              //     prefixIcon: Icon(Icons.search),
                              //     border: InputBorder.none,
                              //     hintText: 'Search product',
                              //   ),
                              // ),
                            ),
                          ),
                        ),

                        //profile
                        PersonalizeButton(
                            userFirstName:userFirstName,
                            userLastName:userLastName,
                            userAddress:userAddress,
                            userGender:userGender,
                            userPhone:userPhone,
                            userId:userId
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8.0,),

                        //ushuru na ada card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.green.shade400,offset: Offset(2, -2),blurRadius: 2,spreadRadius:1,blurStyle: BlurStyle.normal)],
                              color: greenCardColor,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Row(
                              children: [
                                //animation
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset('assets/jsons/payment.json'),
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent[100],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                SizedBox(width: 20.0,),

                                //tax & fee
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.how_do_you_feel,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      Text(
                                        AppLocalizations.of(context)!.how_do_you_feel_text,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      InkWell(
                                        onTap: ()=>showDialog(context: context, builder: (BuildContext context) {
                                          return PaymentsPopup(
                                            userFirstName:userFirstName,
                                            userLastName:userLastName,
                                            userAddress:userAddress,
                                            userGender:userGender,
                                            userPhone:userPhone,
                                            userId:userId); }),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.get_started,
                                              style: TextStyle(color: Colors.white),
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
                        SizedBox(height: 8,),

                        //uza kiwanja kichwa
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.near_hospital,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2,),
                        //uza kiwanja card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
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
                                  child: Lottie.asset('assets/jsons/business.json'),
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent[100],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  // Image.network(
                                  //   nearHospitalImage,
                                  //   height: 100,
                                  // ),
                                ),
                                SizedBox(width: 20.0,),

                                //near hospital
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                          future: _fetchUserDetails(),
                                          builder: (context,snapshot) {
                                            if(snapshot.connectionState != ConnectionState.done){
                                              return Text('wait...');
                                            }
                                            return Text(
                                              AppLocalizations.of(context)!.near_hospital,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                      ),

                                      SizedBox(height: 12,),
                                      Text(
                                        AppLocalizations.of(context)!.near_hospital_description,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      ReadMore(
                                          hospitalImagePath: nearHospitalImage,
                                          hospitalName: AppLocalizations.of(context)!.near_hospital,
                                          hospitalLocation: nearHospitalLocation,
                                          hospitalDescription: AppLocalizations.of(context)!.near_hospital_description,
                                          hospitalSnapshot: hospitalSnapshot,
                                          hospitalId:hospitalId,
                                          receptionPhone:receptionPhone,
                                          // user details
                                          userFirstName:userFirstName,
                                          userLastName:userLastName,
                                          userAddress:userAddress,
                                          userGender:userGender,
                                          userPhone:userPhone,
                                          userId:userId
                                      ),
                                      SizedBox(height: 12,),
                                      InkWell(
                                        onTap: ()=>showDialog(context: context, builder: (BuildContext context) {
                                          return UploadPopup(
                                              userFirstName:userFirstName,
                                              userLastName:userLastName,
                                              userAddress:userAddress,
                                              userGender:userGender,
                                              userPhone:userPhone,
                                              userId:userId); }),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.visit,
                                              style: TextStyle(color: Colors.white),
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

                        //Hospitals list title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hospital_list,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'see all',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        //Hospitals list cards
                        Container(
                          height: 250,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("hospitals").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData) {
                                final snap = snapshot.data!.docs;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snap.length,
                                  itemBuilder: (context, index) {
                                    hospitalSnapshot = snapshot.data!;
                                    nearHospitalName = snap[index]['name'];
                                    nearHospitalImage = snap[index]['image'];
                                    nearHospitalDescription = snap[index]['description'];
                                    nearHospitalLocation = snap[index]['location'];
                                    hospitalId = snap[index]['hospital_id'];
                                    receptionPhone = snap[index]['reception'];
                                    return HospitalCard(
                                        hospitalImagePath: snap[index]['image'],
                                        hospitalName: snap[index]['name'],
                                        hospitalLocation: snap[index]['location'],
                                        hospitalDescription: snap[index]['description'],
                                        hospitalSnapshot: hospitalSnapshot,
                                        hospitalId: hospitalId,
                                        receptionPhone: receptionPhone,
                                        // user details
                                        userFirstName:userFirstName,
                                        userLastName:userLastName,
                                        userAddress:userAddress,
                                        userGender:userGender,
                                        userPhone:userPhone,
                                        userId:userId
                                    );

                                    //   Container(
                                    //   height: 70,
                                    //   width: double.infinity,
                                    //   margin: const EdgeInsets.only(bottom: 12),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius: BorderRadius.circular(20),
                                    //     boxShadow: const [
                                    //       BoxShadow(
                                    //         color: Colors.black26,
                                    //         offset: Offset(2, 2),
                                    //         blurRadius: 10,
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Stack(
                                    //     children: [
                                    //       Container(
                                    //         margin: const EdgeInsets.only(left: 20),
                                    //         alignment: Alignment.centerLeft,
                                    //         child: Text(
                                    //           snap[index]['name'],
                                    //           style: const TextStyle(
                                    //             color: Colors.black54,
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         margin: const EdgeInsets.only(right: 20),
                                    //         alignment: Alignment.centerRight,
                                    //         child: Text(
                                    //           "\$${snap[index]['description']}",
                                    //           style: TextStyle(
                                    //             color: Colors.green.withOpacity(0.7),
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,),

                        //ukurasa wa serikali kichwa
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.government_site,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        //ukurasa wa serikali card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(12.0),
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
                                  child: Lottie.asset('assets/jsons/web.json'),
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent[100],
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  // Image.network(
                                  //   nearHospitalImage,
                                  //   height: 100,
                                  // ),
                                ),
                                SizedBox(width: 2.0,),

                                //near hospital
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                          future: _fetchUserDetails(),
                                          builder: (context,snapshot) {
                                            if(snapshot.connectionState != ConnectionState.done){
                                              return Text('wait...');
                                            }
                                            return Text(
                                              AppLocalizations.of(context)!.government_site,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                      ),

                                      SizedBox(height: 12,),
                                      Text(
                                        AppLocalizations.of(context)!.government_site_description,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      // SizedBox(height: 12,),
                                      // ReadMore(
                                      //     hospitalImagePath: nearHospitalImage,
                                      //     hospitalName: AppLocalizations.of(context)!.government_site,
                                      //     hospitalLocation: nearHospitalLocation,
                                      //     hospitalDescription: AppLocalizations.of(context)!.government_site_description,
                                      //     hospitalSnapshot: hospitalSnapshot,
                                      //     hospitalId:hospitalId,
                                      //     receptionPhone:receptionPhone,
                                      //     // user details
                                      //     userFirstName:userFirstName,
                                      //     userLastName:userLastName,
                                      //     userAddress:userAddress,
                                      //     userGender:userGender,
                                      //     userPhone:userPhone,
                                      //     userId:userId
                                      // ),
                                      SizedBox(height: 12,),
                                      InkWell(
                                        onTap: openHospitalPage,
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.visit,
                                              style: TextStyle(color: Colors.white),
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

                        //nafasi za kazi kichwa
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          decoration: BoxDecoration(
                            gradient: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                            LinearGradient(colors: [Colors.transparent,Colors.transparent],):
                            LinearGradient(colors: [Colors.white30,Colors.lightGreen.shade100,Colors.green.shade100],),//lime,lightgreen
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.nafasi_za_kazi,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'see all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //nafasi za kazi card
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                            LinearGradient(colors: [Colors.transparent,Colors.transparent],):
                            LinearGradient(colors: [Colors.white30,Colors.lightGreen.shade100,Colors.green.shade100],),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("hospitals").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData) {
                                final snap = snapshot.data!.docs;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snap.length,
                                  itemBuilder: (context, index) {
                                    hospitalSnapshot = snapshot.data!;
                                    nearHospitalName = snap[index]['name'];
                                    nearHospitalImage = snap[index]['image'];
                                    nearHospitalDescription = snap[index]['description'];
                                    nearHospitalLocation = snap[index]['location'];
                                    hospitalId = snap[index]['hospital_id'];
                                    receptionPhone = snap[index]['reception'];
                                    return ClinicCard(
                                      iconImagePath: index==0? 'assets/icons/medical-team.png'
                                          :index==1? 'assets/icons/capsules.png'
                                          :index==2? 'assets/icons/healthcare.png'
                                          :'assets/icons/capsules.png',
                                      categoryName: index==0? 'dentist'
                                          :index==1? 'dematologist'
                                          :index==2? 'radiologist'
                                          :'cardiologist',
                                      receptionPhone: receptionPhone,
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        // SizedBox(height: 20.0,),

                        //dili za haraka kichwa
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(
                            gradient: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                            LinearGradient(colors: [Colors.transparent,Colors.transparent],):
                            LinearGradient(colors: [Colors.white30,Colors.lightGreen.shade100,Colors.green.shade100],),
                            // borderRadius: BorderRadius.only(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.dili_za_haraka,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'see all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //dili za haraka card
                        Container(
                          padding: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            gradient: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark?
                            LinearGradient(colors: [Colors.transparent,Colors.transparent],):
                            LinearGradient(colors: [Colors.white30,Colors.lightGreen.shade100,Colors.green.shade100],),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5),),
                          ),
                          height: 350,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("hospitals").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData) {
                                final snap = snapshot.data!.docs;
                                return GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                                    // mainAxisSpacing:8.0,
                                    // crossAxisSpacing:8.0,
                                    // childAspectRatio:1,
                                    crossAxisCount: 2,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // padding: const EdgeInsets.only(right: 25.0),
                                  primary: false,
                                  itemCount: snap.length,
                                  itemBuilder: (context, index) {
                                    hospitalSnapshot = snapshot.data!;
                                    nearHospitalName = snap[index]['name'];
                                    nearHospitalImage = snap[index]['image'];
                                    nearHospitalDescription = snap[index]['description'];
                                    nearHospitalLocation = snap[index]['location'];
                                    hospitalId = snap[index]['hospital_id'];
                                    receptionPhone = snap[index]['reception'];
                                    return  QuickDeal(
                                        hospitalImagePath: (index%2==0)?'assets/jsons/real_estate.json':'assets/jsons/business.json',
                                        hospitalName: snap[index]['name'],
                                        hospitalLocation: snap[index]['location'],
                                        hospitalDescription: snap[index]['description'],
                                        hospitalSnapshot: hospitalSnapshot,
                                        hospitalId: hospitalId,
                                        receptionPhone: receptionPhone,
                                        // user details
                                        userFirstName:userFirstName,
                                        userLastName:userLastName,
                                        userAddress:userAddress,
                                        userGender:userGender,
                                        userPhone:userPhone,
                                        userId:userId
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),


                        //nafasi ya chini
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ):
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                //app bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Name
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8,),
                            FutureBuilder(
                                future: _fetchUserDetails(),
                                builder: (context,snapshot) {
                                  if(snapshot.connectionState != ConnectionState.done){
                                    return Text('wait...');
                                  }
                                  return Text('Hi, $userFirstName',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  );
                                }
                            )
                          ]
                      ),

                      //profile
                      InkWell(
                        onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return OptionsPopup(
                          // user details
                            userFirstName:userFirstName,
                            userLastName:userLastName,
                            userAddress:userAddress,
                            userGender:userGender,
                            userPhone:userPhone,
                            userId:userId); }),
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
                        //search bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            // padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                hintText: 'Search hospital',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        //ushuru na ada card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: orangeCardColor,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Row(
                              children: [
                                //animation
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset('assets/jsons/online-doctor.json'),
                                ),
                                SizedBox(width: 20.0,),

                                //how do you feel
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.how_do_you_feel,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      Text(
                                        AppLocalizations.of(context)!.how_do_you_feel_text,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12,),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!.get_started,
                                            style: TextStyle(color: Colors.white),
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

                        //uza kiwanja kichwa
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.near_hospital,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        //uza kiwanja card
                        FutureBuilder(
                            future: _fetchUserDetails(),
                            builder: (context,snapshot) {
                              if(snapshot.connectionState != ConnectionState.done){
                                return Text('wait...');
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        child: Image.network(
                                          nearHospitalImage,
                                          height: 100,
                                        ),
                                      ),
                                      SizedBox(width: 20.0,),

                                      //near hospital
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              nearHospitalName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 12,),
                                            Text(
                                              nearHospitalDescription,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 12,),
                                            ReadMore(
                                                hospitalImagePath: nearHospitalImage,
                                                hospitalName: nearHospitalName,
                                                hospitalLocation: nearHospitalLocation,
                                                hospitalDescription: nearHospitalDescription,
                                                hospitalSnapshot: hospitalSnapshot,
                                                hospitalId:hospitalId,
                                                receptionPhone:receptionPhone,
                                                // user details
                                                userFirstName:userFirstName,
                                                userLastName:userLastName,
                                                userAddress:userAddress,
                                                userGender:userGender,
                                                userPhone:userPhone,
                                                userId:userId
                                            ),
                                            SizedBox(height: 12,),
                                            InkWell(
                                              onTap: openHospitalPage,
                                              child: Container(
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[300],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)!.visit,
                                                    style: TextStyle(color: Colors.white),
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
                              );
                            }
                        ),
                        SizedBox(height: 20,),

                        //Hospitals list title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hospital_list,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'see all',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),

                        //Hospitals list cards
                        Container(
                          height: 310,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("hospitals").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData) {
                                final snap = snapshot.data!.docs;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snap.length,
                                  itemBuilder: (context, index) {
                                    hospitalSnapshot = snapshot.data!;
                                    nearHospitalName = snap[index]['name'];
                                    nearHospitalImage = snap[index]['image'];
                                    nearHospitalDescription = snap[index]['description'];
                                    nearHospitalLocation = snap[index]['location'];
                                    hospitalId = snap[index]['hospital_id'];
                                    receptionPhone = snap[index]['reception'];
                                    return HospitalCard(
                                        hospitalImagePath: snap[index]['image'],
                                        hospitalName: snap[index]['name'],
                                        hospitalLocation: snap[index]['location'],
                                        hospitalDescription: snap[index]['description'],
                                        hospitalSnapshot: hospitalSnapshot,
                                        hospitalId: hospitalId,
                                        receptionPhone:receptionPhone,
                                        // user details
                                        userFirstName:userFirstName,
                                        userLastName:userLastName,
                                        userAddress:userAddress,
                                        userGender:userGender,
                                        userPhone:userPhone,
                                        userId:userId
                                    );

                                    //   Container(
                                    //   height: 70,
                                    //   width: double.infinity,
                                    //   margin: const EdgeInsets.only(bottom: 12),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius: BorderRadius.circular(20),
                                    //     boxShadow: const [
                                    //       BoxShadow(
                                    //         color: Colors.black26,
                                    //         offset: Offset(2, 2),
                                    //         blurRadius: 10,
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: Stack(
                                    //     children: [
                                    //       Container(
                                    //         margin: const EdgeInsets.only(left: 20),
                                    //         alignment: Alignment.centerLeft,
                                    //         child: Text(
                                    //           snap[index]['name'],
                                    //           style: const TextStyle(
                                    //             color: Colors.black54,
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         margin: const EdgeInsets.only(right: 20),
                                    //         alignment: Alignment.centerRight,
                                    //         child: Text(
                                    //           "\$${snap[index]['description']}",
                                    //           style: TextStyle(
                                    //             color: Colors.green.withOpacity(0.7),
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 100,),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green[300],
            label: Text('appointment'),
            icon: Lottie.asset('assets/jsons/schedule.json',width: 50,height: 50),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorAppointment(doctorId: doctorId,doctorName: userFirstName,hospitalSnapshot: hospitalSnapshot,
                  // user details
                  userFirstName:userFirstName,
                  userLastName:userLastName,
                  userAddress:userAddress,
                  userGender:userGender,
                  userPhone:userPhone,
                  userId:userId)));
            },
          ),
          // SpeedDial(
          //   foregroundColor: Colors.white,
          //   backgroundColor: Colors.green[300],
          //   animatedIcon: AnimatedIcons.view_list,
          //   children: [
          //     SpeedDialChild(
          //       child: Icon(Icons.chat),
          //       label: ('chat'),
          //       labelStyle: TextStyle(color: Colors.green),
          //       foregroundColor: Colors.green,
          //       backgroundColor: Colors.white,
          //     ),
          //   ],
          // ),
        );
      },
    );

  }


  _fetchUserDetails() async {
    final currentUser = await FirebaseAuth.instance.currentUser!;
    if (currentUser != null) {
      userId = currentUser.uid;
      await userCollection.doc(currentUser.uid).get().then((snapshot) {
        userFirstName = snapshot.get('first_name');
        userLastName = snapshot.get('last_name');
        userAddress = snapshot.get('address');
        userGender = snapshot.get('gender');
        userPhone = snapshot.get('phone');
        userImage = snapshot.get('image');
        role = snapshot.get('role');
        if(role == 'doctor'){
          doctorId = snapshot.get('doctor_id');
        }
        print(userFirstName);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
