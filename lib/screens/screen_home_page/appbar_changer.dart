import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fusion_news/globals/globals.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:fusion_news/screens/screen_settings/screen_settings.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarChanger extends StatefulWidget implements PreferredSizeWidget {
  
  final NewsChannelProvider newsProvider;
  const AppBarChanger({super.key, required this.newsProvider});

  @override
  State<AppBarChanger> createState() => _AppBarChangerState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarChangerState extends State<AppBarChanger> {

  @override
  Widget build(BuildContext context) {

    //Appbar ProPakistani
    if (widget.newsProvider.currentChannel == "ProPakistani" || widget.newsProvider.currentChannel == "default") {
      return AppBar(
        centerTitle: true,
        backgroundColor: Global.colorProPakistani,
        title: Text(
          "ProPakistani",
          style: GoogleFonts.playfair(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenSetting()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      );

    //Appbar Dawn
    } else if (widget.newsProvider.currentChannel == "Dawn") {
      return AppBar(
        centerTitle: true,
        backgroundColor: Global.colorDawn,
        title: Text(
          "Dawn",
          style: GoogleFonts.playfair(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenSetting()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      );

    //Appbar Tribune
    } else if (widget.newsProvider.currentChannel == "Tribune") {
      return AppBar(
        
        iconTheme: IconThemeData(color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.white
                          : Colors.black),
        centerTitle: true,
        backgroundColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.black
                          : Colors.white,
        title: Stack(
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

        actions: [
          IconButton(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.white
                          : Colors.black,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenSetting()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      );

    //Appbar Fusion News
    } else {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Fusion News",
          style: GoogleFonts.playfair(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenSetting()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      );
    }   
  }
}