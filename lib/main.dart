import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/src/home_screen.dart';
import 'package:qrscanner/src/map_screen.dart';
import 'package:qrscanner/src/maps_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MultiProvider se importa del paquete de provider, busca en el arbol de widgets
    // la clase Uirpovider y da acdeso a _selectedMenuOpt para saber cuando cambie
    //Ahora el provider esta en el arbol de Widgets
    return MultiProvider(
      //Requiere varios provedores de información (providers[])
      providers: [
        //
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Scanner',
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomeScreen(),
            'map': (_) => MapScreen(),
            'maps': (_) => MapsScreen()
          },
          theme: ThemeData(
            primaryColor: Color(0xff0E2859),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xff0E2859),
              elevation: 0,
            ),
            appBarTheme: AppBarTheme(elevation: 0),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 0, backgroundColor: Color(0xffCE6C37)),
          )),
    );
  }
}
