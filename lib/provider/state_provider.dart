import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  String _selectedSection = 'dashboard';
  String get selectedSection => _selectedSection;

  // Fonction pour afficher une section de contenu spécifique
  void showSection(String sectionId) {
    _selectedSection = sectionId;
    notifyListeners();
  }
}
