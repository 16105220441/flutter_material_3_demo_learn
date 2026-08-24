// App 从原来的 main.dart 移到这里（对照参考项目 lib/src/app.dart 手打补全）
import 'package:flutter/material.dart';
import 'package:material_3_demo/src/constants.dart';
import 'package:material_3_demo/src/screens/home.dart';

class App extends StatefulWidget {

  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App>{

  bool _useMaterial3 = true;
  ThemeMode _themeMode = ThemeMode.system;
  ColorSeed _colorSelected = ColorSeed.baseColor;
  ColorImageProvider _imageSelected = ColorImageProvider.leaves;
  ColorScheme? _imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod _colorSelectionMethod  = ColorSelectionMethod.colorSeed;

  bool get _useLightMode{
   return switch(_themeMode){

     // TODO: Handle this case.
     ThemeMode.system => View.of(context).platformDispatcher.platformBrightness == Brightness.light,
     // TODO: Handle this case.
     ThemeMode.light => true,
     // TODO: Handle this case.
     ThemeMode.dark => false,
    };
  }

  void _handleBrightnessChange(bool useLightMode) {
    setState(() {
      _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _handleMaterialVersionChange(){
    setState(() {
      _useMaterial3 = !_useMaterial3;
    });
  }

  void _handleColorSelect(int value){
    setState(() {
      _colorSelectionMethod = ColorSelectionMethod.colorSeed;
      _colorSelected = ColorSeed.values[value];
    });
  }

  void _handleImageSelect(int value){
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url)).then((newScheme){
      setState(() {
        _colorSelectionMethod  = ColorSelectionMethod.image;
        _imageSelected = ColorImageProvider.values[value];
        _imageColorScheme = newScheme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material 3',
      themeMode: _themeMode,
      theme: ThemeData(
        colorSchemeSeed: _colorSelectionMethod == ColorSelectionMethod.colorSeed ? _colorSelected.color : null,
        useMaterial3: _useMaterial3,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: _colorSelectionMethod == ColorSelectionMethod.colorSeed ? _colorSelected.color : _imageColorScheme!.primary,
        useMaterial3: _useMaterial3,
        brightness: Brightness.dark,
      ),
      home: Home(
        useLightMode: _useLightMode,
        useMaterial3: _useMaterial3,
        colorSelected: _colorSelected,
        imageSelected:  _imageSelected,
        handleBrightnessChange: _handleBrightnessChange,
        handleMaterialVersionChange: _handleMaterialVersionChange,
        handleColorSelect: _handleColorSelect,
        colorSelectionMethod: _colorSelectionMethod, handleImageSelect: _handleImageSelect,
      ),
    );
  }
}
