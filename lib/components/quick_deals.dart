import 'package:flutter/material.dart';
import 'package:health_ai_test/components/quick_deal_read_more.dart';
import 'package:lottie/lottie.dart';
import '../pages/hospital_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class QuickDeal extends StatefulWidget {
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

  const QuickDeal({
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
  State<QuickDeal> createState() => _QuickDealState();
}

class _QuickDealState extends State<QuickDeal> {
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
  @override
  Widget build(BuildContext context) {
    final orangeCardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Colors.green[100]
        : Colors.amber[200];//Colors.green[200];
    return
      InkWell(
        onTap: openHospitalPage,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Container(
            width: 80,
            margin: EdgeInsets.symmetric(vertical: 4),
            // padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                // boxShadow: [BoxShadow(color: Colors.green,offset: Offset(2, -2),blurRadius: 4)],
                color: Theme.of(context).cardColor,//,orangeCardColor
                // gradient: LinearGradient(colors: [Colors.white30,Colors.amber.shade100,Colors.deepOrange.shade100]),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //picture
                Container(
                  height:100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Lottie.asset(widget.hospitalImagePath),
                    // Image.network(
                    //   widget.hospitalImagePath,
                    //   height: 100,
                    // ),
                  ),
                ),
                SizedBox(height: 2,),

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

                //hospital title
                Text(widget.hospitalLocation),
                SizedBox(height: 2,),

                //read more
                QuickDealReadMore(
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
                SizedBox(height: 2,),

                // //visit
                // InkWell(
                //   onTap: openHospitalPage,
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
