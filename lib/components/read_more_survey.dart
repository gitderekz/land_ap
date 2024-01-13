import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../pages/hospital_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReadMoreSurvey extends StatefulWidget {
  final hospitalImagePath;
  final hospitalName;
  final hospitalLocation;
  final hospitalDescription;
  final hospitalSnapshot;
  final hospitalId;
  final receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;

  const ReadMoreSurvey({Key? key, required this.hospitalImagePath, required this.hospitalName, required this.hospitalLocation, required this.hospitalDescription, required this.hospitalSnapshot, required this.hospitalId, required this.userFirstName, required this.userLastName, required this.userGender, required this.userPhone, required this.userId, required this.receptionPhone, required this.userAddress}) : super(key: key);

  @override
  State<ReadMoreSurvey> createState() => _ReadMoreSurveyState();
}

class _ReadMoreSurveyState extends State<ReadMoreSurvey> {
  void openHospitalPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HospitalPage(
                  hospitalId: widget.hospitalId, hospitalName: widget.hospitalName, hospitalImage: widget.hospitalImagePath, hospitalLocation: widget.hospitalLocation, hospitalDescription: widget.hospitalDescription, hospitalSnapshot: widget.hospitalSnapshot, // user details
                  userFirstName: widget.userFirstName,
                  userLastName: widget.userLastName,
                  userAddress: widget.userAddress,
                  userGender: widget.userGender,
                  userPhone: widget.userPhone,
                  userId: widget.userId,
                  receptionPhone: widget.receptionPhone, userImage: 'null',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))), context: context, builder: (context) => ReadMoreSurvey()),
      child: Text(
        AppLocalizations.of(context)!.read_more,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 16,
        ),
      ),
    );
  }

  //bottom sheet
  Widget ReadMoreSurvey() {
    return Container(
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
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.hospitalImagePath,
                      height: 100,
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
                      AppLocalizations.of(context)!.close,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  // Navigator.pop(context);
                  await FlutterPhoneDirectCaller.callNumber(widget.receptionPhone);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.call_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
