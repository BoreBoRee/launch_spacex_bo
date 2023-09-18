import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff333333),
        appBar: AppBar(
            backgroundColor: const Color(0xff333333),
            leading: Container(),
            title: const Text(
              "app.setting",
            ).tr()),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('app.language',
                        style: TextStyle(color: Colors.white, fontSize: 18))
                    .tr(),
                CupertinoSwitch(
                  // This bool value toggles the switch.
                  value: switchValue,
                  activeColor: Colors.orange,
                  onChanged: (bool? value) {
                    setState(() {
                      switchValue = value ?? false;
                      if (context.locale.languageCode == 'en') {
                        context.setLocale(Locale('th'));
                      } else {
                        context.setLocale(Locale('en'));
                      }
                    });
                    // This is called when the user toggles the switch.
                  },
                ),
              ])
            ],
          ),
        ));
  }
}
