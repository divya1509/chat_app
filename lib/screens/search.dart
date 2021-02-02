import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/screens/chat.dart';
import 'package:chatapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();

  QuerySnapshot searchSnapShot;

  initiateSearch() {
    databaseMethods.getUserByName(searchEditingController.text).then((val) {
      setState(() {
        searchSnapShot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapShot.documents.length,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapShot.documents[index].data["name"],
                email: searchSnapShot.documents[index].data["email"],
              );
            })
        : Container();
  }

  createChatRoomAndStartConversation(String userName) {
    String chatRoomId = getCharRoomId(userName, Constants.myName);

    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId,
    };

    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatScreen(chatRoomId)));
  }

  Widget searchTile({String userName, String email}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.black54,
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () => createChatRoomAndStartConversation(userName),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 17),
              child: Text(
                "Message",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo[50],
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.indigo[100],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: searchEditingController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "search username...",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                        ),
                      )),
                      GestureDetector(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black26,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  )),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }
}

getCharRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
