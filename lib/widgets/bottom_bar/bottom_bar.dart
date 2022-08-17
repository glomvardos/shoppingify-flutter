import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingify/screens/add_new_item_screen.dart';
import 'package:shoppingify/screens/categories/categories_screen.dart';
import 'package:shoppingify/screens/history/history_screen.dart';
import 'package:shoppingify/screens/shopping_list/shopping_list_screen.dart';
import 'package:shoppingify/screens/statistics_screen.dart';
import 'package:shoppingify/screens/drawer/widgets/drawer_menu.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _screens = [
    const CategoriesScreen(),
    const HistoryScreen(),
    const StatisticsScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/images/logo.svg',
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 1,
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewItemScreen.routeName);
            },
          ),
          IconButton(
            splashRadius: 1,
            icon: const Icon(Icons.menu),
            onPressed: () {
              setState(() {
                _scaffoldKey.currentState!.openEndDrawer();
              });
            },
          ),
        ],
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Shoppingify',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        onTap: (index) => _selectPage(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            label: 'Statistics',
          ),
        ],
      ),
      body: _screens[_selectedPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ShoppingListScreen.routeName);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
