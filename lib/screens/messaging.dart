import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/shared/SliderImages.dart' as assets;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class ChatBox extends StatefulWidget {
  final Service service;
  ChatBox({Key key, this.service}) : super(key: key);

  static final String path = "lib/src/pages/misc/chat2.dart";
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final AuthServices _auth = AuthServices();



  String text;
  TextEditingController _controller;
  final List<String> avatars = [
    assets.avatars[3],
    assets.avatars[4],
  ];


  final List<Message> messages = [
    Message(0, "But I may not go if the weather is bad."),
    Message(0, "I suppose I am."),
    Message(1, "Are you going to market today?"),
    Message(0, "I am good too"),
    Message(1, "I am fine, thank you. How are you?"),
    Message(1, "Hi,"),
    Message(0, "How are you today?"),
    Message(0, "Hello,"),
  ];
  final rand = Random();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/image/chat_bg.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Chat Box"),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10.0);
                  },
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    Message m = messages[index];
                    if (m.user == 0) return _buildMessageRow(m, current: true);
                    return _buildMessageRow(m, current: false);
                  },
                ),
              ),
              _buildBottomBar(context),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Aa"
              ),
              onEditingComplete: _save,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _save,
          )
        ],
      ),
    );
  }

  _save() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      //TODO function to save in firestore
      messages.insert(0, Message(0, _controller.text));
      _controller.clear();
      for(int i=0; i<5; i++) print(messages[i].description);
    });
  }

  Row _buildMessageRow(Message message, {bool current}) {
    return Row(
      mainAxisAlignment:
      current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
      current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        if (!current) ...[
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              current ? avatars[0] : avatars[1],
            ),
            radius: 20.0,
          ),
          const SizedBox(width: 5.0),
        ],
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
              color: current ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            message.description,
            style: TextStyle(
                color: current ? Colors.white : Colors.black, fontSize: 18.0, fontFamily: 'cabin'),
          ),
        ),
        if (current) ...[
          const SizedBox(width: 5.0),
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              current ? avatars[0] : avatars[1],
            ),
            radius: 10.0,
          ),
        ],
        SizedBox(width: current ? 20.0 : 30.0),
      ],
    );
  }



  Future<DocumentSnapshot> getMessageStream(BuildContext context) async {
    final uid = await _auth.getCurrentUID();
    return Firestore.instance.collection('Messages').document(uid).collection('Services').document(widget.service.serviceId).get();
  }

}


class Message {
  final int user;
  final String description;

  Message(this.user, this.description);
}
