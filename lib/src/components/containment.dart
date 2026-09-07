// 骨架文件：对照参考项目 lib/src/components\containment.dart 手打补全
// 内容：M3 包含类组件（Card / Divider / Dialog）
import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_constants.dart';
import 'package:material_3_demo/src/components/component_decoration.dart';

class Containment extends StatelessWidget {

  const Containment({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const ComponentGroupDecoration(
      label: 'Containment',
      children: [
        BottomSheetSection(),
        Cards(),
        Carousels(),
        Dialogs(),
        Dividers(),
      ],
    );
  }

}


class BottomSheetSection extends StatefulWidget {

  const BottomSheetSection({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomSheetSectionsState();
  }
}

class _BottomSheetSectionsState extends State<BottomSheetSection> {

  bool isNonModalBottomSheetOpen = false;
  PersistentBottomSheetController? _nowModalBottomSheetController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> buttonList = <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.archive_outlined),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings_outlined),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
      ),
    ];

    List<Text> labelList = const <Text>[
      Text('Share'),
      Text('Add to'),
      Text('Trash'),
      Text('Archive'),
      Text('Settings'),
      Text('Favorite'),
    ];

    buttonList = List.generate(buttonList.length, (index) =>
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buttonList[index], labelList[index]
            ],
          ),
        ));

    return ComponentDecoration(
      label: 'Bottom sheet',
      tooltipMessage: 'Use showModalBottomSheet<T> or showBottomSheet<T>',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          TextButton(
            child: const Text(
              'Show modal bottom sheet',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                  showDragHandle: true,
                  context: context,
                  constraints: const BoxConstraints(
                      maxWidth: 640
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: buttonList,
                        ),
                      ),
                    );
                  }
              );
            },
          )
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {

  const Cards({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentDecoration(
      label: 'Cards',
      tooltipMessage: 'Use Card',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: carWidth,
            child: Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {

                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Elevated'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: carWidth,
            child: Card(
              color: Theme
                  .of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: () {

                      }, icon: const Icon(Icons.more_vert)),
                    ),
                    const SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Filled'),
                    )
                  ],
                ),
              ),

            ),
          ),
          SizedBox(
            width: carWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_vert)
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Outlined'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Carousels extends StatelessWidget {
  const Carousels({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentDecoration(
        label: 'Carousel',
        tooltipMessage: 'Use CarouselView',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  left: 8.0
              ),
              child: Text('Uncontained Carousel'),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 150),
              child: CarouselView(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10
                    ),
                    side: BorderSide(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .outline,
                    )
                ),
                shrinkExtent: 100,
                itemExtent: 180,
                children: List<Widget>.generate(20, (index) {
                  return Center(child: Text('Item $index'),);
                }),
              ),
            ),
            colDivider,
            const Padding(
              padding: EdgeInsets.only(
                  left: 8.0
              ),
              child: Text(
                  'Uncontained Carousel with snapping effect'
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                  height: 150
              ),
              child: CarouselView(
                itemSnapping: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .outline
                    )
                ),
                shrinkExtent: 100,
                itemExtent: 180,
                children: List<Widget>.generate(20, (index) {
                  return Center(child: Text('Item $index'),);
                }),
              ),
            )
          ],
        )
    );
  }
}

class Dialogs extends StatefulWidget {
  const Dialogs({super.key});

  @override
  State<Dialogs> createState() {
    // TODO: implement createState
    return _DialogsState();
  }
}

class _DialogsState extends State<Dialogs> {


  void openDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('What is a dialog?'),
              content: const Text(
                  'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.'
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Dismiss')
                ),
                FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OKay'))
              ],
            )
    );
  }

  void openFullscreenDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (context) =>
            Dialog.fullscreen(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                        'Full-screen dialog'
                    ),
                    centerTitle: false,
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),

                    actions: [
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              ),
            )

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ComponentDecoration(
        label: 'Dialog',
        tooltipMessage: 'Use showDialog with Dialog.fullscreen, AlertDialog, or SimpleDialog',
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                'Show dialog',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),

              ),
              onPressed: () => openDialog(context),
            ),
            TextButton(
              child: const Text(
                'Show full-screen dialog',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => openFullscreenDialog(context),
            )
          ],
        ),
    );
  }

}

class Dividers extends StatelessWidget{
  const Dividers({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const ComponentDecoration(
      label: 'Dividers',
      tooltipMessage: 'Use Divider or VerticalDivider',
      child: Column(
        children: <Widget>[
          Divider(
            key: Key('divider'),
          )
        ],
      ),
    );
  }
}

