import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

pickSingleImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
}

pickImage(ImageSource source) async{
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? files = await imagePicker.pickMultiImage();
  List<Uint8List> images = [];
  if(files.isNotEmpty){
    for(var file in files ){
      images.add(await file.readAsBytes());
    }
    return images;//await _files.readAsBytes();
  }
}