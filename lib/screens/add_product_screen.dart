import 'dart:io';
import 'dart:math';
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import 'package:summer_home/widgets/profilepic.dart';
import 'package:provider/provider.dart';
import '../models/sell.dart';
import '../provider/sells.dart';

class AddProduct extends StatefulWidget {
  static const routname = "/addproduct";
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _userImage;
  final _gkey = GlobalKey<FormState>();
  final _focus = FocusNode();
  var _isloading = false;
  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  var _selldata = Sell(
    sid: DateTime.now().toString(),
    item: "",
    price: "",
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
        .child("product_image")
        .child(DateTime.now().toString() + ".jpg");

    await ref.putFile(_userImage!).whenComplete(() async {
      final url = await ref.getDownloadURL();

      setState(() {
        _selldata.imageurl = url;
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
      await Provider.of<Sells>(context, listen: false).addproduct(_selldata);
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
            "Products",
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
                    decoration: InputDecoration(labelText: "Item :"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus);
                    },
                    onSaved: (val) {
                      _selldata = Sell(
                          sid: _selldata.sid,
                          item: val,
                          price: _selldata.price,
                          imageurl: _selldata.imageurl,
                          nid: nid,
                          phno: _selldata.phno
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Price :"),
                    textInputAction: TextInputAction.done,
                    focusNode: _focus,
                    onSaved: (val) {
                      _selldata = Sell(
                          sid: _selldata.sid,
                          item: _selldata.item,
                          price: val,
                          imageurl: _selldata.imageurl,
                          nid: nid,
                          phno: _selldata.phno
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
                      _selldata = Sell(
                        sid: _selldata.sid,
                        item: _selldata.item,
                        price: _selldata.price,
                        imageurl: _selldata.imageurl,
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
