import 'package:flutter/material.dart';
import 'package:summer_home/provider/volunteers.dart';
import 'package:provider/provider.dart';

import '../screens/volunteer_details_screen.dart';

class VolunteerTile extends StatelessWidget {
  final String vid;
  VolunteerTile({required this.vid});
  @override
  Widget build(BuildContext context) {
    final itemslist = Provider.of<Volunteers>(context, listen: false).vitems;
    final data = itemslist.firstWhere((i) => i.id == vid);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    data.purpose??'',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    data.date??'',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  data.time??'',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  data.location??'',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            /*TextButton(
              child: Text("View Detail",
                  style: TextStyle(fontSize: 15, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  VolunteerDetailScreen(),
                  ),
                );
                /*Navigator.of(context)
                    .pushNamed("/volunteerdetailscreen", arguments: vid);*/
              },
            )*/
          ],
        ),
      ),
    );
  }
}
