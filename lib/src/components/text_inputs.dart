// 骨架文件：对照参考项目 lib/src/components\text_inputs.dart 手打补全
// 内容：M3 文本输入组件（TextField 及状态管理）
import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_decoration.dart';

class TextInputs extends StatelessWidget {

  const TextInputs({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const ComponentGroupDecoration(
        label: 'Text inputs',
        children: [TextFields()]);
  }
}

class TextFields extends StatefulWidget{


  const TextFields({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
