import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/donate.dart';
import '../provider/donator.dart';
import '../widgets/drawer.dart';

class DonateDetailScreen extends StatelessWidget {
  static const routname = "/donatedetailscreen";
  @override
  Widget build(BuildContext context) {
    final did = ModalRoute.of(context)!.settings.arguments as String?;
    final dlistdata = Provider.of<Donator>(context).dlist;
    late Donate data;
    try {
      data = dlistdata.firstWhere((i) => i.did == did);
    } catch (e) {
      // Handle the Bad state: No element error
      print(e.toString());
      print(did);
      return Theme(
          data: ThemeData(
            primaryColor: Colors.blue, // set the primary color to blue
          ),
      child: Scaffold(
        body: Center(
          child: Text('No matching data found.'),
        ),
      )
      );
    }
    return Theme(
    data: ThemeData(
    primaryColor: Colors.blue, // set the primary color to blue
      ),
    child: Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child:Image.asset(
            'assets/images/l2.jpg',
            fit: BoxFit.cover,
          ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Item :",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data.ditem??'',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Person Name :",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data.dname??'',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Donater Address :",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data.daddress??'',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Contact Number :",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data.phno??'',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    ),
    );
  }
}
