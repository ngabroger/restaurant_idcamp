import 'package:find_restaurant/controllers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final DarkThemeProvider darkThemeProvider =
        context.read<DarkThemeProvider>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Dash(
                  length: MediaQuery.of(context).size.width * 0.9,
                  dashLength: 10,
                  dashColor: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Dark Mode",
                ),
                Spacer(),
                SwitcherButton(
                  value: darkThemeProvider.darkTheme,
                  onChange: (value) {
                    darkThemeProvider.toogleTheme();
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
