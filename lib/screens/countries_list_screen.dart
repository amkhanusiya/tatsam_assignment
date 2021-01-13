import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
  bool isConnectedToInternet = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _viewModel = Provider.of<CountriesListViewModel>(context, listen: false);
    _viewModel.fetchCountries(_offset);
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
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
          return isConnectedToInternet
              ? Container(
                  child: LoadMore(
                    onLoadMore: _loadMore,
                    isFinish: value.countries.length >= value.total,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: value.countries.length,
                      itemBuilder: (context, index) {
                        final _country = value.countries[index];
                        return CountryItem(
                          country: _country,
                          function: addOrRemoveFromFavourite,
                        );
                      },
                    ),
                    whenEmptyLoad: false,
                    delegate: DefaultLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                  ),
                )
              : Center(
                  child: Text('Please check your network connectivity'),
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

  void addOrRemoveFromFavourite(CountryViewModel _country) {
    _viewModel.addOrRemoveFavourite(_country);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => isConnectedToInternet = true);
        if (_viewModel.countries.isEmpty) {
          _viewModel.fetchCountries(_offset);
        }
        break;
      case ConnectivityResult.none:
        setState(() => isConnectedToInternet = false);
        break;
      default:
        setState(() => isConnectedToInternet = false);
        break;
    }
  }
}
