import 'package:firebase_firstore/firebase/firebase_curd.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userContactNoController = TextEditingController();
  final userAddressNoController = TextEditingController();
  final userFContactNoController = TextEditingController();
  final userMContactNoController = TextEditingController();
  final userQualificationNoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        controller: userFirstNameController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "First Name*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));
    final lastNameField = TextFormField(
        controller: userLastNameController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Last Name*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));
    final contactNoField = TextFormField(
        controller: userContactNoController,
        autofocus: false,
        keyboardType: TextInputType.number,
        maxLength: 10,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contact No.*",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ));
    final addressField = TextFormField(
        controller: userAddressNoController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Address.*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));
    final qualificationField = TextFormField(
        controller: userQualificationNoController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Qualification.*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));
    final fatherContactField = TextFormField(
        controller: userFContactNoController,
        autofocus: false,
        maxLength: 10,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Father Contact No.*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));
    final motherContactField = TextFormField(
        controller: userMContactNoController,
        autofocus: false,
        maxLength: 10,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Mother Contact No.*",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))));

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            saveDatIntoDatabase();
          }
        },
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Firebase FireStore Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: saveButton,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    firstNameField,
                    const SizedBox(height: 15.0),
                    lastNameField,
                    const SizedBox(height: 15.0),
                    contactNoField,
                    const SizedBox(height: 15.0),
                    qualificationField,
                    const SizedBox(height: 15.0),
                    addressField,
                    const SizedBox(height: 15.0),
                    fatherContactField,
                    const SizedBox(height: 15.0),
                    motherContactField,
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveDatIntoDatabase() async {
    Map<String, dynamic> reqBody = {
      "first_name": userFirstNameController.text.toString().trim(),
      "last_name": userLastNameController.text.toString().trim(),
      "address": userAddressNoController.text.toString().trim(),
      "qualification": userQualificationNoController.text.toString().trim(),
      "contact_no": userContactNoController.text.toString().trim(),
      "father_contact_no": userFContactNoController.text.toString().trim(),
      "mother_contact_no": userMContactNoController.text.toString().trim(),
    };

    var response = await FirebaseCrud.addUser(req: reqBody);
    Fluttertoast.showToast(
      msg: response.message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    clearFields();
  }

  void clearFields() {
    userFirstNameController.text = '';
    userLastNameController.text = '';
    userContactNoController.text = '';
    userAddressNoController.text = '';
    userQualificationNoController.text = '';
    userFContactNoController.text = '';
    userMContactNoController.text = '';
    setState(() {
    });
  }
}
