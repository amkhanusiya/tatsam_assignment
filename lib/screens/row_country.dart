import 'package:flutter/material.dart';
import 'package:tatsam_assignment/viewmodels/country_view_model.dart';

/*
  single item of country list view 
*/
class CountryItem extends StatelessWidget {
  final CountryViewModel country;
  final Function function;
  final bool isFavourited;
  CountryItem({
    this.country,
    this.function,
    this.isFavourited = false,
  });
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
      trailing: !isFavourited
          ? IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                if (function != null) {
                  function(country);
                }
              },
              color: country.isFavorite ? Colors.orangeAccent : Colors.grey,
            )
          : SizedBox(),
    );
  }
}
