
import 'package:flutter/material.dart';

import '../../models/model_story.dart';

class ImageStory extends StatefulWidget {

  final ModelStory stories;
  const ImageStory({super.key, required this.stories});

  @override
  State<ImageStory> createState() => ImageStoryState();
}

class ImageStoryState extends State<ImageStory> {
  @override
  Widget build(BuildContext context) {
    return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.stories.imageURL.toString(),
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
                    child: Text(widget.stories.title,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 0,
                    child: Text(widget.stories.date,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal))),
                
              ],
            );
  }
}