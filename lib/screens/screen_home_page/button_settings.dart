import 'package:flutter/material.dart';

import '../screen_settings/screen_settings.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ScreenSetting(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: animation.drive(Tween(
                      begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.decelerate))),
              child: child,
            ),
          )
        );
      },
      icon: const Icon(Icons.settings)
    );
  }
}
