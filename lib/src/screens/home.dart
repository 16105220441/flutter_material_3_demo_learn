import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_list.dart';
import 'package:material_3_demo/src/transitions/one_two_transition.dart';

import '../constants.dart';

class Home extends StatefulWidget {


  final bool useLightMode;
  final bool useMaterial3;
  final ColorSeed colorSelected;
  final ColorImageProvider imageSelected;
  final ColorSelectionMethod colorSelectionMethod;

  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function() handleMaterialVersionChange;
  final void Function(int value) handleColorSelect;
  final void Function(int value) handleImageSelect;

  const Home({
    super.key,
    required this.useLightMode,
    required this.useMaterial3,
    required this.colorSelected,
    required this.handleBrightnessChange,
    required this.handleMaterialVersionChange,
    required this.handleColorSelect,
    required this.handleImageSelect,
    required this.colorSelectionMethod,
    required this.imageSelected,
  });

  @override
  State<Home> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargerSizeLayout = false;

  int screenIndex = ScreenSelected.component.value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,
        value: 0,
        duration: Duration(milliseconds: transitionLength.toInt() * 2));
    railAnimation =
        CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    final AnimationStatus status = controller.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargerSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargerSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargerSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > mediumWidthBreakpoint ? 1 : 0;
    }
  }

  void handleScreenChange(int screenSelected) {
    setState(() {
      screenIndex = screenSelected;
    });
  }

  Widget createScreenFor(ScreenSelected screenSelected,
      bool showNavBarExample,) =>
      switch(screenSelected){
        ScreenSelected.component =>
            Expanded(
              child: OneTwoTransition(
                  animation: railAnimation,
                  one: FirstComponentList(showNavBottomBar: showNavBarExample,
                      scaffoldKey: scaffoldKey,
                      showSecondList: showMediumSizeLayout || showLargerSizeLayout),
                  two:
              ),

            ),
      // TODO: Handle this case.
      ScreenSelected.color => throw UnimplementedError(),
      // TODO: Handle this case.
      ScreenSelected.typography => throw UnimplementedError(),
      // TODO: Handle this case.
      ScreenSelected.elevation => throw UnimplementedError(),
      }
}
