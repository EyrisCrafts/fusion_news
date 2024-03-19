// ignore: file_names
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fusion_news/globals/globals.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerHeaderChanger extends StatelessWidget {
  final NewsChannelProvider newsProvider;
  const DrawerHeaderChanger({super.key, required this.newsProvider});

  @override
  Widget build(BuildContext context) {

    //DrawerHeader ProPakistani
    if (newsProvider.currentChannel == "ProPakistani" || newsProvider.currentChannel == "default") {
      return const DrawerHeader(        
        decoration: BoxDecoration(
          color: Global.colorProPakistani,
        ),
        child: Center(
          child: Text(
            "ProPakistani",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );

    //DrawerHeader Tribune
    } else if (newsProvider.currentChannel == "Tribune") {
      return SizedBox(
        height: 100,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.black
                          : Colors.white,
          ),
        
          child: Center(
            child: Stack(
              children: [
            
                //Position and size of "TRIBUNE"
                Positioned(
                  child: Text(
                    "TRIBUNE",
                    style: GoogleFonts.playfair(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.normal,
                      color:
                          AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
            
                //Position and size of "THE EXPRESS"
                Positioned(
                  top: 1,
                  right: 5,
                  child: Text(
                    "THE EXPRESS",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.025,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                        color: Colors.redAccent.shade700),
                  ),
                )
              ],
            ),
          ),
        ),
      );

    //DrawerHeader Dawn
    } else if (newsProvider.currentChannel == "Dawn") {
      return const DrawerHeader(
        decoration: BoxDecoration(
          color: Global.colorDawn,
        ),
        child: Center(
          child: Text(
            "Dawn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );

    //DrawerHeader Fusion News
    } else {
      return const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: Text("Fusion News",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      );
    }
  }
}