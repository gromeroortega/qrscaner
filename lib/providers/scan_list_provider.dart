import 'package:flutter/material.dart';
import 'package:qrscanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selected = 'http';

  Future<ScanModel> newScan(String data, int active, int status) async {
    //Inserción en la base de datos.
    final newScan = new ScanModel(data: data, active: 1, status: 1);

    //Obtener el ID
    final id = await DBProvider.db.nuevoScan(newScan);
    //Asigna el ID insertado de la base de datos al modelo.
    newScan.id = id;

    //Decide si es dirección o geolocalización
    if (this.selected == newScan.type) {
      //inserta el listado de scans
      this.scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  showScans() async {
    final scans = await DBProvider.db.getAllScans();
    //Remplazar el listado anterior
    this.scans = [...scans];
    //Modificar la pantalla
    notifyListeners();
  }

  showScansForType(String type) async {
    final scans = await DBProvider.db.getScansbyType(type);

    if (scans == null) {
      notifyListeners();
      print('Los borro');
    } else {
      //Remplazar el listado anterior
      this.scans = [...scans];
      //Valida que el tipo seleccionado sea igual al tipo que se manda en la busqueda
      this.selected = type;
      //Modificar la pantalla
      notifyListeners();
    }
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    //Modificar la pantalla
    notifyListeners();
  }

  deleteScanbyId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
