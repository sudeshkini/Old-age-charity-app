/*import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {

  Query dbRef = FirebaseDatabase.instance.ref().child('donate');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('donate');

  Widget listItem({required Map donate}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            donate['daddress'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['ditem'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['imageurl'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['message'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['name'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['nid'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            donate['number'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  reference.child(donate['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                  ],
                ),
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
          title: const Text('Fetching data'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              Map donate = snapshot.value as Map;
              donate['key'] = snapshot.key;

              return listItem(donate: donate);

            },
          ),
        )
    );
  }
}*/
/*import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:summer_home/models/donate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Donator with ChangeNotifier {
  List<Donate> _dlist = [
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "jignesh",

    //     ///date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Manglesh",
    //     // date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Jagga",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Tomu",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
  ];

  List<Donate> get dlist {
    return [..._dlist];
  }

  final String authToken;
  final String usermail;
  Donator(this.authToken, this._dlist, this.usermail);
  Future<void> addrequest(Donate donate) async {
    final ref = FirebaseDatabase.instance.reference().child('donate');
    try {
      await ref.push().set({
        'nid': donate.nid,
        'dname': donate.dname,
        'ditem': donate.ditem,
        'phno': donate.phno,
        'daddress': donate.daddress,
        'imageurl': donate.imageurl,
        'message': donate.msg,
      });
      final newDonate = Donate(
        did: donate.did,
        nid: donate.nid,
        dname: donate.dname,
        ditem: donate.ditem,
        phno: donate.phno,
        daddress: donate.daddress,
        imageurl: donate.imageurl,
        msg: donate.msg,
      );
      _dlist.add(newDonate);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetData() async {
    final ref = FirebaseDatabase.instance.reference().child('donate');
    try {
      final dataSnapshot = await ref.once();
      final data = dataSnapshot.snapshot.value as Map<dynamic, dynamic>; // Cast to a Map<dynamic, dynamic> type
      if (data != null) {
        final List<Donate> loadedData = [];
        data.forEach((key, value) {
          loadedData.add(Donate(
            did: key,
            nid: value['nid'],
            dname: value['name'],
            ditem: value['email'],
            phno: value['phone'],
            daddress: value['address'],
            imageurl: value['imageurl'],
            msg: value['message'],
          ));
        });
        _dlist = loadedData;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }


  Future<void> deleteProds(String idd) async {
    final url =
    Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/donate/$idd.json?auth=$authToken');
    _dlist.removeWhere((prod) => prod.did == idd);

    await http.delete(url);
    notifyListeners();
  }
}*/
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:summer_home/models/donate.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/donate.dart';

class Donator with ChangeNotifier {
  List<Donate> _dlist = [
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "jignesh",

    //     ///date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Manglesh",
    //     // date: "22-12-20",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Jagga",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
    // Donate(
    //     did: DateTime.now().toString(),
    //     dname: "Tomu",
    //     ditem: "clothes",
    //     daddress: "Near Jammu and Kashmir",
    //     imageurl: "",
    //     msg: "i have clothes to donate",
    //     nid: "1",
    //     phno: "9098789867"),
  ];

  List<Donate> get dlist {
    return _dlist;
  }

  final String authToken;
  final String usermail;
  Donator(this.authToken, this._dlist, this.usermail);
  Future<void> addrequest(Donate dd) async {
    final url =
        Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/donate.json?auth=$authToken');
    final response = await http.post(url,
        body: json.encode({
          'did':DateTime.now().toString(),
          "name": dd.dname,
          "daddress": dd.daddress,
          "number": dd.phno,
          "nid": Random().nextInt(100000).toString(),
          "message": dd.msg,
          "imageurl": dd.imageurl,
          "ditem": dd.ditem,
        }));

    final newRequest = Donate(
      did: json.decode(response.body)['name'],
      dname: dd.dname,
      daddress: dd.daddress,
      phno: dd.phno,
      nid: dd.nid,
      msg: dd.msg,
      ditem: dd.ditem,
      imageurl: dd.imageurl,
    );

    _dlist.add(newRequest);

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url =
       Uri.parse( 'https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/donate.json?auth=$authToken');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Donate> loadedrequest = [];

    extractedData.forEach((key, val) {
      loadedrequest.add(Donate(
        did: key,
        imageurl: val['imageurl'],
        daddress: val['daddress'],
        ditem: val['ditem'],
        dname: val['name'],
        msg: val['message'],
        nid: val['nid'],
        phno: val['number'],
      ));
    });

    _dlist = loadedrequest;
    notifyListeners();
  }

  Future<void> deleteProds(String idd) async {
    final url =
        Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/donate/$idd.json?auth=$authToken');
    _dlist.removeWhere((prod) => prod.did == idd);

    await http.delete(url);
    notifyListeners();
  }
}

