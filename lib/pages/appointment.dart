
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../components/my_textfield.dart';
import '../components/options_popup.dart';

class Appointment extends StatefulWidget {
  final hospitalId,hospitalName;
  var hospitalSnapshot;
  // user details;
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  Appointment({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.hospitalId,required this.hospitalName,required this.hospitalSnapshot,required this.userAddress }) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final hospitalController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final mainComplainController = TextEditingController();
  TimeOfDay timePicker = TimeOfDay.now();
  String timeController = 'Choose Time';
  DateTime datePicker = DateTime.now();
  String dateController = 'Choose Date';
  List clinicList = ['-Choose Clinic'];
  List doctorList = ['-Choose Doctor'];
  List sessionList = ['-Choose Session'];
  List doctorIdList = [''];
  List sessionIdList = [''];
  String chosenClinic = '-Choose Clinic';
  String chosenDoctor = '-Choose Doctor';
  String chosenSession = '-Choose Session';
  String doctorId = '';
  String sessionId = '';
  late CollectionReference doctorsReference,sessionsReference,clinicsReference,appointmentsReference;
  List hospitalList = [],timeList = [],dateList = [],appointmentTimeList = [],appointmentIdList = [],hospitalIdList = [],toggleValueList = [];

  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userFirstName;
    lastNameController.text = widget.userLastName;
    genderController.text = widget.userGender;
    phoneController.text = widget.userPhone;
    hospitalController.text = widget.hospitalName;
    populateClinics();
    loadAppointments();
  }

  TextStyle textStyle(){
    return TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold
    );
  }

  void loadAppointments(){
    widget.hospitalSnapshot.docs.forEach((element) {
      // if(widget.hospitalId == element.id){
      appointmentsReference = element.reference.collection('appointments');
      appointmentsReference.get().then((value) {
        if(mounted){
          setState(() {
            for(int x=0;x<value.size;x++){
              if(widget.userId == value.docs[x].get('user_id')){
                //   doctorList.add(value.docs[x].get('doctor'));
                hospitalIdList.add(element.id);
                appointmentIdList.add(value.docs[x].id);
                toggleValueList.add(value.docs[x].get('answer'));
                hospitalList.add(value.docs[x].get('hospital').toString().replaceAll(' ', '\n'));
                dateList.add(value.docs[x].get('date'));
                timeList.add(value.docs[x].get('time'));
                appointmentTimeList.add(value.docs[x].get('session'));
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
    super.dispose();
    hospitalController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    mainComplainController.dispose();
  }

  void populateClinics(){
    widget.hospitalSnapshot.docs.forEach((element) {
      if(widget.hospitalId == element.id){
        clinicsReference = element.reference.collection('clinics');
        clinicsReference.get().then((value) {
          if(mounted){
            setState(() {
              for(int x=0;x<value.size;x++){
                clinicList.add(value.docs[x].get('name'));
              }
            });
          }
        });
      }
    });
  }

  populateDoctors()async {
    widget.hospitalSnapshot.docs.forEach((element) {
      if(widget.hospitalId == element.id){
        doctorsReference = element.reference.collection('doctors');
        doctorsReference.get().then((value) {
          if(mounted){
            setState(() {
              for(int x=0;x<value.size;x++){
                if(chosenClinic == value.docs[x].get('clinic')){
                  doctorList.add(value.docs[x].get('name'));
                  doctorIdList.add(value.docs[x].get('doctor_id'));
                }
              }
            });
          }
        });
      }
    });
  }

  populateSessions()async {
    widget.hospitalSnapshot.docs.forEach((element) {
      if(widget.hospitalId == element.id){
        sessionsReference = element.reference.collection('sessions');
        sessionsReference.get().then((value) {
          if(mounted){
            setState(() {
              for(int x=0;x<value.size;x++){
                if(doctorId == value.docs[x].id){
                  print('$doctorId == ${value.docs[x].id}');
                // if(chosenDoctor == value.docs[x].get('doctor')){
                  // sessionList.add(value.docs[x].get('name'));
                  if(value.docs[x].get('monday') != ''){
                    sessionList.add(value.docs[x].get('monday'));
                  }
                  if(value.docs[x].get('tuesday') != ''){
                    sessionList.add(value.docs[x].get('tuesday'));
                  }
                  if(value.docs[x].get('wednesday') != ''){
                    sessionList.add(value.docs[x].get('wednesday'));
                  }
                  if(value.docs[x].get('thursday') != ''){
                    sessionList.add(value.docs[x].get('thursday'));
                  }
                  if(value.docs[x].get('friday') != ''){
                    sessionList.add(value.docs[x].get('friday'));
                  }
                  if(value.docs[x].get('saturday') != ''){
                    sessionList.add(value.docs[x].get('saturday'));
                  }
                  if(value.docs[x].get('sunday') != ''){
                    sessionList.add(value.docs[x].get('sunday'));
                  }

                  sessionIdList.add(value.docs[x].get('doctor'));
                }
              }
            });
          }
        });
      }
    });
  }

  void _showTimePicker(){
    showTimePicker(
        context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        timePicker = value!;
        timeController = timePicker.format(context).toString();
      });
    });
  }

  void _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050)
    ).then((value) {
      setState(() {
        datePicker = value!;
        dateController = '${datePicker.month}-${datePicker.day}-${datePicker.year}';
      });
    });
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
              child: IconButton(icon: Icon(Icons.arrow_back_ios,),
                onPressed: () { Navigator.pop(context); },
              )
          ),
          title: Center(
              child: Text(
                'Appointment',
                style: TextStyle(fontSize: 16),
              ),
          ),
          actions: [
            //profile
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=>showDialog(context: context, builder: (BuildContext context) { return OptionsPopup(
                      userFirstName:widget.userFirstName,
                      userLastName:widget.userLastName,
                      userAddress:widget.userAddress,
                      userGender:widget.userGender,
                      userPhone:widget.userPhone,
                      userId:widget.userId); }),
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
                      )
                  ),
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
                      Tab(text: 'Make Appointment',icon: Icon(Icons.calendar_month,color: Colors.green,),),
                      Tab(text: 'View Appointment',icon: Icon(Icons.calendar_month,color: Colors.green[300],),)
                    ]
                  ),
                  SizedBox(height: 8.0,),

                  //Tab bodies
                  Expanded(
                     child:
                     TabBarView(
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
                                      // autofill text fields
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
                                      SizedBox(height: 8.0,),

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
                                      SizedBox(height: 8.0,),

                                      // hospital textfield
                                      MyTextField(
                                        controller: hospitalController,
                                        hintText: 'Hospital',
                                        obscureText: false,
                                      ),
                                      SizedBox(height: 8.0,),

                                      // clinic dropdown
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: Colors.white,width: 1)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButton(
                                            hint: Text('Choose Clinic'),
                                            isExpanded: true,
                                            value: chosenClinic,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36.0,
                                            underline: SizedBox(),
                                            onChanged: (newValue){
                                              setState(() {
                                                chosenClinic = newValue.toString();
                                                chosenDoctor = '-Choose Doctor';
                                                doctorList = ['-Choose Doctor'];
                                                doctorId = '';
                                                doctorIdList = [''];
                                                populateDoctors();
                                              });
                                            },
                                            items: clinicList.map((value){
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value)
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0,),

                                      // doctors dropdown
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Colors.white,width: 1)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButton(
                                            hint: Text('Choose Session'),
                                            isExpanded: true,
                                            value: chosenDoctor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36.0,
                                            underline: SizedBox(),
                                            onChanged: (newValue){
                                              // get doctor id
                                              int index = 0;
                                              doctorList.forEach((element) {
                                                if(newValue.toString() == element.toString()){
                                                  doctorId = doctorIdList[index];
                                                  print(doctorId);
                                                }
                                                index++;
                                              });
                                              setState(() {
                                                chosenDoctor = newValue.toString();
                                                chosenSession = '-Choose Session';
                                                sessionList = ['-Choose Session'];
                                                sessionId = '';
                                                sessionIdList = [''];
                                                populateSessions();
                                              });
                                            },
                                            items: doctorList.map((value){
                                              return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value)
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0,),

                                      // main complain textfield
                                      MyTextField(
                                        controller: mainComplainController,
                                        hintText: 'main complain',
                                        obscureText: false,
                                      ),
                                      SizedBox(height: 8.0,),

                                      // Choose Session
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Colors.white,width: 1)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButton(
                                            hint: Text('Choose Session'),
                                            isExpanded: true,
                                            value: chosenSession,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36.0,
                                            underline: SizedBox(),
                                            onChanged: (newValue){
                                              // get doctor id
                                              int index = 0;
                                              sessionList.forEach((element) {
                                                if(newValue.toString() == element.toString()){
                                                  sessionId = sessionList[index];
                                                  print(sessionId);
                                                }
                                                index++;
                                              });
                                              setState(() {
                                                chosenSession = newValue.toString();
                                              });
                                            },
                                            items: sessionList.map((value){
                                              return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value)
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),

                                      // date & time picker
                                      SizedBox(height: 8.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Container(
                                          //   margin: const EdgeInsets.only(left: 25.0),
                                          //   decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(15),
                                          //       border: Border.all(color: Colors.white,width: 1)
                                          //   ),
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          //     child: TextButton(
                                          //       onPressed: _showDatePicker,
                                          //       child: Text(
                                          //         dateController,
                                          //         style: TextStyle(fontSize: 18),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 25.0,right: 25.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(color: Colors.white,width: 1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: TextButton(
                                                onPressed: _showTimePicker,
                                                child: Text(
                                                  timeController,
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                      SizedBox(height: 8.0,),
                                    ],
                                  ),
                                ),

                                Divider(
                                  thickness: 1.0,
                                  color: Theme.of(context).dividerColor,
                                ),

                                // Back and Submit Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    //Back
                                    InkWell(
                                      onTap: ()=>Navigator.pop(context),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.arrow_back_ios,color: Colors.red,),
                                              SizedBox(width: 8.0,),
                                              Text(
                                                'Back',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 20,),

                                    //send
                                    InkWell(
                                      onTap: (){
                                        // var timestamp = Timestamp.now().toString();
                                        var time = TimeOfDay.now().format(context).toString();
                                        var dateTime = DateTime.now();
                                        String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                                        String dateAndTime = date+time.replaceAll(' ', '');

                                        if(chosenClinic!='-Choose Clinic' && chosenDoctor!='-Choose Doctor' && chosenSession!='-Choose Session' && firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && phoneController.text.isNotEmpty && hospitalController.text.isNotEmpty && genderController.text.isNotEmpty )
                                        {
                                          FirebaseFirestore.instance.collection('hospitals').doc(widget.hospitalId).collection('appointments')
                                              .doc('${widget.userId},$dateAndTime').set(
                                            {
                                              'answer':false,
                                              'first_name':firstNameController.text.trim(),
                                              'last_name':lastNameController.text.trim(),
                                              'phone':phoneController.text.trim(),
                                              'gender':genderController.text.trim(),
                                              'hospital':hospitalController.text.trim(),
                                              'clinic':chosenClinic,
                                              'doctor':chosenDoctor,
                                              'doctor_id':doctorId,
                                              'main_complain':mainComplainController.text.trim(),
                                              'date':DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                              // 'time':'08:00 AM\n16:00 PM',
                                              // 'date':dateController,
                                              'time':timeController,
                                              'session':chosenSession,
                                              'user_id':widget.userId,
                                            }
                                          ).then((value) {
                                            setState(() {
                                              chosenClinic = '-Choose Clinic';
                                              chosenDoctor = '-Choose Doctor';
                                              chosenSession = '-Choose Session';
                                              timeController = 'Choose Time';
                                              dateController = 'Choose Date';
                                              mainComplainController.clear();
                                            });
                                          });
                                        }else{
                                          sessionList.forEach((element) {
                                            print(element);
                                          });
                                          print(DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now()));
                                          Fluttertoast.showToast(msg: 'Fill all fields');
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.send,color: Colors.green,),
                                              SizedBox(width: 8.0,),
                                              Text(
                                                'send',
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
                                  ],
                                ),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                          ),

                          //view appointment tab
                          Container(
                            // margin: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              // color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Hospital',style: textStyle()),
                                    Text('Time',style: textStyle()),
                                    Text('Answer',style: textStyle()),
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
                                          constraints: BoxConstraints.expand(width: 2.0,height: 70),
                                          child:
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text('${index+1}'),
                                                  Text('${hospitalList[index]}'),
                                                  // Text('${dateList[index]}\n${timeList[index]}',),
                                                  Text('${appointmentTimeList[index].replaceAll(' ', '\n')}\n${timeList[index]}',),
                                                  Text(
                                                    toggleValueList[index]?'Confirmed':'Unconfirmed',
                                                    style: TextStyle(color: toggleValueList[index]?Colors.green:Colors.red),
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
}
