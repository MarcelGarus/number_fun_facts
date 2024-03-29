import 'package:flutter/material.dart';

import 'favorite_button.dart';
import 'utils.dart';

class NumberDetailsScreen extends StatefulWidget {
  final int number;

  const NumberDetailsScreen({Key key, @required this.number})
      : assert(number != null),
        super(key: key);

  @override
  _NumberDetailsScreenState createState() => _NumberDetailsScreenState();
}

class _NumberDetailsScreenState extends State<NumberDetailsScreen> {
  String fact = '';
  bool get isLoading => fact == null;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    if (isLoading) return;

    setState(() => fact = null);
    var theFact = await fetchFact(widget.number);
    setState(() => fact = theFact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for'),
        elevation: 0,
        actions: <Widget>[
          FavoriteButton(number: widget.number, color: Colors.white)
        ],
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
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    fact,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 24),
                  ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
