import 'package:contacts/pages/contact/contact_image.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetails extends StatelessWidget {
  final Contact contact;
  final Color color;
  ContactDetails({this.contact, this.color});

  Widget _buildActions(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.call_end_outlined,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    // Android
                    var uri = 'tel:${contact.phones.elementAt(0).value}';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      // iOS
                      var uri = 'tel:${contact.phones.elementAt(0).value}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    }
                  },
                ),
                Text(
                  'Call',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.sms_outlined,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    // Android
                    var uri = 'sms:${contact.phones.elementAt(0).value}';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      // iOS
                      var uri = 'sms:${contact.phones.elementAt(0).value}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    }
                  },
                ),
                Text(
                  'Text',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    // Android
                    var uri = 'mailto:${contact.emails.first}';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      // iOS
                      var uri = 'mailto:${contact.emails.first}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    }
                  },
                ),
                Text(
                  'Email',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
          ),
          flex: 1,
        )
      ],
    );
  }

  Widget _contactImage(BuildContext context) {
    return contact.avatar.isNotEmpty
        ? GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.memory(
                contact.avatar,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactImage(contact.avatar)));
            },
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: color,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 120,
            ),
          );
  }

  Widget _contactTitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Text(
        contact.displayName,
        style: TextStyle(
          fontSize: 22,
          height: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _contactAbout() {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: [
          Text(
            'ABOUT ${contact.givenName.toUpperCase()}',
            style: TextStyle(
              fontSize: 12,
              height: 2,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar(context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _contactImage(context),
          _contactTitle(),
          Divider(
            color: Colors.white,
          ),
          _buildActions(context),
          Divider(
            color: Colors.white,
          ),
          _contactAbout(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}
