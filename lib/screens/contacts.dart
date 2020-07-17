import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/models/contact_model.dart';
import 'package:flutter_database/screens/add_contact.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Query _reference;

  @override
  void initState() {
    super.initState();
    _reference = FirebaseDatabase.instance
        .reference()
        .child('contacts')
        .orderByChild('name');
        
        
  }

  List<ContactModel> contactList = [];
  Widget _buildContactItem(ContactModel model) {
    Color secondaryColor = getTypeColor(model.type);
    return Container( 
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(Icons.person, size: 20, color: Theme.of(context).primaryColor),
            SizedBox(
              width: 6,
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.phone_iphone,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                model.number,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(width: 20),
              Icon(
                Icons.group_work,
                size: 20,
                color: secondaryColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                model.type,
                style: TextStyle(fontSize: 16, color: secondaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
      body: Container(
          color: Colors.white10,
          height: double.infinity,
          child: FirebaseAnimatedList(
              query: _reference,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                    print('MUR SNAP ${snapshot.value}');
                String name = snapshot.value['name'];
                String number = snapshot.value['number'];
                String type = snapshot.value['type'];
                String key = snapshot.key;
                ContactModel model = ContactModel(
                    name: name, number: number, type: type, key: key);
                return _buildContactItem(model);
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddContact();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  getContactsFromDb() {
    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child('contacts');

    ref.onChildAdded.listen((event) {
      Map<String, String> map = event.snapshot.value;
    });
  }

  Color getTypeColor(String type) {
    Color typeColor = Colors.red;
    if (type == 'Work') {
      typeColor = Colors.brown;
    }

    if (type == 'Family') {
      typeColor = Colors.green;
    }

    if (type == 'Friends') {
      typeColor = Colors.teal;
    }

    return typeColor;
  }
}
