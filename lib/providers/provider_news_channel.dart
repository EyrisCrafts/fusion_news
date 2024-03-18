import 'package:flutter/widgets.dart';
import 'package:fusion_news/providers/provider_news_dawn.dart';
import 'package:fusion_news/providers/provider_news_propakistani.dart';
import 'package:fusion_news/providers/provider_news_tribune.dart';
import 'package:fusion_news/utils/utils.dart';
import 'package:provider/provider.dart';

class NewsChannelProvider with ChangeNotifier {
  String _currentChannel = "default";
  String get currentChannel => _currentChannel;
  

  activeChannel(BuildContext context){
    print('currentChannel activeChannel: $currentChannel');
      if (currentChannel == newsChannels[0]) {
        // Do something if currentChannel is not null
        return context.read<NewsProviderProPakistani>();
        
      } else if (currentChannel == newsChannels[1]){
        // Do something if currentChannel is not null
        return context.read<NewsProviderDawn>();
      } else if (currentChannel == newsChannels[2]){
        // Do something if currentChannel is not null
        return context.read<NewsProviderTribune>();
      } else if (currentChannel == "default"){
        // Do something if currentChannel is not null
        return context.read<NewsProviderProPakistani>();
      }else {
      throw Exception('Unknown channel: $currentChannel');
      }
  }

  switchChannel(String currentChannel) {
    print('currentChannel switchChannel: $currentChannel');
    _currentChannel = currentChannel;
    notifyListeners();
  }

}