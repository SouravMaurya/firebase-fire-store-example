import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firstore/firebase/firebase_curd.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'List of User',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            customBorder: const CircleBorder(),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: (snapshot.data!.docs.isNotEmpty ) ? ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                    elevation: 2,
                      child: Column(children: [
                    ListTile(
                      title: Text(e["first_name"] + " " + e['last_name']),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Contact Number: " + e['contact_no'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Qualfication: " + e['qualification'],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            foregroundColor: Colors.blueAccent,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {},
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response = await FirebaseCrud.deleteUser(docId: e['contact_no']);
                            Fluttertoast.showToast(
                              msg: response.message.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ) :  Center(
                child: Text(
                  'There is not entry in database, Go back and add user',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  'There is some issue in fetching data, Please try again!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
