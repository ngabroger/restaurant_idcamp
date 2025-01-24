import 'package:find_restaurant/controllers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting User',
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
                Consumer<SettingProvider>(
                  builder: (context, darkThemeProvider, child) {
                    return Switch(
                      value: darkThemeProvider.darkTheme,
                      onChanged: (value) {
                        darkThemeProvider.toogleTheme(value);
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Notification ",
                ),
                Spacer(),
                Consumer<SettingProvider>(
                  builder: (context, notification, child) {
                    return Switch(
                      value: notification.notification,
                      onChanged: (value) {
                        notification.toggleNotification(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
