import 'package:flutter/widgets.dart';
import 'package:fusion_news/globals/globals.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:fusion_news/providers/provider_news_propakistani.dart';
import 'package:fusion_news/screens/screen_description/screen_description.dart';
import 'package:fusion_news/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'button_settings.dart';
import 'card_stories.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Category Variable to store the category name
  int categoryIndex = 0;

  double drawerWidthFactor = 0.77;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<NewsChannelProvider>(context, listen: false).activeChannel(context).getNews();
  }
  

  @override
  Widget build(BuildContext context) {
    var currentChannel = Provider.of<NewsChannelProvider>(context).currentChannel;

    var newsProvider = Provider.of<NewsChannelProvider>(context).activeChannel(context);
    
    List<String> categories;

    if (currentChannel == "propakistani") {
      categories = categoriesProPakistani;
    } else if (currentChannel == "Dawn") {
      categories = categoriesDawn;
    } else if (currentChannel == "Tribune") {
      categories = categoriesTribune;
    } else if (currentChannel == "default"){
      categories = categoriesProPakistani;
    } else {
      throw Exception('Unknown channel: $currentChannel');
    }

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.start,

      //EndDrawer
      endDrawer: SizedBox(
        height: MediaQuery.of(context).size.width * 1.8,
        child: Drawer(
          
          width: MediaQuery.of(context).size.width * drawerWidthFactor,
          child: MediaQuery.removePadding(
            
            context: context,
            removeTop: true,
            child: ListView.builder(
              
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: newsChannels.length,

              itemBuilder:(context, index) {
                return ListTile(
                  title: Text(
                    newsChannels[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  onTap: () {
                    print("newsChannels[index] ${newsChannels[index]}");
                    Provider.of<NewsChannelProvider>(context, listen: false).switchChannel(newsChannels[index]);
                  },
                );

                
              
              }
            ),
          ),
        ),
      ),

      //Drawer
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * drawerWidthFactor,
        //ListView to create a list of Categories
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              DrawerHeader(
                
                decoration: const BoxDecoration(
                  color: Global.kColorPrimary,
                ),
                child: Center(
                  child: Text(
                    "ProPakistani",
                    style: GoogleFonts.playfair(
                        fontSize: MediaQuery.of(context).size.width * 0.12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
                
              //Looping over the Category List to create a list of Categories
              

              for (int i = 0; i < categories.length; i++)
                ListTile(
                  title: Text(
                    categories[i],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                  onTap: (){
                    newsProvider.setCurrentCategory(i);
                    if (mounted) {
                      setState(() {
                        newsProvider.getNews();
                        Navigator.pop(context);
                        categoryIndex = i;
                        void scrollToTopInstantly(ScrollController controller) {
                          controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                        scrollToTopInstantly(_controller);
                      });
                    }
                  },
                ),
            ],
          ),
        ),
      ),

      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ProPakistani",
          style: GoogleFonts.playfair(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),

        //Settings Button
        actions: const [
          ButtonSettings(),
        ],
      ),

      body: Column(
        children: [
          //Category
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                categories[categoryIndex],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
          ),

          //Store the list of stories in a ListView
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              shrinkWrap: true,
              itemCount: newsProvider.getStories().length,

              //Gap between the cards
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),

              itemBuilder: (context, index) {
                return GestureDetector(

                    //Ontap to navigate to the description screen
                    onTap: () => {
                          (Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    ScreenDescription(index: index,),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    SlideTransition(
                                  position: animation.drive(
                                    Tween(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero)
                                        .chain(CurveTween(
                                            curve: Curves.decelerate)),
                                  ),
                                  child: child,
                                ),
                              )))
                        },

                    //Card
                    child: CardStories(index: index,));
              },
            ),
          ),
        ],
      ),
    );
  }
}
