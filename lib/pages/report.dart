import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/my_textfield.dart';
import '../components/options_popup.dart';

class Report extends StatefulWidget {
  final hospitalId, hospitalName;
  var hospitalSnapshot;
  // final hospitalRate;
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  Report({Key? key, required this.userFirstName, required this.userLastName, required this.userGender, required this.userPhone, required this.userId, required this.hospitalId, required this.hospitalName, required this.hospitalSnapshot, required this.userAddress}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  ReceivePort _port = ReceivePort();
  final hospitalController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final briefNoteController = TextEditingController();
  final fileNumberController = TextEditingController();
  final lastPhoneController = TextEditingController();
  final locationController = TextEditingController();
  final kinPhoneController = TextEditingController();
  final kinNameController = TextEditingController();
  late CollectionReference doctorsReference, clinicsReference, appointmentsReference;
  List hospitalList = [], timeList = [], dateList = [], doctorsList = [], appointmentIdList = [], hospitalIdList = [], reportLinkList = [], reportNameList = [], filePresence = [];

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userFirstName;
    lastNameController.text = widget.userLastName;
    genderController.text = widget.userGender;
    phoneController.text = widget.userPhone;
    hospitalController.text = widget.hospitalName;

    loadReports();
  }

  TextStyle textStyle() {
    return TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
  }

