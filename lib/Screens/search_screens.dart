import 'package:chatter_app/Components/default_button.dart';
import 'package:chatter_app/Components/search_tile.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingContoller = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot searchSnapshot;

  getUser() {
    databaseMethods
        .getUserByUsername(searchTextEditingContoller.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return Expanded(
        child: searchSnapshot != null
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: searchSnapshot.docs.length,
                itemBuilder: (context, index) {
                  return SearchTile(
                    userEmail: searchSnapshot.docs[index].data()["email"],
                    userName: searchSnapshot.docs[index].data()["name"],
                  );
                })
            : Container());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 3),
        child: Column(
          children: [
            Container(
                height: 50.0,
                width: double.infinity,
                decoration: kSearchBarDecortion,
                child: TextField(
                  onSubmitted: getUser(),
                  controller: searchTextEditingContoller,
                  decoration: kSearchTextFieldDecoration,
                )),
            SizedBox(
              height: kDefaultPadding,
            ),
            Divider(
              thickness: 2,
              color: Colors.black26,
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}
