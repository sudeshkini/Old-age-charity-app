import 'package:flutter/cupertino.dart';
import 'package:summer_home/models/hire_grandma.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Jobs with ChangeNotifier {
  List<Job> _jitems = [
    // Job(
    //     jid: DateTime.now().toString(),
    //     name: "Binod",
    //     service: "BabySitting",
    //     imageurl: "",
    //     nid: "1"),
    // Job(
    //     jid: DateTime.now().toString(),
    //     name: "Binod",
    //     service: "BabySitting",
    //     imageurl: "",
    //     nid: "1"),
    // Job(
    //     jid: DateTime.now().toString(),
    //     name: "Binod",
    //     service: "BabySitting",
    //     imageurl: "",
    //     nid: "1"),
    // Job(
    //     jid: DateTime.now().toString(),
    //     name: "Binod",
    //     service: "BabySitting",
    //     imageurl: "",
    //     nid: "1"),
  ];

  List<Job> get jitem {
    return _jitems;
  }

  final String authToken;
  final String usermail;
  Jobs(this.authToken, this._jitems, this.usermail);

  Future<void> addjob(Job job) async {
    final url = Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/hire_grandma.json?auth=$authToken');
    final response = await http.post(url,
        body: json.encode({
          "jid":DateTime.now().toString(),
          "name": job.name,
          "service": job.service,
          "imageurl": job.imageurl,
          "nid": job.nid,
          "phno":job.phno,
        }));
    final newjob = Job(
        jid: json.decode(response.body)['name'],
        name: job.name,
        service: job.service,
        imageurl: job.imageurl,
        nid: job.nid,
        phno: job.phno,
    );
    _jitems.add(newjob);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/hire_grandma.json?auth=$authToken');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Job> loadedrequest = [];

    extractedData.forEach((key, val) {
      loadedrequest.add(Job(
        jid: key,
        name: val['name'],
        imageurl: val['imageurl'],
        nid: val['nid'],
        service: val['service'],
        phno: val['phno']
      ));
    });

    _jitems = loadedrequest;
    notifyListeners();
  }

  Future<void> deleteProds(String idd) async {
    final url =
        Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/hire_grandma.json?auth=$authToken');
    _jitems.removeWhere((prod) => prod.jid == idd);

    await http.delete(url);
    notifyListeners();
  }
}