  void loadReports() {
    widget.hospitalSnapshot.docs.forEach((element) {
      // if(widget.hospitalId == element.id){
      appointmentsReference = element.reference.collection('reports');
      appointmentsReference.get().then((value) {
        if (mounted) {
          setState(() {
            for (int x = 0; x < value.size; x++) {
              if (widget.userId == value.docs[x].get('user_id')) {
                //   doctorList.add(value.docs[x].get('doctor'));
                filePresence.add(false);
                hospitalIdList.add(element.id);
                appointmentIdList.add(value.docs[x].id);
                reportLinkList.add(value.docs[x].get('report_link'));
                reportNameList.add(value.docs[x].get('first_name') + '\nmedical report');
                hospitalList.add(value.docs[x].get('hospital').toString().replaceAll(' ', '\n'));
                dateList.add(value.docs[x].get('date'));
                timeList.add(value.docs[x].get('time'));
                checkFilePresence(value.docs[x].get('first_name') + '-medical-report(${hospitalIdList[x]} ${dateList[x]}).pdf', x);
              }
            }
          });
        }
      });
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    hospitalController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    briefNoteController.dispose();
    fileNumberController.dispose();
    lastPhoneController.dispose();
    locationController.dispose();
    kinPhoneController.dispose();
    kinNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          leading: Container(
              margin: EdgeInsets.only(left: 25),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          title: Center(
            child: Text(
              'Report',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            //profile
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OptionsPopup(userFirstName: widget.userFirstName, userLastName: widget.userLastName, userAddress: widget.userAddress, userGender: widget.userGender, userPhone: widget.userPhone, userImage: 'widget.userImage', userId: widget.userId);
                      }),
                  child: Container(
                      margin: EdgeInsets.only(right: 25.0),
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
          ],
        ),
        body: SafeArea(
          // child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //tab titles
              TabBar(
                  // indicator: ,
                  labelColor: Colors.green[600],
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Request Medical Report',
                      icon: Icon(
                        Icons.note_alt,
                        color: Colors.green,
                      ),
                    ),
                    Tab(
                      text: 'View Medical Report',
                      icon: Icon(
                        Icons.note_alt_outlined,
                        color: Colors.green[300],
                      ),
                    )
                  ]),
              SizedBox(
                height: 8.0,
              ),

              //Tab bodies
              Expanded(
                child: TabBarView(
                  children: [
                    //make appointment tab
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: firstNameController,
                                        hintText: 'first name',
                                        obscureText: false,
                                      ),
                                    ),
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: lastNameController,
                                        hintText: 'last name',
                                        obscureText: false,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: genderController,
                                        hintText: 'Gender',
                                        obscureText: false,
                                      ),
                                    ),
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: phoneController,
                                        hintText: 'Phone',
                                        obscureText: false,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                // hospital textfield
                                MyTextField(
                                  controller: hospitalController,
                                  hintText: 'Hospital',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                MyTextField(
                                  controller: locationController,
                                  hintText: 'Location (mkunguni, dar es salaam)',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                // main complain textfield
                                MyTextField(
                                  controller: briefNoteController,
                                  hintText: 'Brief note',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                Divider(
                                  thickness: 2.0,
                                  color: Theme.of(context).dividerColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Center(
                                    child: Text(
                                      'Last used hospital details',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                MyTextField(
                                  controller: fileNumberController,
                                  hintText: 'File number (Not mandatory)',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                MyTextField(
                                  controller: lastPhoneController,
                                  hintText: 'Phone number used',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: kinNameController,
                                        hintText: 'Next kin name',
                                        obscureText: false,
                                      ),
                                    ),
                                    // first name textfield
                                    Expanded(
                                      child: MyTextField(
                                        controller: kinPhoneController,
                                        hintText: 'Next kin phone',
                                        obscureText: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Theme.of(context).dividerColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //close
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          'Back',
                                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 20,
                              ),

                              //send
                              InkWell(
                                onTap: () {
                                  // var timestamp = Timestamp.now();
                                  var time = TimeOfDay.now().format(context).toString();
                                  var dateTime = DateTime.now();
                                  String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                                  String dateAndTime = date + time.replaceAll(' ', '');

                                  FirebaseFirestore.instance.collection('hospitals').doc(widget.hospitalId).collection('reports').doc('${widget.userId}$dateAndTime').set({
                                    'first_name': firstNameController.text.trim(),
                                    'last_name': lastNameController.text.trim(),
                                    'gender': genderController.text.trim(),
                                    'phone': phoneController.text.trim(),
                                    'hospital': hospitalController.text.trim(),
                                    'brief_note': briefNoteController.text.trim(),
                                    'file_number': fileNumberController.text.trim(),
                                    'last_phone': lastPhoneController.text.trim(),
                                    'location': locationController.text.trim(),
                                    'kin_name': kinNameController.text.trim(),
                                    'kin_phone': kinPhoneController.text.trim(),
                                    'user_id': widget.userId,
                                    'report_link': '',
                                    'time': time,
                                    'date': date,
                                  }).then((value) {
                                    setState(() {
                                      locationController.clear();
                                      briefNoteController.clear();
                                      fileNumberController.clear();
                                      lastPhoneController.clear();
                                      kinNameController.clear();
                                      kinPhoneController.clear();
                                    });
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.send,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          'send',
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),

                    //view report tab
                    Container(
                      // margin: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        // color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(2),
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
                              Text('Report Name', style: textStyle()),
                              Text('Download', style: textStyle()),
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
                                              '${reportNameList[index]}\n${dateList[index]} ${timeList[index]}',
                                            ),
                                            filePresence[index]
                                                ? ElevatedButton.icon(
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                      ),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      openReport('open', '${reportLinkList[index]}', '${reportNameList[index].toString().replaceAll('\nmedical report', '')}-medical-report(${hospitalIdList[index]} ${dateList[index]}).pdf');
                                                    },
                                                    icon: Icon(Icons.check_circle),
                                                    label: Text('Open'))
                                                : ElevatedButton.icon(
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                      ),
                                                      backgroundColor: Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      openReport('download', '${reportLinkList[index]}', '${reportNameList[index].toString().replaceAll('\nmedical report', '')}-medical-report(${hospitalIdList[index]} ${dateList[index]}).pdf');
                                                      checkFilePresence('${reportNameList[index].toString().replaceAll('\nmedical report', '')}-medical-report(${hospitalIdList[index]} ${dateList[index]}).pdf', index);
                                                    },
                                                    icon: Icon(Icons.download_for_offline),
                                                    label: Text('download'))
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
                  ],
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  Future<void> openReport(String action, String url, String? fileName) async {
    if (action == 'open') {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/${fileName}');
      if (file == null) {
        await downloadFile(url, fileName!);
      } else {
        final file = await downloadFile(url, fileName!);
        if (file == null) return;
        print('Path ${file.path}');
        OpenFile.open(file.path);
      }
    } else {
      // final name = fileName?? url.split('/').last;
      final file = await downloadFile(url, fileName!);
      // final file = await pickFile();
      if (file == null) return;
      print('Path ${file.path}');
      OpenFile.open(file.path);
    }
  }

  Future checkFilePresence(String name, int index) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = await File('${appStorage.path}/${name}').exists();
      setState(() {
        filePresence[index] = file;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/${name}');
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
          // validateStatus: (status) { return status! < 500; }
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }
}
