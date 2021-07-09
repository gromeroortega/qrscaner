import 'package:flutter/material.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UiProvider>(context);
    final currentIdex = uiprovider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiprovider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIdex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Direcciones'),
      ],
    );
  }
}
