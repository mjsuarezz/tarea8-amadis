import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/incidence.dart';

class IncidenceProvider with ChangeNotifier {
  Box<Incidence> incidenceBox = Hive.box<Incidence>('incidences');

  List<Incidence> get incidences => incidenceBox.values.toList();

  void addIncidence(Incidence incidence) {
    incidenceBox.add(incidence);
    notifyListeners();
  }

  void deleteAllIncidences() {
    incidenceBox.clear();
    notifyListeners();
  }
}