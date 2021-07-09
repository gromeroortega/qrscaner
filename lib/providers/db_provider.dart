import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/Models/scan_model.dart';
export 'package:qrscanner/Models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Clase singleton para la base de datos
class DBProvider {
  //Propiedad estatica
  static Database _database;

  //Instacia de la clase personalizada con su constructor privado _.()
  static final DBProvider db = DBProvider._();

  //Constructor de mi calse singleton (constructor privado )
  DBProvider._();

  //Validación para a creación de la base de datos
  Future<Database> get database async {
    if (_database != null) {
      print('no crear base de datos');
      return _database;
    } else {
      _database = await initDB();

      print('Se debe crear la base de datos');

      return _database;
    }
  }

  //Configuración y creación de la base de datos con una tabla.
  Future<Database> initDB() async {
    //Path de almacenimiento de la base de datos
    Directory docDirectory = await getApplicationDocumentsDirectory();
    final path = join(docDirectory.path, 'scansDB.db');
    print(path);

    //Crear base de datos
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print(db);
      print(version);
      //Creación de tablas de la base de datos
      await db.execute('''
          CREATE TABLE scans (id INTEGER PRIMARY KEY, type TEXT, data TEXT, active INT, status INT);
        ''');
    });
  }

  /*.-.-.-.-.-.-.-.-.-.-.- Ejemplo RAWINSERTS.-.-.-.-.-.-.-.-.-.-.-.*/
  /*
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final type = nuevoScan.type;
    final data = nuevoScan.data;

    //verificar la base de datos
    final db = await database;

    final res = await db.rawInsert(
        '''INSERT INTO scans (id, type, valor) VALUES ($id,$type,$data)''');

    return res;
  }
  */

  //Método de inserción, retorna el id insertado en la base de datos
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    //verificar la base de datos
    final db = await database;

    final res = await db.insert('scans', nuevoScan.toJson());
    print(res);
    return res;
  }

  //Método de busqueda por ID, retorna solo un registro de la base de datos
  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db
        .query('scans', where: 'id = ? and active = 1', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //Método de consulta general, retorna un mapa con los registros
  // lo mandamos al modelo y lo convertimos en una lista, sino hay
  //datoz debe regresar una lista vacia.
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  //Método de consulta por el campo tipo, retorna un mapa con los registros,
  //lo mandamos al modelo, lo iteramos y lo convertimos en una lista, sino hay
  //datos debe regresar una lista vacia.
  Future<List<ScanModel>> getScansbyType(String type) async {
    final db = await database;
    final res = await db
        .query('scans', where: 'type = ? and active= 1', whereArgs: [type]);

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : null;
  }

  //Método para la actualización de un scan

  Future<int> updateScan(ScanModel updateScan) async {
    final db = await database;
    final res = await db.update('scans', updateScan.toJson(),
        where: 'id = ?', whereArgs: [updateScan.id]);

    return res;
  }

  //Método para borrar registros por ID

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //Método para borrar todos los registros

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('scans');
    return res;
  }
}
