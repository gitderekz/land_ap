import 'package:flutter/material.dart';

import '../pages/hospital_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReadMore extends StatefulWidget {
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

  const ReadMore({Key? key,required this.hospitalImagePath,required  this.hospitalName,required this.hospitalLocation,required this.hospitalDescription,required this.hospitalSnapshot,required this.hospitalId,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.receptionPhone,required this.userAddress}) : super(key: key);

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  void openHospitalPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HospitalPage(
      hospitalId:widget.hospitalId,hospitalName:widget.hospitalName,hospitalImage:widget.hospitalImagePath,hospitalLocation:widget.hospitalLocation,hospitalDescription:widget.hospitalDescription,hospitalSnapshot: widget.hospitalSnapshot,// user details
        userFirstName:widget.userFirstName,
        userLastName:widget.userLastName,
        userAddress:widget.userAddress,
        userGender:widget.userGender,
        userPhone:widget.userPhone,
        userId:widget.userId,
        receptionPhone: widget.receptionPhone,
    )));
  }

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
            context: context, builder: (context)=>readMore()
        ),
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
  Widget readMore(){
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
                      widget.hospitalImagePath,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 10,),

                  //hospital name
                  Text(
                    widget.hospitalName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.clip
                    ),
                  ),

                  //hospital location
                  Text(widget.hospitalLocation),
                  SizedBox(height: 10,),

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
              widget.hospitalLocation==widget.hospitalId?
               SizedBox(height: 0,width: 0,)
              :InkWell(
                onTap: (){
                  Navigator.pop(context);
                  openHospitalPage();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.visit,
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                      ),
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
