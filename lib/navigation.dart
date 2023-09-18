import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationState();
}

class _NavigationState extends State<NavigationPage> {
  @override
  void initState() {
    Modular.to.navigate('/homepage');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Second',
          ),
        ],
        currentIndex: Modular.to.path == '/homepage'
            ? 0
            : 1, // Set the current index based on the route
        onTap: (index) {
          print("index: $index");
          setState(() {
            if (index == 0) {
              Modular.to.navigate('/homepage');
            } else if (index == 1) {
              Modular.to.navigate('/setting');
            }
          });

          // Add more logic for other tabs
        },
      ),
      body: RouterOutlet(),
    );
  }
}
