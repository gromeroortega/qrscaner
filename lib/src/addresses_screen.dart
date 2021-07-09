import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/widgets/genericListView.dart';

class AddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //En el build el provider siempre va en true
    final scanList = Provider.of<ScanListProvider>(context);
    final scans = scanList.scans;
    return GenericListView(
      scans: scans,
      scanList: scanList,
      icon: Icon(Icons.link, color: Theme.of(context).primaryColor),
    );
  }
}
