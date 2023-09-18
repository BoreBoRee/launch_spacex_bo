import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget topicTextWidget(text, color) {
  return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.toString(),
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.bold),
        ).tr(),
      ));
}