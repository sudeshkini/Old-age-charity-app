import 'dart:io';
import 'dart:math';
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import 'package:summer_home/models/hire_grandma.dart';
import 'package:summer_home/widgets/profilepic.dart';
import 'package:provider/provider.dart';
import 'package:summer_home/provider/hire_grandmaa.dart';

class AddJob extends StatefulWidget {
  static const routname = "/addjob";
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
   File? _userImage;
  final _gkey = GlobalKey<FormState>();
  final _focus = FocusNode();
   var _isloading = false;
  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  var _jobdata = Job(
      jid: DateTime.now().toString(),
      name: "",
      service: "",
      imageurl: "",
      nid: Random().nextInt(100000).toString(),
      phno: "",
  );
  void _pickedImage(File image) async {
    setState(() {
      _userImage = image; //for getting the image form the widgets
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_image")
        .child(DateTime.now().toString() + ".jpg");

    await ref.putFile(_userImage!).whenComplete(() async {
      final url = await ref.getDownloadURL();

      setState(() {
        _jobdata.imageurl = url;
      });
    });
  }

  Future<void> _saveform() async {
    print('_saveform() started');
    setState(() {
      _isloading = true;
    });
    _gkey.currentState!.save();
    try {
      await Provider.of<Jobs>(context, listen: false).addjob(_jobdata);
    } catch (error) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("!!Error"),
          content: Text("An error ocuured due to somme issue "),
          actions: <Widget>[
            TextButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final nid = ModalRoute.of(context)!.settings.arguments as String?;
    return Theme(
        data: ThemeData(
          primaryColor: Colors.blue, // set the primary color to blue
        ),
    child: Scaffold(
      //make the form here for adding the hire me data .
        appBar: AppBar(
          title: Text(
            "Hire a Grandma",
            style: TextStyle(fontSize: 22),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _saveform();
                })
          ],
        ),
        body:_isloading
            ? Center(
          child: CircularProgressIndicator(),
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _gkey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProfilePic(_pickedImage),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name :"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus);
                    },
                    onSaved: (val) {
                      _jobdata = Job(
                          jid: _jobdata.jid,
                          name: val,
                          service: _jobdata.service,
                          imageurl: _jobdata.imageurl,
                          nid: nid,
                           phno: _jobdata.phno
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Servies :"),
                    textInputAction: TextInputAction.done,
                    focusNode: _focus,
                    onSaved: (val) {
                      _jobdata = Job(
                          jid: _jobdata.jid,
                          name: _jobdata.name,
                          service: val,
                          imageurl: _jobdata.imageurl,
                          nid: nid,
                          phno: _jobdata.phno
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Phone Number :"),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus);
                    },
                    onSaved: (val) {
                      _jobdata = Job(
                          jid: _jobdata.jid,
                          name: _jobdata.name,
                          service: _jobdata.service,
                          imageurl: _jobdata.imageurl,
                          nid: nid,
                          phno: val,
                      );
                    },
                  ),
                ],
              )),
        )
    )
    );
  }
}
