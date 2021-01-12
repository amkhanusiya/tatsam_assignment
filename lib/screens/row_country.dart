import 'package:flutter/material.dart';
import 'package:tatsam_assignment/viewmodels/country_view_model.dart';

class CountryItem extends StatelessWidget {
  final CountryViewModel country;
  CountryItem({this.country});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return ListTile(
      title: Text(
        country.name,
        maxLines: 2,
        style: _theme.textTheme.headline6.copyWith(
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        country.region,
      ),
      leading: Container(
        width: 50,
        height: double.infinity,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          country.code,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {},
        color: country.isFavorite ? Colors.orangeAccent : Colors.grey,
      ),
    );
  }
}
