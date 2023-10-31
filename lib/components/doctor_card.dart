import 'package:flutter/material.dart';
import 'package:health_ai_test/components/read_more.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorCard extends StatelessWidget {
  final doctorImagePath;
  final doctorName;
  final doctorProfession;
  final hospitalId;
  final hospitalSnapshot;
  final receptionPhone;
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;

  const DoctorCard({
    Key? key,
    required this.doctorImagePath,
    required this.doctorName,
    required this.doctorProfession,
    required this.hospitalId,
    required this.hospitalSnapshot,
    required this.receptionPhone,required this.userFirstName,required this.userLastName,required this.userAddress,required this.userGender,required this.userPhone,required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: ()=>showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0)
                )
            ),
            context: context, builder: (context)=>readMore(context)
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    doctorImagePath,
                    height: 100,
                  ),
                ),
                SizedBox(height: 10,),

                //rating
                // Row(
                //   children: [
                //     Icon(
                //       Icons.star,
                //       color: Colors.yellow[600],
                //     ),
                //     Text(
                //       doctorRate,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10,),

                //doctor name
                Text(
                  doctorName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    overflow: TextOverflow.clip
                  ),
                ),

                //doctor title
                Text(doctorProfession,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),

                //read more
                // ReadMore(
                //   hospitalImagePath: doctorImagePath,
                //   hospitalName: doctorName,
                //   hospitalLocation: hospitalId,
                //   hospitalDescription: doctorProfession,
                //   hospitalSnapshot: hospitalSnapshot,
                //   hospitalId:hospitalId,
                //   receptionPhone:receptionPhone,
                //     // user details
                //     userFirstName:userFirstName,
                //     userLastName:userLastName,
                //     userAddress:userAddress,
                //     userGender:userGender,
                //     userPhone:userPhone,
                //     userId:userId
                // ),
              ],
            ),
          ),
        ),
      );
  }

  //bottom sheet
  Widget readMore(context){
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: 200,                             //commented
            child: Padding(                             //added
              padding: const EdgeInsets.all(0.0),
              child: Column(                            //ListView -> Column
                // scrollDirection: Axis.vertical,      //commented
                children: [//picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      doctorImagePath,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 10,),

                  //hospital name
                  Text(
                    doctorName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.clip
                    ),
                  ),

                  //hospital location
                  Text(hospitalId),
                  SizedBox(height: 10,),

                  //hospital description
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          doctorProfession,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.close,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0,width: 0,)
            ],
          ),

        ],
      ),
    );
  }
}
