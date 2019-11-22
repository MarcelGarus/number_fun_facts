import 'package:flutter/material.dart';
import 'package:number_fun_fact/details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Fun Facts',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 128, color: Colors.white),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Number Fun Facts')),
        body: ListView.builder(
          itemBuilder: (context, index) => NumberTile(number: index),
        ),
      ),
    );
  }
}

class NumberTile extends StatelessWidget {
  final int number;

  const NumberTile({Key key, this.number}) : super(key: key);

  void _openDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NumberDetailsScreen(number: number),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Hallo $number'),
      subtitle: Text('hey'),
      onTap: () => _openDetailsScreen(context),
    );
  }
}
