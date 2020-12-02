import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class CreateContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateContactState();
  }
}

class _CreateContactState extends State<CreateContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contacts'),
      ),
    );
  }
}
