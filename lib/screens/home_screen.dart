import 'package:bitcpoin/helpers/api.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
 String dropdownValue = 'Ascending';

class _HomeScreenState extends State<HomeScreen> {
  List data;
  List<String> _sort = ['Ascending', 'Descending'];
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    var data = await ApiHelper().getUsers();
    print(data.runtimeType);
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Crypto Currency"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.grey[900],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: code(),
            ),
            Expanded(
              child: buildListView(),
            ),
          ],
        ));
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              color: Colors.grey[600].withOpacity(0.5),
              child: ListTile(
                  leading: Text(
                    data[index]["name"],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "\$ " + data[index]["price_usd"],
                    style: TextStyle(color: getColor(index)),
                  )),
            ),
          );
        });
  }

  Widget code() {
    return DropdownButton<String>(
      value: dropdownValue ?? "Filter",
      icon: Icon(Icons.arrow_drop_down,
       color: Theme.of(context).brightness == Brightness.light ? Colors.white10: Colors.blue
      ),
      iconSize: 24,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      isExpanded: true,
      //hint: Text("Filter"),
      items: _sort.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color:Colors.amber),
          ),
        );
      }).toList(),
    );
  }
}

Color getColor(int selector) {
  if (selector < 1) {
    return Colors.greenAccent;
  } else {
    return Colors.redAccent;
  }
}
