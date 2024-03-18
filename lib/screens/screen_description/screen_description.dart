import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:fusion_news/providers/provider_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'back_button_fab.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key, required this.index});
  
  final int index;

  @override
  State<ScreenDescription> createState() => _ScreenDescriptionState();
}

class _ScreenDescriptionState extends State<ScreenDescription> {

  final ScrollController _scrollController = ScrollController();
  double contentFontSize = 16.0;
  bool isDrawerOpen = false;
  bool isDialVisible = true;
  late Future newsFuture;

  @override
  void initState() {
    super.initState();
    
    newsFuture = Provider.of<NewsChannelProvider>(context, listen: false).activeChannel(context).getNews();
    context.read<SharedPreferencesProvider>()
      .getFontSize()
      .then((value) => setState(() {
        contentFontSize = value;
      }));
    _scrollController.addListener(() {
      setState(() {
        isDialVisible = _scrollController.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsChannelProvider>(context).activeChannel(context);
    int index = widget.index;
    

    return Scaffold(
      floatingActionButton:
        BackdropFilter(
          filter:  isDrawerOpen ? ImageFilter.blur(sigmaX: 5, sigmaY: 5) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            
            BackButtonFab(isDrawerOpen: isDrawerOpen, isDialVisible: isDialVisible ),
          
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
                shape: BoxShape.circle,
              ),
            
            //Menu Fab
            child: Builder(
              builder: (context) {
                return SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    visible: isDialVisible ,
                    onOpen: () {
                      setState(() {
                        isDrawerOpen = true;
                      });
                    },
                
                    onClose: () {
                      setState(() {
                        isDrawerOpen = false;
                      });
                    },
                    
                    animatedIconTheme:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                        ? const IconThemeData(size: 22.0, color: Colors.white)
                        : const IconThemeData(size: 22.0, color: Colors.black),
                        
                    animationDuration: const Duration(milliseconds: 200),
                    backgroundColor:
                        (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                            ? Colors.black
                            : Colors.white,
                    spacing: 10,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.1,
                    children: [
                
                      //Copy article fab
                      SpeedDialChild(
                        
                        shape: const CircleBorder(),
                        backgroundColor:
                            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
                                ? Colors.white
                                : Colors.black,
                        child: Icon(
                          FontAwesomeIcons.copy,
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                
                                title: const Text("Copy Article"),
                                
                                content: SelectableText(
                                  newsProvider.getStoryContent(widget.index),
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  textAlign: TextAlign.justify,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: newsProvider.getStoryContent(widget.index)));
                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Article copied to clipboard"),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                        
                                      },
                                      child: const Text("Copy All")),
                                ],
                              );
                            }
                          );
                        },
                      ),
                      
                      //Share fab
                      SpeedDialChild(
                        
                          child: Icon(Icons.share, color: 
                          AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          ),
                          onTap: () async {
                            Share.shareUri(Uri.parse(newsProvider.getStoryArticleLink(index)));
                          },
                          shape: const CircleBorder(),
                          backgroundColor:
                            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
                                ? Colors.white
                                : Colors.black),
                
                      //Font size decrement fab
                      SpeedDialChild(
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            if (contentFontSize > 12.0 && contentFontSize <= 33.0) {
                              contentFontSize = contentFontSize - 1;
                            }
                            context.read<SharedPreferencesProvider>().setFontSize(contentFontSize);
                          });
                        },
                        shape: const CircleBorder(),
                        backgroundColor:
                            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
                                ? Colors.white
                                : Colors.black,
                      ),
                
                      //Font size increment fab
                      SpeedDialChild(
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            if (contentFontSize >= 12.0 && contentFontSize < 33.0) {
                              contentFontSize = contentFontSize + 1;
                            }
                            context.read<SharedPreferencesProvider>().setFontSize(contentFontSize);
                          });
                        },
                        shape: const CircleBorder(),
                        backgroundColor:
                            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
                                ? Colors.white
                                : Colors.black,
                      ),
                
                      
                    ]);
              }
            ),
          ),
                ]),
        ),

      

      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          
          slivers: [
            //To hide the appbar when scrolling
            const SliverAppBar(
              floating: true,
              snap: true,
            ),
            
            SliverToBoxAdapter(
              child: Column(
              children: [
                      
                //ImageStory
                FutureBuilder(
                  future: newsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return    
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              newsProvider.getStoryImageURL(index),
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )),
                      ),
                      Positioned(
                        bottom: 50,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(newsProvider.getStoryTitle(index),
                              textAlign: TextAlign.justify,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          right: 0,
                          child: Text(newsProvider.getStoryDate(index),
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal))),
                      
                    ],
                  );
  }}),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                //Content
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    newsProvider.getStoryContent(index),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: contentFontSize, height: 1.4),
                  ),
                )
              ],
                      ),
            ),
        ]),
      ),
    );
  }
}
