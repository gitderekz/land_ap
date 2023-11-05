import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_ai_test/components/doctor_card.dart';
import '../components/options_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/personalize_button.dart';

class BuyPlotPage extends StatefulWidget {
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
  BuyPlotPage({super.key,required this.hospitalId,required this.hospitalName,required this.hospitalImage,required this.hospitalLocation,required this.hospitalDescription,required this.hospitalSnapshot,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.receptionPhone,required this.userAddress});

  @override
  State<BuyPlotPage> createState() => _BuyPlotPageState();
}

class _BuyPlotPageState extends State<BuyPlotPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late CollectionReference doctorsReference;
  var looper,listSize = 0;
  List<String> doctorName = [],doctorImage = [],doctorProfession = [];
  String nchi = '-Nchi';
  List orodhaNchi = ['-Nchi','Tanzania','Rwanda','Kenya','Burundi','Uganda',];
  String mkoa = '-Mkoa';
  List orodhaMkoa = ['-Mkoa','Arusha','Dar es salaam','Dodoma','Kilimanjaro','Mwanza',];
  String wilaya = '-Wilaya';
  List orodhaWilaya = ['-Wilaya','Kinondoni','Ilala','Temeke','Ubungo','Kawe',];
  String matumizi = '-Matumizi';
  List orodhaMatumizi = ['-Matumizi','Ujenzi','Shamba','Biashara','Michezo','Starehe',];

  var query = FirebaseFirestore.instance.collection("viwanja");

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
                  PersonalizeButton(
                      userFirstName:widget.userFirstName,
                      userLastName:widget.userLastName,
                      userAddress:widget.userAddress,
                      userGender:widget.userGender,
                      userPhone:widget.userPhone,
                      userId:widget.userId
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            // page
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         //chujio
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   // nchi
            //                   Container(
            //                     margin: const EdgeInsets.all(1.0),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         border: Border.all(color: Theme.of(context).cardColor,width: 1)
            //                     ),
            //                     child: Container(
            //                       width: 120,
            //                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //                       child: DropdownButton(
            //                         hint: Text('Chagua Nchi'),
            //                         isExpanded: true,
            //                         value: nchi,
            //                         icon: Icon(Icons.arrow_drop_down),
            //                         iconSize: 36.0,
            //                         underline: SizedBox(),
            //                         onChanged: (newValue){
            //                           setState(() {
            //                             nchi = newValue.toString();
            //                           });
            //                         },
            //                         items: orodhaNchi.map((value){
            //                           // jazaOrodhaKundi();
            //                           return DropdownMenuItem(
            //                               value: value,
            //                               child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ),
            //                   // mikoa
            //                   Container(
            //                     margin: const EdgeInsets.all(1.0),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         border: Border.all(color: Theme.of(context).cardColor,width: 1)
            //                     ),
            //                     child: Container(
            //                       width: 120,
            //                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //                       child: DropdownButton(
            //                         hint: Text('Chagua Mkoa'),
            //                         isExpanded: true,
            //                         value: mkoa,
            //                         icon: Icon(Icons.arrow_drop_down),
            //                         iconSize: 36.0,
            //                         underline: SizedBox(),
            //                         onChanged: (newValue){
            //                           setState(() {
            //                             mkoa = newValue.toString();
            //                           });
            //                         },
            //                         items: orodhaMkoa.map((value){
            //                           // jazaOrodhaKundi();
            //                           return DropdownMenuItem(
            //                               value: value,
            //                               child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ),
            //                   // wilaya
            //                   Container(
            //                     // margin: const EdgeInsets.symmetric(horizontal: 25.0),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         border: Border.all(color: Theme.of(context).cardColor,width: 1)
            //                     ),
            //                     child: Container(
            //                       width: 120,
            //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                       child: DropdownButton(
            //                         hint: Text('Chagua Wilaya'),
            //                         isExpanded: true,
            //                         value: wilaya,
            //                         icon: Icon(Icons.arrow_drop_down),
            //                         iconSize: 36.0,
            //                         underline: SizedBox(),
            //                         onChanged: (newValue){
            //                           setState(() {
            //                             wilaya = newValue.toString();
            //                           });
            //                         },
            //                         items: orodhaWilaya.map((value){
            //                           // jazaOrodhaKundi();
            //                           return DropdownMenuItem(
            //                               value: value,
            //                               child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   // matumizi
            //                   Container(
            //                     // margin: const EdgeInsets.symmetric(horizontal: 25.0),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(15),
            //                         border: Border.all(color: Theme.of(context).cardColor,width: 1)
            //                     ),
            //                     child: Container(
            //                       width: 120,
            //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                       child: DropdownButton(
            //                         hint: Text('Chagua Wilaya'),
            //                         isExpanded: true,
            //                         value: matumizi,
            //                         icon: Icon(Icons.arrow_drop_down),
            //                         iconSize: 36.0,
            //                         underline: SizedBox(),
            //                         onChanged: (newValue){
            //                           setState(() {
            //                             matumizi = newValue.toString();
            //                           });
            //                         },
            //                         items: orodhaMatumizi.map((value){
            //                           // jazaOrodhaKundi();
            //                           return DropdownMenuItem(
            //                               value: value,
            //                               child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
            //                           );
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //         SizedBox(height: 8,),
            //         //viwanja card
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //           child: GridView.builder(
            //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //               // maxCrossAxisExtent: MediaQuery.of(context).size.width,
            //               mainAxisSpacing:4.0,
            //               crossAxisSpacing:2.0,
            //               childAspectRatio:1,
            //               crossAxisCount: 2,
            //             ),
            //             scrollDirection: Axis.vertical,
            //             shrinkWrap: true,
            //             primary: false,
            //             itemCount: doctorImage.length,
            //             itemBuilder: (BuildContext context, int index) {
            //
            //               return DoctorCard(doctorImagePath: doctorImage[index], doctorName: doctorName[index], doctorProfession: doctorProfession[index],hospitalId:widget.hospitalId,hospitalSnapshot:widget.hospitalSnapshot, receptionPhone: '',
            //                   // user details
            //                   userFirstName:widget.userFirstName,
            //                   userLastName:widget.userLastName,
            //                   userAddress:widget.userAddress,
            //                   userGender:widget.userGender,
            //                   userPhone:widget.userPhone,
            //                   userId:widget.userId);
            //
            //             },
            //           ),
            //         ),
            //         // SizedBox(height: 20,),
            //       ],
            //     ),
            //   ),
            // ),

            // page
            //chujio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // nchi
                      Container(
                        margin: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Theme.of(context).cardColor,width: 1)
                        ),
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DropdownButton(
                            hint: Text('Chagua Nchi'),
                            isExpanded: true,
                            value: nchi,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            onChanged: (newValue){
                              setState(() {
                                nchi = newValue.toString();
                              });
                            },
                            items: orodhaNchi.map((value){
                              // jazaOrodhaKundi();
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // mikoa
                      Container(
                        margin: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Theme.of(context).cardColor,width: 1)
                        ),
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DropdownButton(
                            hint: Text('Chagua Mkoa'),
                            isExpanded: true,
                            value: mkoa,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            onChanged: (newValue){
                              setState(() {
                                mkoa = newValue.toString();
                              });
                            },
                            items: orodhaMkoa.map((value){
                              // jazaOrodhaKundi();
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // wilaya
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Theme.of(context).cardColor,width: 1)
                        ),
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                            hint: Text('Chagua Wilaya'),
                            isExpanded: true,
                            value: wilaya,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            onChanged: (newValue){
                              setState(() {
                                wilaya = newValue.toString();
                              });
                            },
                            items: orodhaWilaya.map((value){
                              // jazaOrodhaKundi();
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // matumizi
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Theme.of(context).cardColor,width: 1)
                        ),
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                            hint: Text('Chagua Wilaya'),
                            isExpanded: true,
                            value: matumizi,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            onChanged: (newValue){
                              setState(() {
                                matumizi = newValue.toString();
                              });
                            },
                            items: orodhaMatumizi.map((value){
                              // jazaOrodhaKundi();
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis))
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //viwanja
            Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                        nchi!='-Nchi'&&mkoa!='-Mkoa'&&wilaya!='-Wilaya'&&matumizi!='-Matumizi'? query.where('nchi', isEqualTo: '$nchi').where('mkoa', isEqualTo: '$mkoa').where('wilaya', isEqualTo: '$wilaya').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        nchi!='-Nchi'&&mkoa!='-Mkoa'&&wilaya!='-Wilaya'? query.where('nchi', isEqualTo: '$nchi').where('mkoa', isEqualTo: '$mkoa').where('wilaya', isEqualTo: '$wilaya').snapshots():
                        nchi!='-Nchi'&&mkoa!='-Mkoa'&&matumizi!='-Matumizi'? query.where('nchi', isEqualTo: '$nchi').where('mkoa', isEqualTo: '$mkoa').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        mkoa!='-Mkoa'&&wilaya!='-Wilaya'&&matumizi!='-Matumizi'? query.where('mkoa', isEqualTo: '$mkoa').where('wilaya', isEqualTo: '$wilaya').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        nchi!='-Nchi'&&mkoa!='-Mkoa'? query.where('nchi', isEqualTo: '$nchi').where('mkoa', isEqualTo: '$mkoa').snapshots():
                        nchi!='-Nchi'&&wilaya!='-Wilaya'? query.where('nchi', isEqualTo: '$nchi').where('wilaya', isEqualTo: '$wilaya').snapshots():
                        nchi!='-Nchi'&&matumizi!='-Matumizi'? query.where('nchi', isEqualTo: '$nchi').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        mkoa!='-Mkoa'&&wilaya!='-Wilaya'? query.where('mkoa', isEqualTo: '$mkoa').where('wilaya', isEqualTo: '$wilaya').snapshots():
                        mkoa!='-Mkoa'&&matumizi!='-Matumizi'? query.where('mkoa', isEqualTo: '$mkoa').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        wilaya!='-Wilaya'&&matumizi!='-Matumizi'? query.where('wilaya', isEqualTo: '$wilaya').where('matumizi', isEqualTo: '$matumizi').snapshots():
                        nchi!='-Nchi'? query.where('nchi', isEqualTo: '$nchi').snapshots():
                        mkoa!='-Mkoa'? query.where('mkoa', isEqualTo: '$mkoa').snapshots():
                        wilaya!='-Wilaya'? query.where('wilaya', isEqualTo: '$wilaya').snapshots():
                        matumizi!='-Matumizi'? query.where('matumizi', isEqualTo: '$matumizi').snapshots()
                        :query.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        // maxCrossAxisExtent: MediaQuery.of(context).size.width,
                        mainAxisSpacing:4.0,
                        crossAxisSpacing:2.0,
                        childAspectRatio:1,
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snap.length,
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
                            doctorImagePath: snap[index]['image'][0],
                            doctorName: snap[index]['name'],
                            doctorProfession: snap[index]['mahali'],
                            hospitalId:snap[index]['bio'],
                            hospitalSnapshot:snapshot.data!,
                            receptionPhone: snap[index]['user_phone'],
                            // user details
                            userFirstName:widget.userFirstName,
                            userLastName:widget.userLastName,
                            userAddress:widget.userAddress,
                            userGender:widget.userGender,
                            userPhone:widget.userPhone,
                            userId:widget.userId);

                      },
                    );

                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
