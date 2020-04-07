import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String messagetext;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
      // print(loggedInUser.email);
    }
  }

  // void getMessages() async {
  //   final messages = await firestore.collection('chats').getDocuments();
  //   for (var messages in messages.documents) {
  //     print(messages.data);
  //   }
  // }

  void messagesStream() async {
    await for (var snapshot in firestore.collection('chats').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
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
                //Implement logout functionality

                // messagesStream();

                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      controller: messageTextController,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      // chats sender text
                      messageTextController.clear();
                      firestore.collection('chats').add(
                          {'text': messagetext, 'sender': loggedInUser.email});
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

class MesageBubble extends StatelessWidget {
  final String sender;
  final String text;

  final isMe;

  const MesageBubble({Key key, this.sender, this.text, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: Theme.of(context).textTheme.body2,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              elevation: 5,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: Text(
                  '$text',
                  style: isMe
                      ? TextStyle(color: Colors.white)
                      : TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('chats').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final messages = snapshot.data.documents.reversed;
          List<MesageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            final currentUser = loggedInUser.email;

            final messageBubble = MesageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }
}
