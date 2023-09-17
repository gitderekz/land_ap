import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_ai_test/pages/auth_page.dart';
import 'package:health_ai_test/theme.dart';
import 'package:provider/provider.dart';

import '../components/change_theme_button.dart';
import '../components/language_picker_widget.dart';
import '../components/upload_popup_single.dart';
import '../provider/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  // user details
  final userFirstName;
  final userLastName;
  final userAddress;
  final userGender;
  final userPhone;
  final userId;
  const Settings({Key? key,required this.userFirstName,required this.userLastName,required this.userGender,required this.userPhone,required this.userId,required this.userAddress}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(-6.65739756921744, 39.180670654801055), zoom: 14.4746,);
  PolylinePoints polylinePoints = PolylinePoints();

  // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
  //     _originLatitude, _originLongitude, _destLatitude, _destLongitude);
  // print(result.points);

  late GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double _originLatitude = -6.65739756921744, _originLongitude = 39.180670654801055;
  double _destLatitude = -6.656949227184276, _destLongitude = 39.18311536071334;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  String googleAPiKey = "AIzaSyDSCx4D_CNkpONihFo1JLr7O-kHk_YfT3Q";


  GoogleSignIn _googleSignIn = GoogleSignIn();
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docId = [];
  CollectionReference collection = FirebaseFirestore.instance.collection('users');

  // sign user out method
  Future<void> signUserOut() async {
    // await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //app bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back button
                    IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Navigator.pop(context); },),
                    //Name
                    Text(
                      user.email!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(padding: EdgeInsets.zero),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 8.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=>showDialog(context: context, builder: (BuildContext context) {
                            return UploadPopupSingle(
                                userFirstName:widget.userFirstName,
                                userLastName:widget.userLastName,
                                userAddress:widget.userAddress,
                                userGender:widget.userGender,
                                userPhone:widget.userPhone,
                                userId:widget.userId); }),
                          child: CircleAvatar(child: Image.network(user.photoURL!,height: 40,width: 40,),radius: 50,),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0,),
                    Text('Name: ${widget.userFirstName} ${widget.userLastName}'),
                    Text('Phone: ${widget.userPhone}'),
                    Text('Address: ${widget.userAddress}'),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),

              // dark/white mode
              Container(
                height: 50,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mode,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      ChangeThemeButtonWidget(),
                    ],
                  ),
                ),
              ),

              // change language
              Container(
                height: 50,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      LanguagePickerWidget(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              //logout
              InkWell(
                onTap: (){
                  // Navigator.pop(context);
                  signUserOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthPage()));
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.logout,color: Colors.green,),
                      ],
                    ),
                  ),
                ),
              ),

              // Expanded(
              //   child: FutureBuilder(
              //     future: getDocId(),
              //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //       return ListView.builder(itemCount: docId.length,itemBuilder: (context, index){
              //         return Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: ListTile(
              //             tileColor: Colors.grey[200],
              //             title: GetItem(documentId: docId.elementAt(index)),
              //           ),
              //         );
              //       });
              //     },
              //   ),
              // )

              // START MAP
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   child: Center(
              //     child: GoogleMap(
              //       // mapType: MapType.hybrid,
              //       // initialCameraPosition: _kGooglePlex,
              //       // onMapCreated: (GoogleMapController controller) {
              //       //   _controller.complete(controller);
              //       // },
              //       initialCameraPosition: CameraPosition(
              //           target: LatLng(_originLatitude, _originLongitude), zoom: 15),
              //       myLocationEnabled: true,
              //       tiltGesturesEnabled: true,
              //       compassEnabled: true,
              //       scrollGesturesEnabled: true,
              //       zoomGesturesEnabled: true,
              //       onMapCreated: _onMapCreated,
              //       markers: Set<Marker>.of(markers.values),
              //       polylines: Set<Polyline>.of(polylines.values),
              //     ),
              //   ),
              // ),
              // END MAP

            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {
    });
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "tegeta, Dar es salaam")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
