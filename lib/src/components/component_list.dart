import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/communication.dart';
import 'package:material_3_demo/src/components/navigation.dart';
import 'component_constants.dart';
import 'containment.dart';

class FirstComponentList extends StatelessWidget {
  final bool showNavBottomBar;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showSecondList;

  const FirstComponentList({
    super.key,
    required this.showNavBottomBar,
    required this.scaffoldKey,
    required this.showSecondList,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> children = [
      const Actions(),
      colDivider,
      const Communication(),
      colDivider,
      const Containment(),
      if(!showSecondList){

      }
    ]
  }
}
