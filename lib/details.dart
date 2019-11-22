import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NumberDetailsScreen extends StatefulWidget {
  final int number;

  const NumberDetailsScreen({Key key, this.number}) : super(key: key);

  @override
  _NumberDetailsScreenState createState() => _NumberDetailsScreenState();
}

class _NumberDetailsScreenState extends State<NumberDetailsScreen> {
  String fact = '';

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    if (fact == null) {
      return;
    }
    setState(() => fact = null);
    try {
      //var response = await http.get('http://numbersapi.com/${widget.number}');
      //setState(() => fact = response.body);

      // Don't use this below, but rather that above.
      await Future.delayed(Duration(seconds: 1));
      throw SocketException('No internet.');
    } on SocketException {
      setState(() => fact = 'You have no internet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: Column(
        children: <Widget>[
          Material(
            color: Theme.of(context).primaryColor,
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                '${widget.number}',
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: (fact == null)
                ? CircularProgressIndicator()
                : Text(
                    fact,
                  ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
