import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sell.dart';

class Sells with ChangeNotifier {
  List<Sell> _sitems = [
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

  List<Sell> get sitem {
    return _sitems;
  }

  final String authToken;
  final String usermail;
  Sells(this.authToken, this._sitems, this.usermail);

  Future<void> addproduct(Sell sell) async {
    final url = Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/sell.json?auth=$authToken');
    final response = await http.post(url,
        body: json.encode({
          "sid":DateTime.now().toString(),
          "item": sell.item,
          "price": sell.price,
          "imageurl": sell.imageurl,
          "nid": sell.nid,
          "phno":sell.phno,
        }));
    final newsell = Sell(
      sid: json.decode(response.body)['name'],
      item: sell.item,
      price: sell.price,
      imageurl: sell.imageurl,
      nid: sell.nid,
      phno: sell.phno,
    );
    _sitems.add(newsell);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/sell.json?auth=$authToken');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    final List<Sell> loadedrequest = [];

    extractedData.forEach((key, val) {
      loadedrequest.add(Sell(
          sid: key,
          item: val['item'],
          imageurl: val['imageurl'],
          nid: val['nid'],
          price: val['price'],
          phno: val['phno']
      ));
    });

    _sitems = loadedrequest;
    notifyListeners();
  }

  Future<void> deleteProds(String idd) async {
    final url =
    Uri.parse('https://summer-home-f1a64-default-rtdb.asia-southeast1.firebasedatabase.app/sell.json?auth=$authToken');
    _sitems.removeWhere((prod) => prod.sid == idd);

    await http.delete(url);
    notifyListeners();
  }
}
