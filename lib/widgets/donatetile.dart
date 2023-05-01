import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_home/provider/donator.dart';

import '../screens/donar_details_screen.dart';

class DonateTile extends StatelessWidget {
  final String did;
  DonateTile(this.did);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Card(
        child: Consumer<Donator>(
          builder: (context, donator, _) {
            final itemslist = donator.dlist;
            final data = itemslist.firstWhere((i) => i.did == did);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: 80,
                          child: FadeInImage(
                            placeholder: AssetImage(
                              "assets/images/signin_balls.png",
                            ),
                            image: NetworkImage(data.imageurl??''),
                            fit: BoxFit.cover,
                          ),
                          //Image.network(
                          //data.imageurl,
                          //fit: BoxFit.cover,

                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                data.ditem??'',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data.msg??'',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    data.daddress??'',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Donated by " + (data.dname??''),
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                     /* TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) =>  DonateDetailScreen(),
                                ),
                            );
                            /*Navigator.of(context).pushNamed(
                                "/donatedetailscreen",
                                arguments: did!);*/
                          },
                          child: Text(
                            "Details",
                            style:
                            TextStyle(fontSize: 15, color: Colors.blue),
                          ))*/
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
