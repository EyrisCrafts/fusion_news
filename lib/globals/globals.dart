import 'package:flutter/material.dart';

class Global{
  static const  kCardTextColor = TextStyle(color: Colors.white);

  void scrollToTopInstantly (ScrollController controller){
    controller.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
  }

  static const Color kColorPrimary = Color.fromRGBO(29, 122, 116, 1.0);

  static const Color kColorSecondary = Color.fromARGB(255, 20, 33, 37);

  

  static BoxShadow kFabShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 5,
    offset: const Offset(0, 0), // changes the position of the shadow
  );

  
  // activeChannel(BuildContext context){
  //   var currentChannel = Provider.of<NewsChannelProvider>(context, listen: false).currentChannel;

  //     if (currentChannel == newsChannels[0]) {
  //       // Do something if currentChannel is not null
  //       return context.watch<NewsProviderProPakistani>();
  //     } else if (currentChannel == newsChannels[1]){
  //       // Do something if currentChannel is not null
  //       return context.watch<NewsProviderDawn>();
  //     } else if (currentChannel == newsChannels[3]){
  //       // Do something if currentChannel is not null
  //       return context.watch<NewsProviderTribune>();
  //     } else {
  //     throw Exception('Unknown channel: $currentChannel');
  //     }
    
  // }
}
