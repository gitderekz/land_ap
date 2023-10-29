import 'package:flutter/material.dart';
import 'package:health_ai_test/components/read_more.dart';
import '../pages/buy_plot_page.dart';
import '../pages/hospital_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/survey_plot_page.dart';

class HospitalCard extends StatefulWidget {
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

  const HospitalCard({
    Key? key,
    required this.hospitalImagePath,
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalDescription,
    required this.hospitalSnapshot,
    required this.hospitalId,
    required this.receptionPhone,
    // user details
    required this.userFirstName,required this.userLastName,
    required this.userGender,required this.userPhone,
    required this.userId,required this.userAddress
  }) : super(key: key);

  @override
  State<HospitalCard> createState() => _HospitalCardState();
}

class _HospitalCardState extends State<HospitalCard> {
  void openHospitalPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HospitalPage(
        hospitalName:widget.hospitalName,
        hospitalImage:widget.hospitalImagePath,
        hospitalLocation:widget.hospitalLocation,
        hospitalDescription:widget.hospitalDescription,
        hospitalSnapshot:widget.hospitalSnapshot,
        hospitalId:widget.hospitalId,
        receptionPhone: widget.receptionPhone,
        // user details
        userFirstName:widget.userFirstName,
        userLastName:widget.userLastName,
        userAddress:widget.userAddress,
        userGender:widget.userGender,
        userPhone:widget.userPhone,
        userId:widget.userId
    )));
  }
  void openBuyPlotPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyPlotPage(
        hospitalName:widget.hospitalName,
        hospitalImage:widget.hospitalImagePath,
        hospitalLocation:widget.hospitalLocation,
        hospitalDescription:widget.hospitalDescription,
        hospitalSnapshot:widget.hospitalSnapshot,
        hospitalId:widget.hospitalId,
        receptionPhone: widget.receptionPhone,
        // user details
        userFirstName:widget.userFirstName,
        userLastName:widget.userLastName,
        userAddress:widget.userAddress,
        userGender:widget.userGender,
        userPhone:widget.userPhone,
        userId:widget.userId
    )));
  }
  void openSurveyPlot(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SurveyPlotPage(
        hospitalName:widget.hospitalName,
        hospitalImage:widget.hospitalImagePath,
        hospitalLocation:widget.hospitalLocation,
        hospitalDescription:widget.hospitalDescription,
        hospitalSnapshot:widget.hospitalSnapshot,
        hospitalId:widget.hospitalId,
        receptionPhone: widget.receptionPhone,
        // user details
        userFirstName:widget.userFirstName,
        userLastName:widget.userLastName,
        userAddress:widget.userAddress,
        userGender:widget.userGender,
        userPhone:widget.userPhone,
        userId:widget.userId
    )));
  }
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: widget.hospitalName=='Buy Plot'?openBuyPlotPage: widget.hospitalName=='Survey Plot'?openSurveyPlot:openHospitalPage,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            width: 160,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //picture
                Container(
                  decoration: BoxDecoration(
                  color: Colors.yellow[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.hospitalImagePath,
                      height: 100,
                      width: 150,
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //hospital name
                Flexible(
                  child: Text(
                    widget.hospitalName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.clip
                    ),
                  ),
                ),

                // //hospital title
                // Text(widget.hospitalLocation),
                SizedBox(height: 10,),

                //read more
                ReadMore(
                    hospitalImagePath: widget.hospitalImagePath,
                    hospitalName: widget.hospitalName,
                    hospitalLocation: widget.hospitalLocation,
                    hospitalDescription: widget.hospitalDescription,
                    hospitalSnapshot: widget.hospitalSnapshot,
                    hospitalId:widget.hospitalId,
                    receptionPhone:widget.receptionPhone,
                    // user details
                    userFirstName:widget.userFirstName,
                    userLastName:widget.userLastName,
                    userAddress:widget.userAddress,
                    userGender:widget.userGender,
                    userPhone:widget.userPhone,
                    userId:widget.userId
                ),
                SizedBox(height: 8.0,),

                // //visit
                // InkWell(
                //   onTap: widget.hospitalName=='Buy Plot'?openBuyPlotPage: widget.hospitalName=='Survey Plot'?openSurveyPlot:openHospitalPage,
                //   child: Container(
                //     padding: EdgeInsets.all(12),
                //     decoration: BoxDecoration(
                //       color: Colors.green[300],
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Center(
                //       child: Text(
                //         AppLocalizations.of(context)!.visit,
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // )

              ],
            ),
          ),
        ),
      );
  }
}
