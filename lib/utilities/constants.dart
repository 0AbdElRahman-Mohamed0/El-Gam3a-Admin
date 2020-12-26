import 'package:flutter/material.dart';

const kButtonTextColor = Colors.white;
const kPrimaryColor = Color(0xFF155E9F);
const kSecondaryColor = Color(0xFFF08220);
const kMoreColor = Color(0xFFeddcd2);
const kMoreeColor = Color(0xFF95743F);
//const kSecondaryColor = Color(0xFFFA685E);
const kSelectedCalenderItemColor = Color(0x61BAA8A4);

const kTitleTextStyle = TextTheme(
  title: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
  ),
);

const kLoginButtonSize = EdgeInsets.only(
  left: 132.0,
  right: 132.0,
  top: 20.0,
  bottom: 20.0,
);

const kLogoutButtonSize = EdgeInsets.only(
  left: 80.0,
  right: 80.0,
  top: 20.0,
  bottom: 20.0,
);

const kTextFieldCircularBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(18.0),
  ),
);

const kTextFieldInputStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

const kSizedBox = SizedBox(
  height: 15.0,
);

const kSizedBoxInSideMenu = SizedBox(
  height: 20.0,
  width: 200.0,
  child: Divider(
    color: Colors.white,
  ),
);

const kSizedBoxForPagesStyle = SizedBox(
//  width: 200.0,
  child: Divider(
    color: Colors.blueGrey,
  ),
);

const kWelcomeTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kWeekDaysTitleTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
