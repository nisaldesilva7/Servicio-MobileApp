import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          toolbarColor: Colors.indigo,
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
        title: Text("Select Image".toUpperCase()),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
                icon: Icon(Icons.delete), onPressed: () async{
              await Firestore.instance.collection('Customers').document(widget.uid).setData({
                'Photo' : 'https://firebasestorage.googleapis.com/v0/b/servicio-11f11.appspot.com/o/images%2Fno_dp.png?alt=media&token=f83a02f3-e9f3-4cc9-83b7-d62c596938bb'
              },
                  merge: true);
            }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            _image != null ? IconButton(
              onPressed: () => _clear(),
              icon: Icon(Icons.clear, color: Colors.red,size: 40,),
            ): SizedBox.shrink(),

            _image != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 10.0 ),
              child: RaisedButton(
                child: Text('Upload'),
                onPressed: () async{
                  DateTime now = new DateTime.now();
                  var datestamp = new DateFormat("yyyyMMdd'T'HHmmss");
                  String currentdate = datestamp.format(now);

                  var ref = FirebaseStorage.instance.ref().child("image/$currentdate.jpg");
                  var uploadTask = ref.putFile(_image);
                  var storageTaskSnapshot = await uploadTask.onComplete;
                  var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

                  await Firestore.instance.collection('Customers').document(widget.uid).setData({
                    'Photo' : downloadUrl,
                  },
                      merge: true);
                  Navigator.pop(context);
                },
              ),
            ): Text('Select a Profile Picture'),
          ],
        ),
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

