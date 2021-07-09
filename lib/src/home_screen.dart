import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/src/addresses_screen.dart';
import 'package:qrscanner/src/maps_screen.dart';
import 'package:qrscanner/widgets/custom_navigator_bar.dart';
import 'package:qrscanner/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Historial'),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteAll(context);
                })
          ],
        ),
        body: _CurrenHome(),
        bottomNavigationBar: CustomNavigatorBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  deleteAll(context) {
    final scanList = Provider.of<ScanListProvider>(context, listen: false);
    scanList.deleteAllScans();
  }
}

class _CurrenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Al tener el prrovider en el main ya podemos usarlo por medio del Context
    //Obtener el _selectedMenuOpt
    //Es necesario especificar el tipo de dato <UiProvider>
    final uiprovider = Provider.of<UiProvider>(context);

    //La variable currentIndex cambia para mostrar el screen seleccionado
    final currenIndex = uiprovider.selectedMenuOpt;
    //Para poder acceder al scanList
    final scanList = Provider.of<ScanListProvider>(context, listen: false);
    //DBProvider.db.database;
    //final tempScan = new ScanModel(data: 'http://www.otracosa.com');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(5).then((scan) => print(scan.data));
    //DBProvider.db.getAllScans().then((scan) => print);

    switch (currenIndex) {
      case 0:
        scanList.showScansForType('geo');
        return MapsScreen();
      case 1:
        scanList.showScansForType('http');
        return AddressesScreen();

      default:
        MapsScreen();
    }
  }
}
