import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
  final List<String> _currencies = <String>['Ron', 'Dollar', 'Euro'];
  String _fromCurrency = 'Dollar';
  String _toCurrency = 'Euro';
  double _amount;
  double _sum;

  String _convertAmount() {
    if (_amount == null) {
      return _sum.toString();
    }
    if (_fromCurrency == _toCurrency) {
      return _amount.toString() + ' ' + _fromCurrency.toString();
    }

    if (_fromCurrency == 'Dollar') {
      final double ratio = _toCurrency == 'Euro' ? /*EUR*/ 0.85 : /*Lei*/ 4.12;
      _sum = _amount * ratio;
    }

    if (_fromCurrency == 'Ron') {
      final double ratio = _toCurrency == 'Euro' ? /*EUR*/ 0.21 : /*USD*/ 0.24;
      _sum = _amount * ratio;
    }

    if (_fromCurrency == 'Euro') {
      final double ratio = _toCurrency == 'Dollar' ? /*Dollar*/ 1.18 : /*LEU*/ 4.87;
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
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'amount',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    setState(() {
                      _amount = double.parse(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              color: Colors.blue,
              child: DropdownButton<String>(
                items: _currencies.map((String _item) {
                  return DropdownMenuItem<String>(
                    value: _item,
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
                          _item,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _fromCurrency = value;
                  });
                },
                value: _fromCurrency,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              color: Colors.blue,
              child: DropdownButton<String>(
                items: _currencies.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
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
                          item,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    _toCurrency = newValueSelected;
                  });
                },
                value: _toCurrency,
              ),
            ),
            const SizedBox(
              height: 32.0,
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
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
