import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.qr_code_rounded),
      onPressed: () async {
        final barcoScan = 'https://www.facebook.com/';
        final barco = 'geo:19.418862,-98.160062';

        //Esto busca dentro del arbol de widgets(contex), la instancia del ScanListProvider.
        final scanList = Provider.of<ScanListProvider>(context, listen: false);
        //scanList.newScan(barcoScan, 1, 1);
        //scanList.newScan(barco, 1, 1);
        //por si el usuario cancela
        if (barco == '-1') {
          return;
        }
        final newscan = await scanList.newScan(barco, 1, 1);
        launchURL(context, newscan);

        /*FlutterBarcodeScanner.getBarcodeStreamReceiver(
                "#1b3864", "Cancelar", false, ScanMode.DEFAULT)
            .listen((barcode) {
          /// barcode to be used
          print(barcode);
        });*/
      },
    );
  }
}
