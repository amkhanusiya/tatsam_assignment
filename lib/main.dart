import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/screens/countries_list_screen.dart';
import 'package:tatsam_assignment/screens/favourite_countries_list_screen.dart';
import 'package:tatsam_assignment/viewmodels/countries_list_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountriesListViewModel>(
          create: (BuildContext context) {
            return CountriesListViewModel();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (ctx) => CountriesListScreen(),
          FavouriteCoutryListScreen.ROUTE_NAME: (ctx) =>
              FavouriteCoutryListScreen(),
        },
      ),
    );
  }
}
