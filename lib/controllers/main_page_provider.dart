import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:youtube_clone/model/youtube_model.dart';

class MainPageProvider extends ChangeNotifier {
  //API Key = AIzaSyDs_BuQGXIPd9DInHL-DepwyCKFfr4IqYo
  static const url =
      "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=5&regionCode=US&key=AIzaSyDs_BuQGXIPd9DInHL-DepwyCKFfr4IqYo";
  // "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=5&regionCode=US&key=AIzaSyDs_BuQGXIPd9DInHL-DepwyCKFfr4IqYo";
  // "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=50&regionCode=US&key=AIzaSyDs_BuQGXIPd9DInHL-DepwyCKFfr4IqYo";

  bool isLoading = true;
  String error = "";
  var data;
  YouTubeModel youTubeModel = YouTubeModel();
  getMainPageData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        data = jsonDecode(response.body);
        // youTubeModel = YouTubeModel.fromJson(data);
        youTubeModel = YouTubeModel.fromJson(data);
        log(data.toString());
      }
    } catch (e) {
      error = e.toString();
      log("This is error ${error}");
    }
    isLoading = false;
    notifyListeners();
  }
}
