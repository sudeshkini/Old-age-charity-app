import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/sells.dart';

class ProductTile extends StatelessWidget {
  final String sid;
  ProductTile(this.sid);

  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<Sells>(context, listen: false).sitem;
    final data = itemslist.firstWhere((i) => i.sid == sid);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      //maxRadius: 40,
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        data.imageurl ?? '',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Item:",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          data.item ?? '',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Price:",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          data.price ?? '',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Phone Number:",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          data.phno ?? '',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
