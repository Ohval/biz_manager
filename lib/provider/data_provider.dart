import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // Données d'articles factices pour la démonstration
  final List<Map<String, dynamic>> _articlesData = [
    {
      'name': 'Souris Optique Sans Fil',
      'category': 'Électronique',
      'price': 29.99,
      'stock': 50,
    },
    {
      'name': 'Clavier Mécanique RGB',
      'category': 'Électronique',
      'price': 89.99,
      'stock': 8,
    },
    {
      'name': 'T-shirt Coton Bleu',
      'category': 'Vêtements',
      'price': 19.99,
      'stock': 0,
    },
    {
      'name': 'Casque Audio X',
      'category': 'Électronique',
      'price': 120.00,
      'stock': 3,
    },
    {
      'name': 'Cahier A4 Ligné',
      'category': 'Fournitures',
      'price': 5.50,
      'stock': 12,
    },
  ];
  List<Map<String, dynamic>> get articlesData => _articlesData;
  void addArticle(Map<String, dynamic> article) {
    articlesData.add(article);
    notifyListeners();
  }
}
