// 骨架文件：对照参考项目 lib/src/components\containment.dart 手打补全
// 内容：M3 包含类组件（Card / Divider / Dialog）
import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_decoration.dart';

class Containment extends StatelessWidget{

  const Containment({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const ComponentGroupDecoration(
      label: 'Containment',
      children: [

      ],
    );
  }

}

class BottomSheetSection extends StatefulWidget{

  const BottomSheetSection({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _BottomSheetSectionsState extends State<BottomSheetSection> {

  bool isNonModalBottomSheetOpen = false;
  PersistentBottomSheetController? _nowModalBottomSheetController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> buttonList = <Widget>[
      IconButton(onPressed: (){}, icon: const Icon(Icons.share_outlined)),
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

    buttonList = List.generate(buttonList.length, (index) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buttonList[index],labelList[index]
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
            onPressed: (){
               showModalBottomSheet<void>(
                 showDragHandle: true,
                 context: context,
                 constraints: const BoxConstraints(
                   maxWidth: 640
                 ),
                 builder: (context){
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
