import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapp/src/model/category_model.dart';
import 'package:newapp/src/model/newmodel.dart';

import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '0706e123190b430e9ce30254959463ee';

class NewService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewService() {
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  get selectedCategory => this._selectCategory;

  set selectedCategory(String valor) {
    this._selectCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticuleCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final newResponse = newResponseFromJson(resp.body);

    this.headlines.addAll(newResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newResponse = newResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newResponse.articles);

    notifyListeners();
  }
}
