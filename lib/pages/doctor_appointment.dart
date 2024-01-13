import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/options_popup.dart';

class DoctorAppointment extends StatefulWidget {
  final doctorId;
  final doctorName;
  var hospitalSnapshot;
  // user details;
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  DoctorAppointment({Key? key, required this.doctorId, required this.doctorName, required this.hospitalSnapshot, required this.userFirstName, required this.userLastName, required this.userAddress, required this.userGender, required this.userPhone, required this.userId}) : super(key: key);

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  int value = 0;
  bool positive = false;
  bool loading = false;
  late CollectionReference doctorsReference, appointmentsReference;
  List hospitalList = [], timeList = [], dateList = [], doctorList = [], appointmentIdList = [], hospitalIdList = [], toggleValueList = [];
  final DataTableSource _data = MyData();
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAppointments();
  }

  TextStyle textStyle() {
    return TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
  }

  void loadAppointments() {
    widget.hospitalSnapshot.docs.forEach((element) {
      // if(widget.hospitalId == element.id){
      print('hospitali = ${element.id} ${widget.doctorId}');
      appointmentsReference = element.reference.collection('appointments');
      appointmentsReference.get().then((value) {
        if (mounted) {
          setState(() {
            for (int x = 0; x < value.size; x++) {
              if (widget.doctorId == value.docs[x].get('doctor_id')) {
                //   doctorList.add(value.docs[x].get('doctor'));
                hospitalIdList.add(element.id);
                appointmentIdList.add(value.docs[x].id);
                toggleValueList.add(value.docs[x].get('answer'));
                hospitalList.add(value.docs[x].get('hospital').toString().replaceAll(' ', '\n'));
                dateList.add(value.docs[x].get('date'));
                timeList.add(value.docs[x].get('time'));
              }
            }
          });
        }
      });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey.withOpacity(0.8),
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
                      'Hi, dr. ${widget.doctorName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ]),

                  //profile
                  InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OptionsPopup(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userAddress: widget.userAddress, userGender: widget.userGender, userPhone: widget.userPhone, userImage: 'widget.userImage', userId: widget.userId);
                        }),
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // main body
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Hospital', style: textStyle()),
                        Text('Time', style: textStyle()),
                        Text('Answer', style: textStyle()),
                      ],
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Theme.of(context).dividerColor,
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: timeList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.expand(width: 2.0, height: 70),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text('${index + 1}'),
                                      Text('${hospitalList[index]}'),
                                      Text(
                                        '${dateList[index]}\n${timeList[index]}',
                                      ),
                                      AnimatedToggleSwitch<bool>.dual(
                                        current: toggleValueList[index], //positive,
                                        first: false,
                                        second: true,
                                        dif: 35.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0, //5.0,
                                        height: 45,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 1.5),
                                          ),
                                        ],
                                        onChanged: (b) {
                                          setState(() => toggleValueList[index] = b /*positive = b*/);
                                          print('current at = ${index + 1}, ${hospitalIdList[index]}, ${appointmentIdList[index]}');
                                          FirebaseFirestore.instance.collection('hospitals').doc(hospitalIdList[index]).collection('appointments').doc(appointmentIdList[index]).update({
                                            'doctor': widget.doctorName,
                                            'answer': toggleValueList[index],
                                            // 'doctor_id':widget.doctorId,
                                            // 'date':dateController,
                                            // 'time':timeController
                                          });
                                          //     .set(
                                          //     {
                                          //       'doctor':chosenDoctor,
                                          //       'doctor_id':doctorId,
                                          //       'date':dateController,
                                          //       'time':timeController,
                                          //     }
                                          // );
                                          return Future.delayed(Duration(seconds: 2));
                                        },
                                        colorBuilder: (b) => b ? Colors.green : Theme.of(context).cardColor, // Colors.black12,
                                        iconBuilder: (value) => value
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.cancel,
                                              ),
                                        textBuilder: (value) => value ? Center(child: Text('accepted')) : Center(child: Text('declined')),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ],
                              ),
                              // ListView(
                              //   scrollDirection: Axis.horizontal,
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       mainAxisSize: MainAxisSize.max,
                              //       children: [
                              //         Text('Rabininsia '),
                              //         Text(
                              //           '20/01/2023 12:00 am',
                              //           style: TextStyle(
                              //             color: Colors.brown,
                              //           ),
                              //         ),
                              //         Text('Feedback '),
                              //       ],
                              //     )
                              //   ],
                              // ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )

            // PaginatedDataTable(
            //   source: _data,
            //   header: const Text('My Products'),
            //   columns: const <DataColumn>[
            //     DataColumn(label: Text('Hospital')),
            //     DataColumn(label: Text('Time')),
            //     DataColumn(label: Text('Answer'))
            //   ],
            //   columnSpacing: 50,
            //   horizontalMargin: 10,
            //   rowsPerPage: 8,
            //   showCheckboxColumn: false,
            // ),
          ],
        ),
      ),
    );
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(200, (index) => {"id": index, "title": "Item $index", "price": Random().nextInt(10000)});

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);
  }
}
