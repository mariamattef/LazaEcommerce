import 'package:flutter/material.dart';
import 'package:laza_ecommerce/core/app_theme.dart';
import 'package:laza_ecommerce/core/utiles/color_utiles.dart';
import 'package:laza_ecommerce/features/home/presentation/views/home_screen.dart';
import 'package:laza_ecommerce/features/home/presentation/widgets/custom_drawer.dart';

const List<Widget> _widgetOptions = <Widget>[
  HomeScreen(),
  Center(child: Text('Wishlist Screen')),
  Center(child: Text('Cart Screen')),
  Center(child: Text('Wallet Screen')),
];

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 32),
            activeIcon: SizedBox.shrink(),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 32),
            activeIcon: SizedBox.shrink(),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 32),
            activeIcon: SizedBox.shrink(),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined, size: 32),
            activeIcon: SizedBox.shrink(),
            label: 'Wallet',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: ColorUtility.colorGray,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),

        // unselectedLabelStyle: const TextStyle(
        //   fontWeight: FontWeight.w500,
        //   fontSize: 11,
        // ),
        showUnselectedLabels: false,
      ),
    );
  }
}
