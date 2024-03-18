import 'package:fusion_news/api_manager/api_manager_tribune.dart';
import 'package:fusion_news/models/model_story.dart';
import 'package:fusion_news/utils/utils.dart';
import 'package:flutter/material.dart';

class NewsProviderTribune with ChangeNotifier {
  List<ModelStory> _stories = [];
  String _category = "home";
  
  List<ModelStory> get stories => _stories;
  String get category => _category;
  

  getNews() async {
    _stories = (await TribuneApiService().getNewsTribune(_category.toLowerCase()));
    notifyListeners() ;
  }

  setCurrentCategory(int index) async {
    _category = categoriesTribune[index];
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