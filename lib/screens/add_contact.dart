import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController;
  TextEditingController _numberController;
  DatabaseReference _ref;

  String _workType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('contacts');
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
            color: _workType == title
                ? Colors.green
                : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )),
      onTap: () {
        setState(() {
          _workType = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Contact'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
            
              controller: _numberController,
              decoration: InputDecoration(
                  hintText: 'Enter Contact Number',
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15)),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildContactType('Work'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildContactType('Friends'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildContactType('Family'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildContactType('Others'),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Save Contact',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  saveContact();
                },
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    Map<String, String> contact = {
      'name': name,
      'number':'+91 ' +number,
      'type': _workType,
    };

    _ref.push().set(contact).then((value) => {
      Navigator.pop(context)
    });
  }
}
