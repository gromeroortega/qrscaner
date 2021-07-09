import 'package:flutter/cupertino.dart';
import 'package:qrscanner/Models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    await canLaunch(scan.data)
        ? await launch(scan.data)
        : throw 'Could not launch $scan.data';
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
