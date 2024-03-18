
//https://www.dawn.com/feeds/
import 'package:fusion_news/models/model_story.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';


abstract class IApiManager{
  Future<List<ModelStory>> getNewsDawn(String categoriesDawn);
}

class DawnApiManager implements IApiManager{
  
  final String baseURL = "https://www.dawn.com/feeds/";

  @override
  Future<List<ModelStory>> getNewsDawn(String categoriesDawn) async {
    final List<ModelStory> toReturn = [];
    try {
      var response = await Dio().get("$baseURL$categoriesDawn");
      
      final document = XmlDocument.parse(response.toString());
      final numberOfStories = document.findAllElements('title').length -1;
      
      for(int i = 1 ; i < numberOfStories ;i++){
      
        final title = document.findAllElements('title').elementAt(i).innerText;
        var content = document.findAllElements('description').elementAt(i).innerText;
        var date = document.findAllElements('pubDate').elementAt(i).innerText;
        var imgURL = document.findAllElements('item').elementAt(i-1).findAllElements('media:thumbnail').toString();
        final articleLink = document.findAllElements('link').elementAt(i).innerText;
        
        imgURL = imgURL.toString().split('?').first;
        imgURL = imgURL.split('="').last;
        imgURL = imgURL.split('"/').first;
        
        //For Default Image
        if (imgURL == '()'){
          imgURL = "http://www.dawn.com/_img/social-default.jpg";
        }

        date = date.substring(0, 16);
        
        content = content.toString().replaceAll('''{try{this.style.height=this.contentWindow.document.body.scrollHeight+'px';}catch{}}, 100)"''', "");
        content = content.toString().replaceAll('width="100%" frameborder="0" scrolling="no"', "");
        content = content.toString().replaceAll('style="height:400px;position:relative"', "");
        content = content.toString().replaceAll('sandbox="allow-same-origin allow-scripts allow-popups allow-modals allow-forms">', "");
        content = content.toString().replaceAll('</p>', "\n");
        content = content.toString().replaceAll(RegExp(r'''<[^>]*>|</.*>[^]'''), "");
        content = content.toString().replaceAll('<p>', "");
        content = content.toString().replaceAll('</p>', "\n\n");
        content = content.replaceAll(RegExp(r'/\n/g'), '\n\n\n');
        
        toReturn.add(
          ModelStory(
            title: title,
            description: "",
            imageURL: imgURL, 
            date: date, 
            content: content, 
            articleLink: articleLink, 
            
          )
        ); 
      }
    } catch (e) {
    
      print(e);
    
    }
    return toReturn;
  }

}