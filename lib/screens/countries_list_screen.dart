import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/screens/country_list.dart';
import 'package:tatsam_assignment/screens/favourite_countries_list_screen.dart';
import 'package:tatsam_assignment/screens/row_country.dart';
import 'package:tatsam_assignment/viewmodels/countries_list_view_model.dart';
import 'package:loadmore/loadmore.dart';
import 'package:tatsam_assignment/viewmodels/country_view_model.dart';

class CountriesListScreen extends StatefulWidget {
  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  int _offset = 0;
  CountriesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Provider.of<CountriesListViewModel>(context, listen: false);

    _viewModel.fetchCountries(_offset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Country List',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(FavouriteCoutryListScreen.ROUTE_NAME);
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Consumer<CountriesListViewModel>(
        builder: (context, value, child) {
          return Container(
            child: LoadMore(
              onLoadMore: _loadMore,
              isFinish: value.countries.length >= value.total,
              child: CountryList(
                list: value.countries,
                viewModel: _viewModel,
              ),
              whenEmptyLoad: false,
              delegate: DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
            ),
          );
        },
      ),
    );
  }

  Future<bool> _loadMore() async {
    if (_viewModel.countries.length <= _viewModel.total) {
      _offset += 1;
      await _viewModel.fetchCountries(_offset);
    }
    return _viewModel.countries.length <= _viewModel.total;
  }
}
