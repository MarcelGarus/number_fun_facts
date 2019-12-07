import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<String> fetchFact(int number) async {
  try {
    var response = await http.get('http://numbersapi.com/$number');
    return response.body;
  } on SocketException {
    return 'You have no internet.';
  }
}

class FavoriteBloc {
  Box _favorites = Hive.box('favorites');

  FavoriteBloc() {
    print(_favorites.keys);
  }

  Stream<Set<int>> get allFavorites async* {
    favorites() => _favorites.keys.toSet().cast<int>();
    yield favorites();
    await for (var _ in _favorites.watch()) yield favorites();
  }

  bool _isFavorite(int number) => _favorites.get(number) != null;
  Stream<bool> isFavorite(int number) async* {
    yield _isFavorite(number);
    await for (var event in _favorites.watch(key: number)) yield !event.deleted;
  }

  void toggleFavorite(int number) {
    if (_isFavorite(number)) {
      _favorites.delete(number);
    } else {
      _favorites.put(number, true);
    }
    print(_favorites.keys);
  }
}
