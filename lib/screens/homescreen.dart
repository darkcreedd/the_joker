import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_joker/screens/account_screen.dart';
import 'package:the_joker/screens/dual_screen.dart';
import 'package:the_joker/screens/favorites_screen.dart';
import 'package:the_joker/screens/filter_screen.dart';
import 'package:the_joker/screens/no_internet_screen.dart';
import 'package:the_joker/screens/singles_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../dataclass/dataclass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  int currentPage = 0;
  List<Widget> body = [
    const SinglesScreen(),
    const DualScreen(),
    const Favorites(),
    const User()
  ];

  @override
  void initState() {
    // Listen to changes in connectivity status
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);

    // Get initial connectivity status
    _updateConnectionStatus(ConnectivityResult.none);

    Provider.of<DataClass>(context, listen: false).loadSavedJokes();

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Update the UI based on the current connectivity status
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DataClass>(context, listen: false).internetState =
        _connectionStatus;

    List<Widget> body1 = [
      const NoInternetConnection(),
      const NoInternetConnection(),
      const Favorites(),
      const User()
    ];

    return Consumer<DataClass>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text('The Joker'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterScreen(),
                      ));
                },
                icon: Icon(
                  Icons.settings_outlined,
                  size: 24.sp,
                ))
          ],
        ),
        body: (value.internetState != 'ConnectivityResult.none')
            ? body[currentPage]
            : body1[currentPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (value) {
              setState(() {
                currentPage = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.looks_one,
                    size: 24.sp,
                  ),
                  label: 'Singles'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.looks_two,
                    size: 24.sp,
                  ),
                  label: 'Duals'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 24.sp,
                  ),
                  label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24.sp,
                  ),
                  label: 'User')
            ]),
      ),
    );
  }
}
