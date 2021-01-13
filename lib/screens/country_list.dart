import 'package:flutter/material.dart';
import 'package:tatsam_assignment/screens/row_country.dart';
import 'package:tatsam_assignment/viewmodels/countries_list_view_model.dart';
import 'package:tatsam_assignment/viewmodels/country_view_model.dart';

class CountryList extends StatelessWidget {
  final List<CountryViewModel> list;
  final CountriesListViewModel viewModel;

  CountryList({this.list, this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final _country = list[index];
        return CountryItem(
          country: _country,
          function: addOrRemoveFromFavourite,
        );
      },
    );
  }

  void addOrRemoveFromFavourite(CountryViewModel _country) {
    viewModel.addOrRemoveFavourite(_country);
  }
}
