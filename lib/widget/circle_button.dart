import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/setting_provider.dart';

class CircleButton extends StatelessWidget {
  final Icon iconImage;
  final Function() onTap;

  const CircleButton({
    required this.iconImage,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SettingProvider darkTheme = Provider.of<SettingProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
          child: IconButton(
            onPressed: onTap,
            iconSize: 24,
            icon: iconImage,
            color: darkTheme.darkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
