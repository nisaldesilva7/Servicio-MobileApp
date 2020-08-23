import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:servicio/services/uploader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDp extends StatefulWidget {

  final String customerPhoto;
  final String uid;
  const CustomerDp({Key key, this.uid,this.customerPhoto}) : super(key: key);


  @override
  _CustomerDpState createState() => _CustomerDpState();
}

class _CustomerDpState extends State<CustomerDp> {
  File _image;
  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery
    var image = await ImagePicker.pickImage(source: source);

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
                  child: widget.customerPhoto == null ? Image.asset('assets/image/no_dp.png', height: 300, width: 300, fit: BoxFit.contain):
                  Image.network(widget.customerPhoto, height: 300, width: 300, fit: BoxFit.contain)
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
            child: ImageUploader(_image),
          ): Text('Select a Profile Picture'),
          widget.customerPhoto != null ? RaisedButton(
            child: new Text("Delete"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () async {
              await Firestore.instance.collection('Customers').document(widget.uid).setData({
                'Photo' : null
              },
                  merge: true);
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
          ): Container()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 30,),
          FloatingActionButton.extended(
            label: Text("Camera"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(width: 10,),
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

