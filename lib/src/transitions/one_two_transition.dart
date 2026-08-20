import 'package:flutter/material.dart';
import 'package:material_3_demo/src/transitions/animations.dart';
import 'package:material_3_demo/src/constants.dart';

class OneTwoTransition extends StatefulWidget {
  final Animation<double> animation;
  final Widget one;
  final Widget two;

  const OneTwoTransition({
    super.key,
    required this.animation,
    required this.one,
    required this.two,
  });

  @override
  State<OneTwoTransition> createState() {
    // TODO: implement createState
    return _oneTwoTransitionState();
  }
}

class _oneTwoTransitionState extends State<OneTwoTransition> {

  late final Animation<Offset> offsetAnimation;
  late final Animation<double> widthAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offsetAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero
    ).animate(OffsetAnimation(widget.animation));

    widthAnimation = Tween<double>(
      begin: 0,
      end: mediumWidthBreakpoint,
    ).animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Flexible(
          flex: mediumWidthBreakpoint.toInt(),
          child: widget.one,
        ),
        if(widthAnimation.value.toInt() > 0)...[
          Flexible(
            flex: widthAnimation.value.toInt(),
            child: FractionalTranslation(
                translation: offsetAnimation.value,
              child: widget.two,
            ),
          )
        ]
      ],
    );
  }
}
