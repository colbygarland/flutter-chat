import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendly_chat/helpers/platform.dart';
import 'package:friendly_chat/screens/ChatScreen.dart';

void main() {
  runApp(
    FriendlyChatApp(),
  );
}

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);
final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.indigo, accentColor: Colors.indigoAccent[400]);

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FriendlyChat',
        home: ChatScreen(),
        theme: isIOS() ? kIOSTheme : kDefaultTheme);
  }
}
