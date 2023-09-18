import 'package:easy_localization/easy_localization.dart';
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'app.homepage'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'app.setting'.tr(),
          ),
        ],
        currentIndex: Modular.to.path == '/homepage' ? 0 : 1,
        onTap: (index) {
          setState(() {
            if (index == 0) {
              Modular.to.navigate('/homepage');
            } else if (index == 1) {
              Modular.to.navigate('/setting');
            }
          });
        },
      ),
      body: const RouterOutlet(),
    );
  }
}
