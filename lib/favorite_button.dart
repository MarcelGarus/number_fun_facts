import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils.dart';

class FavoriteButton extends StatelessWidget {
  final int number;
  final Color color;

  const FavoriteButton({Key key, this.number, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favBloc = Provider.of<FavoriteBloc>(context);
    return IconButton(
        onPressed: () => favBloc.toggleFavorite(number),
        icon: StreamBuilder<bool>(
            stream: favBloc.isFavorite(number),
            initialData: false,
            builder: (context, snapshot) {
              return Icon(
                snapshot.data ? Icons.favorite : Icons.favorite_border,
                color: color,
              );
            }));
  }
}
