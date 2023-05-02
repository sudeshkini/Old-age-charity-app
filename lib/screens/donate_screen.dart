import 'package:flutter/material.dart';
import 'package:summer_home/provider/donator.dart';
import 'package:summer_home/screens/add_donar_screen.dart';
import 'package:summer_home/widgets/donatetile.dart';
import 'package:summer_home/widgets/drawer.dart';
import 'package:provider/provider.dart';

class DonateScreen extends StatefulWidget {
  static const routname = "/donatescreen";
  final String mail;
  DonateScreen(this.mail);
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Donator>(context).fetchAndSetData().then((_) {
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
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final nid = arguments is String ? arguments : null;
    print('nid: $nid');
    final jlist = Provider.of<Donator>(context, listen: false).dlist;
    print('jlist length: ${jlist.length}');
    final jdata = jlist.where((i) => i.nid == nid).toList();
    return Theme(
        data: ThemeData(
          primaryColor: Colors.blue, // set the primary color to blue
        ),
    child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
          title: Text("Donate Now"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDonater(),
                    ),
                  );
                  /*Navigator.of(context)
                      .pushNamed("/adddonater", arguments: nid);*/
                })
          ]),
      drawer: AppDrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: jdata.length,
              itemBuilder: (ctx, i) => DonateTile(
                jdata[i].did ?? '',
              ),
            ),
    )
    );
  }
}
