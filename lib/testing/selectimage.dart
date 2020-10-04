import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:servicio/services/uploader.dart';

class SelectImages extends StatefulWidget {
  @override
  _SelectImagesState createState() => _SelectImagesState();
}

class _SelectImagesState extends State<SelectImages> {
  File _image;
  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery
    var image = await ImagePicker.pickImage(source: source,preferredCameraDevice: CameraDevice.front);

    //Cropping the image
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),

      maxWidth: 512,
      maxHeight: 512,
    );

    //Compress the image
//TODO implement the image compress function
//    var result = await FlutterImageCompress.compressAndGetFile(
//      croppedFile.path,
//      croppedFile.path,
//      quality: 50,
//    );

    var result = croppedFile;
    setState(() {
      _image = result;
      print(_image.lengthSync());
    });
  }

  void _clear(){
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_image?.lengthSync());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Image"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Center(
              child: _image == null
                  ? ClipRRect(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                             ),
                   child: Image.asset('assets/image/no-image.png', height: 300, width: 300, fit: BoxFit.contain)
              )
                  : Image.file(
                       _image,
                        height: 300,
                        width: 300,
                        fit:  BoxFit.contain,

                      ),
            ),
          ),
          SizedBox(height: 10.0,),
          _image != null ? RaisedButton.icon(
            color: Colors.red,
            onPressed: () => _clear(),
            icon: Icon(Icons.clear, color: Colors.white,),
            label: Text("Delete",style: TextStyle(color: Colors.white),),
          ): SizedBox.shrink(),

          _image != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 10.0 ),
            child: ImageUploader(_image,'ccsc'),
          ): Text('Select a Profile Picture'),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text("Camera"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(width: 20,),
          FloatingActionButton.extended(
            label: Text("Gallery"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          )
        ],
      ),
    );
  }
}

