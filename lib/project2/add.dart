import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorNumber = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorNumber.text,
      'Blood': selectedGroup,
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Donors"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Donor's Name")),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: donorNumber,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Phone Number")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                decoration: InputDecoration(label: Text(" Select Blood Group")),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedGroup = val;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                addDonor();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
