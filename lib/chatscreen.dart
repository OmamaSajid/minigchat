import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/welcomescreen.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? logedin;

class ChatScreen extends StatefulWidget {
  static const String id = 'chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgcntrl = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? logedin;
  late String messgaetext;
  final _firestore = FirebaseFirestore.instance;
  void initState() {
    super.initState();
    getuser();
  }

  void getuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        logedin = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️ G-Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs.reversed;
                  List<txtbubble> detailedinfo = [];
                  for (var document in messages) {
                    final messagetext = document.get('Text') as String;
                    final messagesender = document.get('Sender') as String;
                    final cuser = logedin!.email;

                    final widget = txtbubble(
                        messagetext, messagesender, cuser == messagesender);
                    detailedinfo.add(widget);
                  }
                  return Expanded(
                    child: ListView(
                      //reverse: true,
                      children: detailedinfo,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgcntrl,
                      onChanged: (value) {
                        messgaetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      msgcntrl.clear();
                      _firestore.collection('messages').add({
                        'Text': messgaetext,
                        'Sender': logedin!.email,
                        'timestamp': Timestamp.now()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class txtbubble extends StatelessWidget {
  late final text;
  late final sender;
  late bool isme;
  txtbubble(final text, final sender, bool isme) {
    this.text = text;
    this.sender = sender;
    this.isme = isme;
  }
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
              elevation: 5.0,
              borderRadius: isme
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isme ? Colors.blueAccent : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  text,
                  style: TextStyle(color: isme ? Colors.white : Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
