import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_constants.dart';
import 'component_decoration.dart';
import 'navigation.dart';

class Communication extends StatelessWidget {
  const Communication({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentGroupDecoration(
        label: 'Communication',
        children: [
          NavigationBars(
            selectedIndex: 1,
            isExampleBar: true,
            isBadgeExample: true,
          ),
          ProgressIndicators(),
        ]
    );
  }
}

class ProgressIndicators extends StatefulWidget {

  const ProgressIndicators({super.key});

  @override
  State<ProgressIndicators> createState() {
    // TODO: implement createState
    return _ProgressIndicatorsState();
  }
}

class _ProgressIndicatorsState extends State<ProgressIndicators> {

  bool playProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double? progressValue = playProgressIndicator ? null : 0.7;

    return ComponentDecoration(
      label: 'Progress indicators',
      tooltipMessage: 'Use CircularProgressIndicator or LinearProgressIndicator',
      child: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                isSelected: playProgressIndicator,
                selectedIcon: const Icon(Icons.pause),
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  playProgressIndicator != playProgressIndicator;
                },
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    rowDivider,
                    CircularProgressIndicator(
                      value: progressValue,
                    ),
                    rowDivider,
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressValue,
                      ),
                    ),
                    rowDivider
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SnackBarSection extends StatelessWidget {

  const SnackBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentDecoration(
      label: 'Snackbar',
      tooltipMessage: 'Use ScaffoldMessenger.of(context).showSnackBar with SnackBar',
      child: TextButton(
        onPressed: () {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 400.0,
            content: const Text(
                'This is a snackbar'
            ),
            action: SnackBarAction(
                label: 'Close',
                onPressed: () {

                }
            ),
          );

          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text(
            'Show snackbar',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
        ),
      ),
    );
  }
}