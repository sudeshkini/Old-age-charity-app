import 'package:flutter/material.dart';
import 'package:summer_home/provider/hire_grandmaa.dart';
import 'package:summer_home/widgets/drawer.dart';
import 'package:summer_home/widgets/jobtile.dart';
import 'package:provider/provider.dart';

import 'add_job_screen.dart';

class JobScreen extends StatefulWidget {
  static const routname = "/jobscreen";
  final String mail;
  JobScreen(this.mail);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Jobs>(context).fetchAndSetData().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final nid = ModalRoute.of(context)!.settings.arguments as String?;
    final jlist = Provider.of<Jobs>(context, listen: false).jitem;
    final jdata = jlist.where((i) => i.nid == nid).toList();
    return Theme(
        data: ThemeData(
          primaryColor: Colors.blue, // set the primary color to blue
        ),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        title: Text(
          "Hire a Grandma",
          style: TextStyle(fontSize: 22),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddJob(),
                  ),
                );
              }),
        ]

      ),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: jdata.length,
        itemBuilder: (ctx, i) => JobTile(
          jdata[i].jid??'',
        ),
      ),
    )
    );
  }
}
