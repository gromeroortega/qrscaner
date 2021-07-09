import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/Models/scan_model.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/utils/utils.dart';

class GenericListView extends StatelessWidget {
  const GenericListView(
      {Key key,
      @required this.scans,
      @required this.scanList,
      @required this.icon})
      : super(key: key);

  final List<ScanModel> scans;
  final ScanListProvider scanList;
  final Icon icon;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScanbyId(scans[i].id);
        },
        background: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Icon(Icons.delete_forever),
        ),
        child: ListTile(
            leading: icon,
            title: Text(scans[i].data),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[i])),
      ),
      itemCount: scanList.scans.length,
    );
  }
}
