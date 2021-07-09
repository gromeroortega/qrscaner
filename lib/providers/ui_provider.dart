import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  //Creación de Getter
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  //creación del setter, NO ES UN MÉTODO
  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    //Cuando se cambien el varlor de _selectedMenuOpt el notify
    //avisará a los widgets el cambio
    notifyListeners();
  }
}
