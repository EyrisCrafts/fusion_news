import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenSetting extends StatefulWidget {
  const ScreenSetting({super.key});

  @override
  State<ScreenSetting> createState() => _ScreenSettingState();
}

class _ScreenSettingState extends State<ScreenSetting> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // When dark mode is on, the switch will stay switched on
    AdaptiveThemeMode themeMode = AdaptiveTheme.of(context).mode;
    if (themeMode == AdaptiveThemeMode.light) {
      isDarkMode = false;
    } else {
      isDarkMode = true;
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(children: [
          
          //Row: Dark Mode
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        if (isDarkMode) {
                          value = isDarkMode;
                          AdaptiveTheme.of(context).setLight();
                        } else {
                          value = isDarkMode;
                          AdaptiveTheme.of(context).setDark();
                        }
                      });
                    }),
              ],
            ),
          ),
          
          const Divider(height: 10,),
          //Row: Contact us
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(text: "hello@propakistani.pk"))
                            .then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          width: MediaQuery.of(context).size.width * 0.8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15),
                          content: const Text(
                            "The link has been successfully copied to your clipboard."
                          )
                      ))
                    );
                  },
                  child: const Text(
                    "hello@propakistani.pk",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),

          const Divider(
            height: 10,
          ),

          //Row: Website
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Website",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(
                              text: "https://propakistani.pk/"))
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                          width: MediaQuery.of(context).size.width * 0.8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "The link has been successfully copied to your clipboard."))));
                    },
                    child: const Text(
                      "https://propakistani.pk/",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
