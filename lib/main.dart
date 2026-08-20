// 入口文件（对照参考项目 lib/main.dart，只保留入口与导出）
import 'package:flutter/material.dart';

import 'src/app.dart';

export 'src/app.dart' show App;

void main() async {
  runApp(const App());
}
