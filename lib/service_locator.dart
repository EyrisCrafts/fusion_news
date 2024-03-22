
import 'package:fusion_news/api_manager/api_manager_propakistani.dart';
import 'package:fusion_news/providers/provider_news_channel.dart';
import 'package:fusion_news/providers/provider_news_dawn.dart';
import 'package:fusion_news/providers/provider_news_propakistani.dart';
import 'package:fusion_news/providers/provider_news_tribune.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<NewsChannelProvider>(NewsChannelProvider());
  getIt.registerSingleton<NewsProviderDawn>(NewsProviderDawn());
  getIt.registerSingleton<NewsProviderProPakistani>(NewsProviderProPakistani());
  getIt.registerSingleton<NewsProviderTribune>(NewsProviderTribune());
}