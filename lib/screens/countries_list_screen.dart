import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/screens/row_country.dart';
import 'package:tatsam_assignment/viewmodels/countries_list_view_model.dart';
import 'package:loadmore/loadmore.dart';

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
        title: Text('Country List'),
      ),
      body: Consumer<CountriesListViewModel>(
        builder: (context, value, child) {
          return Container(
            child: LoadMore(
              onLoadMore: _loadMore,
              isFinish: value.total == value.countries.length,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: value.countries.length,
                itemBuilder: (context, index) {
                  final _country = value.countries[index];
                  return CountryItem(
                    country: _country,
                  );
                },
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
    print('${_viewModel.countries.length} and ${_viewModel.total}');
    return false;
    // if (_viewModel.countries.length < _viewModel.total) {
    //   _offset += 1;
    //   _viewModel.fetchCountries(_offset);
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
