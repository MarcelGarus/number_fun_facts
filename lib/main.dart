import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:number_fun_fact/details.dart';
import 'package:number_fun_fact/favorite_button.dart';
import 'package:number_fun_fact/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Hive.openBox('favorites');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FavoriteBloc>.value(
      value: FavoriteBloc(),
      child: MaterialApp(
        title: 'Number Fun Facts',
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            title: TextStyle(fontSize: 128, color: Colors.white),
          ),
        ),
        home: NumberListScreen(),
      ),
    );
  }
}

class NumberListScreen extends StatefulWidget {
  @override
  _NumberListScreenState createState() => _NumberListScreenState();
}

class _NumberListScreenState extends State<NumberListScreen> {
  bool filtered = false;

  void toggleFilter() {
    setState(() {
      filtered = !filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Fun Facts')),
      body: buildList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: toggleFilter,
        icon: Icon(Icons.filter_list),
        label: Text('Filter'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildList() {
    if (!filtered) {
      return ListView.builder(
        itemBuilder: (context, index) => NumberTile(number: index),
      );
    } else {
      return StreamBuilder<Set<int>>(
          stream: Provider.of<FavoriteBloc>(context).allFavorites,
          initialData: {},
          builder: (context, snapshot) {
            var numbers = snapshot.data.toList()..sort();

            return ListView(
              children: <Widget>[
                for (var number in numbers)
                  NumberTile(
                    number: number,
                  ),
              ],
            );
          });
    }
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
        trailing: FavoriteButton(
          number: number,
          color: Theme.of(context).primaryColor,
        ));
  }
}
