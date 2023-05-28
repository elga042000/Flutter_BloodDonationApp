import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorNumber = TextEditingController();

  void UpdateDonor(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorNumber.text,
      'Blood': selectedGroup,
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorNumber.text = args['phone'];
    selectedGroup = args['Blood'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Donors"),
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
                value: selectedGroup,
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
                UpdateDonor(docId);
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
