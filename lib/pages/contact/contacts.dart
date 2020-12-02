import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contacts/pages/contact/contact_details.dart';
import 'package:contacts/pages/contact/create_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contacts> {
  Iterable<Contact> contacts = [];
  Iterable<Contact> filteredContacts = [];
  TextEditingController _searchContactController = TextEditingController();
  bool searchContact = false;

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  void getContacts() async {
    // Get all contacts on device
    ContactsService.getContacts().then((c) => setState(() {
          contacts = c;
          filteredContacts = c;
        }));
  }

  void getPermission() async {
    var status = await Permission.contacts.status.isGranted;
    if (status) {
      getContacts();
    } else {
      bool permissionStatus = await Permission.contacts.request().isGranted;
      if (permissionStatus) getContacts();
    }
  }

  Widget _buildContactList(BuildContext context, index) {
    return Card(
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ContactDetails(
                          contact: filteredContacts.elementAt(index))));
            },
            title: Text(
              filteredContacts.elementAt(index).displayName,
              style:
                  TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
            ),
            leading: filteredContacts.elementAt(index).avatar.isNotEmpty
                ? CircleAvatar(
                    backgroundImage:
                        MemoryImage(filteredContacts.elementAt(index).avatar),
                  )
                : CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.contacts_rounded),
                  ),
          )
        ],
      ),
    );
  }

  Widget _createContact() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CreateContact()));
      },
      icon: Icon(Icons.contact_phone),
      label: Text('Create Contact'),
    );
  }

  Widget _appBar() {
    return AppBar(
      leading: searchContact
          ? BackButton(
              onPressed: () {
                setState(() {
                  searchContact = false;
                  _searchContactController.clear();
                  filteredContacts = contacts;
                });
              },
            )
          : Container(),
      title: searchContact
          ? TextField(
              controller: _searchContactController,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Search contacts',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white30),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              onChanged: (query) {
                if (query != '') {
                  setState(() {
                    filteredContacts = contacts.where((contact) {
                      String displayName = contact.displayName.toLowerCase();
                      return displayName.contains(query.toLowerCase());
                    }).toList();
                  });
                } else {
                  setState(() {
                    filteredContacts = contacts;
                  });
                }
              },
            )
          : Container(),
      actions: [
        !searchContact
            ? IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searchContact = true;
                  });
                },
              )
            : Container()
      ],
    );
  }

  Widget _contactList() {
    return filteredContacts.length > 0
        ? ListView.builder(
            itemBuilder: _buildContactList,
            itemCount: filteredContacts.length,
          )
        : Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar(),
      body: _contactList(),
      floatingActionButton: _createContact(),
    );
  }
}
