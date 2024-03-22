import 'package:fusion_news/globals/globals.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:fusion_news/providers/provider_news_propakistani.dart';
import 'package:fusion_news/screens/screen_description/screen_description.dart';
import 'package:fusion_news/screens/screen_home_page/appbar_changer.dart';
import 'package:fusion_news/screens/screen_home_page/drawer_header_changer.dart';
import 'package:fusion_news/service_locator.dart';
import 'package:fusion_news/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_stories.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // Category Variable to store the category name
  int categoryIndex = 0;

  double drawerWidthFactor = 0.77;

  final ScrollController _controller = ScrollController();

  late TabController _tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 11, vsync: this);
    
    
    _tabController.addListener(() {
      getIt<NewsProviderProPakistani>().getNews();  
    });
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsChannelProvider>(context);

    var currentChannel = newsProvider.currentChannel;

    List<String> categories;

    if (currentChannel == "ProPakistani") {
      categories = categoriesProPakistani;
    } else if (currentChannel == "Dawn") {
      categories = categoriesDawn;
    } else if (currentChannel == "Tribune") {
      categories = categoriesTribune;
    } else if (currentChannel == "default") {
      categories = categoriesProPakistani;
    } else {
      throw Exception('Unknown channel: $currentChannel');
    }

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        
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
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(
                          height: 80,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: Global.kColorPrimary,
                            ),
                            child: Center(
                              child: Text(
                                "Channels",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        index -= 1;
                        return ListTile(
                          title: Text(
                            newsChannels[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.05),
                          ),
                          onTap: () {
                            newsProvider.activeChannel(context).getNews();
                            if (mounted) {
                              setState(() {
                                newsProvider.switchChannel(newsChannels[index]);
                                newsProvider
                                    .activeChannel(context)
                                    .setCurrentCategory(0);
                                Navigator.pop(context);
                              });
                            }
                          },
                        );
                      }
                    }),
              ),
            ),
          ),
      
          //Drawer
          drawer: SizedBox(
            height: MediaQuery.of(context).size.width * 1.8,
            child: Drawer(
              width: MediaQuery.of(context).size.width * drawerWidthFactor,
              //ListView to create a list of Categories
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    DrawerHeaderChanger(newsProvider: newsProvider),
      
                    //Looping over the Category List to create a list of Categories
                    for (int i = 0; i < categories.length; i++)
                      ListTile(
                        title: Text(
                          categories[i],
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        onTap: () {
                          newsProvider
                              .activeChannel(context)
                              .setCurrentCategory(i);
                          if (mounted) {
                            setState(() {
                              newsProvider.activeChannel(context).getNews();
                              Navigator.pop(context);
                              categoryIndex = i;
                              void scrollToTopInstantly(
                                  ScrollController controller) {
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
          ),
      
          //AppBar
          appBar: AppBarChanger(newsProvider: newsProvider),
          bottomNavigationBar: TabBar(
            tabAlignment: TabAlignment.start,
            onTap: (value) {
              newsProvider.activeChannel(context).setCurrentCategory(value);
              print("Category Index: $value");
              if (mounted) {
                setState(() {
                  newsProvider.activeChannel(context).getNews();
                  categoryIndex = value;
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
            isScrollable: true,
            tabs: [
              for (int i = 0; i < categories.length; i++)
                Tab(
                  text: categories[i],
                )
            ],
            controller: _tabController,
          ),
          body: FutureBuilder(
              future: newsProvider.activeChannel(context).getNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("selected Index: $_selectedIndex");
                  print("category Index: $categoryIndex");
                  return TabBarView(
                      controller: _tabController,
                      children: List.generate(categories.length, (index) {
                        return Column(
                          children: [
                            
                            //Category
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  categories[_selectedIndex],
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.05,
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
                                itemCount: newsProvider
                                    .activeChannel(context)
                                    .getStories()
                                    .length,
      
                                //Gap between the cards
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 5,
                                ),
      
                                itemBuilder: (context, index) {
                                  return GestureDetector(
      
                                      //Ontap to navigate to the description screen
                                      onTap: () => {
                                            (Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      ScreenDescription(
                                                    index: index,
                                                  ),
                                                  transitionsBuilder: (context,
                                                          animation,
                                                          secondaryAnimation,
                                                          child) =>
                                                      SlideTransition(
                                                    position: animation.drive(
                                                      Tween(
                                                              begin: const Offset(
                                                                  1.0, 0.0),
                                                              end: Offset.zero)
                                                          .chain(CurveTween(
                                                              curve: Curves
                                                                  .decelerate)),
                                                    ),
                                                    child: child,
                                                  ),
                                                )))
                                          },
      
                                      //Card
                                      child: CardStories(
                                        index: index,
                                      ));
                                },
                              ),
                            ),
                          ],
                        );
                      }));
                }
              })),
    );
  }
}
