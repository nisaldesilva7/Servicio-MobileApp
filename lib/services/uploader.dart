import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageUploader extends StatefulWidget {
  final File file;
  const ImageUploader(this.file);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://servicio-11f11.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if(_uploadTask.isComplete)
                  Text('PROFILE PHOTO UPLOADED SUCCESFULLY'),
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                ),
              ],
            );
          });
    }
    else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Set As Profile Picture'),
        icon: Icon(CupertinoIcons.profile_circled, color: Colors.blueAccent,),
        onPressed: _startUpload,
      );

    }
  }
}