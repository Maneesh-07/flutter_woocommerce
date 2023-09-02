import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/views/dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _widgetList = [
    const DashBoardPage(),
    const DashBoardPage(),
    const DashBoardPage(),
    const DashBoardPage(),
  ];

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: _buildAppBar()),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.card_travel,
              ),
              label: 'My Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'My Account'),
        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: false,
      title: const Text("Grocery App"),
      actions: const [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
