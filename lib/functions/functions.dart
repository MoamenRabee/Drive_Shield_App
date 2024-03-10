import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showMessage({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 1),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? MyColors.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: const TextStyle(fontFamily: MyFonts.font),
        ),
      ),
    ),
  );
}

class MyFonts {
  static const String font = 'NotoSansArabic';
}

String formatDate(BuildContext context, DateTime _date) {
  var formatter = context.locale.languageCode == 'en' ? DateFormat.yMMMMEEEEd("en") : DateFormat.yMMMMEEEEd("ar_SA");
  String formatted = formatter.format(_date);
  return formatted;
}

String formateTime(TimeOfDay time) {
  DateTime dt = DateTime(2020, 1, 1, time.hour, time.minute);
  return DateFormat().add_jm().format(dt);
}

String formateAMorPMFromAPI(String time) {
  String hour = time.split(" ").first.split(":").first;
  String minute = time.split(" ").first.split(":").last;
  String amOrpm = time.split(" ").last;

  if (amOrpm == 'PM') {
    return '$hour:$minute م';
  } else {
    return '$hour:$minute ص';
  }
}

String formateDateFromAPI(BuildContext context, String date) {
  int day = int.parse(date.split("-").first);
  int month = int.parse(date.split("-")[1]);
  int year = int.parse(date.split("-").last);

  DateTime dt = DateTime(year, month, day);

  return formatDate(context, dt);
}

TimeOfDay timeOfDayFromAPI(String time) {
  int hour = int.parse(time.split(" ").first.split(":").first);
  int minute = int.parse(time.split(" ").first.split(":").last);
  String amOrpm = time.split(" ").last;

  if (amOrpm == 'PM') {
    return TimeOfDay(hour: hour + 12, minute: minute);
  } else {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

DateTime dateFromAPI(String date) {
  int day = int.parse(date.split("-").first);
  int month = int.parse(date.split("-")[1]);
  int year = int.parse(date.split("-").last);

  DateTime dt = DateTime(year, month, day);

  return dt;
}

bool isURl(String url) {
  return RegExp(r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)').hasMatch(url);
}
