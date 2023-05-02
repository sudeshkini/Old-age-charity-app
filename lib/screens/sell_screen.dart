import 'package:flutter/material.dart';
import 'package:summer_home/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../provider/sells.dart';
import '../widgets/ProductTile.dart';
import 'add_product_screen.dart';

class SellScreen extends StatefulWidget {
  static const routname = "/sellscreen";
  final String mail;
  SellScreen(this.mail);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Sells>(context).fetchAndSetData().then((_) {
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
    final slist = Provider.of<Sells>(context, listen: false).sitem;
    final sdata = slist.where((i) => i.nid == nid).toList();
    return Theme(
        data: ThemeData(
          primaryColor: Colors.blue, // set the primary color to blue
        ),
    child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
          title: Text(
            "Products",
            style: TextStyle(fontSize: 22),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddProduct(),
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
        itemCount: sdata.length,
        itemBuilder: (ctx, i) => ProductTile(
          sdata[i].sid??'',
        ),
      ),
    )
    );
  }
}
