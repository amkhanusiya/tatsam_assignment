import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/screens/row_country.dart';
import 'package:tatsam_assignment/viewmodels/countries_list_view_model.dart';
import 'package:tatsam_assignment/viewmodels/country_view_model.dart';

class FavouriteCoutryListScreen extends StatefulWidget {
  static const ROUTE_NAME = '/favourite';

  @override
  _FavouriteCoutryListScreenState createState() =>
      _FavouriteCoutryListScreenState();
}

class _FavouriteCoutryListScreenState extends State<FavouriteCoutryListScreen> {
  CountriesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Provider.of<CountriesListViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Country List',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
      ),
      body: Consumer<CountriesListViewModel>(
        builder: (context, value, child) {
          return Container(
            child: value.favouritedCountries.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: value.favouritedCountries.length,
                    itemBuilder: (context, index) {
                      final _country = value.favouritedCountries[index];
                      return CountryItem(
                        country: _country,
                        function: addOrRemoveFromFavourite,
                      );
                    },
                  )
                : Center(
                    child: Text('No data found'),
                  ),
          );
        },
      ),
    );
  }

  void addOrRemoveFromFavourite(CountryViewModel _country) {
    _viewModel.addOrRemoveFavourite(_country);
  }
}
