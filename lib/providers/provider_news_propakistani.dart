import 'package:fusion_news/models/model_story.dart';
import 'package:fusion_news/utils/utils.dart';
import 'package:flutter/material.dart';
import '../api_manager/api_manager_propakistani.dart';

class NewsProviderProPakistani with ChangeNotifier {
  List<ModelStory> _stories = [];
  String _category = "";
  
  List<ModelStory> get stories => _stories;
  String get category => _category;
  

  getNews() async {
    _stories = (await ProPakistaniApiService().getNewsProPakistani(_category));
    print("ProPakistani category: ${_category}");
    notifyListeners();
  }

  setCurrentCategory(int index) {
    _category = linkCategoriesProPakistani[index];
    notifyListeners();
  }

  getStories(){
    return _stories;
  }

  getStoryTitle(int index) {
    return _stories[index].title;
  }

  getStoryArticleLink(int index) {
    return _stories[index].articleLink;
  }

  getStoryDate(int index) {
    return _stories[index].date;
  } 

  getStoryContent(int index) {
    return _stories[index].content;
  } 

  getStoryImageURL(int index) {
    return _stories[index].imageURL.toString();
  }

  getStoryDescription(int index) {
    return _stories[index].description;
  }
}