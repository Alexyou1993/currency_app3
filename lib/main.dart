import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// todo: format the code
void main() {
  runApp(
    MyApp(), // todo: no trailing comma needed when only one argument
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application. ???
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Currency app version 0.01'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List <String> _currencies = <String>['Ron', 'Dollar', 'Euro'] ;
  // todo: shorter variable names (ex. fromCurrency)
  String _currentItemSelected = 'Dollar';
  // todo: shorter variable names (ex. toCurrency)
  String _currentItemSelected2 = 'Euro';
  double _amount;
  double _sum;

  String _convertAmount() {
    if (_amount == null) {
      return _sum.toString();
    }

    if (_currentItemSelected == 'Dollar') {
      final double ratio = _currentItemSelected2 == 'Euro' ? 0.85 : 4.12;
      _sum = _amount * ratio;
    }

    if (_currentItemSelected == 'Ron') {
      final double ratio = _currentItemSelected2 == 'Euro' ? 0.21 : 0.24;
      _sum = _amount * ratio;
    }

    if (_currentItemSelected == 'Euro') {
      final double ratio = _currentItemSelected2 == 'Dollar' ? 1.18 : 4.87;
      _sum = _amount * ratio;
    }

    return _sum.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10), // todo: always use multiple of 4 or 8 when dealing with ui measurements
                child: const Text(
                  'amount',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(
                    () {
                      _amount = double.parse(value);
                    }, // todo: no trilling comma
                  );
                },
                // todo: why empty hint
                decoration: const InputDecoration(hintText: ''),
              ),
            ],
          ),
          Container(
            color: Colors.blue,
            child: DropdownButton<String>(
              // todo: shorter variable names
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: const ListTile(
                          leading: CircleAvatar(
                            radius: 30, // todo: always use multiple of 4 or 8 when dealing with ui measurements
                          ),
                        ),
                      ),
                      Text(
                        dropDownStringItem,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
              // todo: shorter variable names
              onChanged: (String newValueSelected) {
                setState(
                  () {
                    _currentItemSelected = newValueSelected;
                  },
                );
              },
              value: _currentItemSelected,
            ),
          ),
          Container(
            color: Colors.blue,
            child: DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: const ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                      ),
                      Text(
                        dropDownStringItem,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  _currentItemSelected2 = newValueSelected;
                });
              },
              value: _currentItemSelected2,
            ),
          ),
          FlatButton(
            color: Colors.blue,
            child: Container(
              width: 100,
              child: const Text(
                'convert',
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(_convertAmount()),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('ok'),
                        onPressed: () {
                          _amount = 0.0;
                          Navigator.pop(context, null);
                        },
                      ),
                    ],
                  );
                },
              ),
          ),
        ]), // todo: trailing comma
      ),
    );
  }
}
