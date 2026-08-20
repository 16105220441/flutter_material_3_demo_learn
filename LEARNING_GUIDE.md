# Material 3 Demo 学习指南

> 本文档依据 [`BEGINNER_GUIDE.md`](../BEGINNER_GUIDE.md) 编写，是 **第一阶段「熟悉 Flutter 基础」** 的配套学习材料。
>
> 学习内容：**Material 3 组件和设计规范**

---

## 1. 学习阶段定位

在初学者学习路线中，本项目处于 **第一阶段**，与 `form_app`（表单与状态管理）、`testing_app`（测试）、`animations`（动画）、`cupertino_gallery`（iOS 风格组件）同级别。

**建议前置知识**：

- 已掌握 Dart 基础语法（类、枚举、函数、异步）
- 已通过 `form_app` 或官方教程熟悉 Widget、StatefulWidget、setState 的基本用法
- 会运行 Flutter 项目（`flutter pub get` / `flutter run`）

**学完本项目后**，你将对 Material Design 3 有系统认识，能够为自己的 Flutter 应用配置 M3 主题并熟练使用常用组件，这也为后续学习「导航与架构」「平台与高级特性」打下界面层基础。

---

## 2. 项目简介

`material_3_demo` 是 Flutter 官方示例，全面展示 Flutter Material 库中 **Material 3（M3）** 的特性：

- **组件**：AppBar、按钮、FAB、Chips、Card、Checkbox、Dialog、NavigationBar、NavigationRail、进度指示器、Radio、TextField、Switch 等
- **排版**：完整的 TextTheme 文字样式
- **颜色系统**：从单个种子颜色（seed color）生成整套明暗配色，甚至可以从图片中提取配色
- **高度（Elevation）**：M3 新增的 `surfaceTintColor` 特性
- **主题切换**：亮色/暗色模式、Material 2 / Material 3 一键切换对比

M3 设计规范官方文档：<https://m3.material.io/>

### 运行方式

```bash
cd material_3_demo
flutter pub get
flutter run -d windows   # 桌面端可以看到完整的自适应布局效果
# 或
flutter run -d chrome
```

**建议用桌面端或 Web 运行**：拖动窗口宽度可以直观看到 NavigationRail 与 NavigationBar 的自适应切换（见下文「自适应布局」）。

---

## 3. 学习目标

### 3.1 总体目标

1. 理解 **Material 3 设计系统** 的核心概念（颜色、排版、组件、高度），并能说出它与 Material 2 的主要区别。
2. 掌握在 Flutter 中 **配置 M3 主题** 的方法：种子颜色生成、亮/暗主题、M2/M3 切换。
3. 熟练使用 M3 更新后的 **常用组件**，并能根据语义（主要/次要/强调动作）选择正确的按钮等组件。
4. 理解并实现 **自适应布局**：根据屏幕宽度在 NavigationRail 与 NavigationBar 之间切换。
5. 初步理解本项目中使用的 **动画过渡** 与 **状态提升** 模式。

### 3.2 具体目标（学完后应能做到）

- [ ] 用一个 `Color` 作为种子，通过 `ColorScheme.fromSeed` 生成一整套明暗配色方案
- [ ] 说出 `ColorScheme` 中至少 10 个角色色（role）的含义（如 primary、onPrimary、surfaceContainer、outline……）
- [ ] 配置 `ThemeData` 的 `theme` / `darkTheme` / `themeMode`，实现跟随系统/手动切换明暗
- [ ] 解释 `useMaterial3: true/false` 对组件外观的影响
- [ ] 说出 M3 中 5 类按钮（Filled / Elevated / Outlined / Text / Icon）各自的使用场景
- [ ] 写出一个 `NavigationRail` 与 `NavigationBar` 随宽度切换的最小实现
- [ ] 解释 `surfaceTintColor` 与 `shadowColor` 的区别
- [ ] 说出 M3 文字排版的 5 个族（Display / Headline / Title / Label / Body）及各自用途
- [ ] 说明本项目为何把大量状态放在 `App` 中并通过回调传给子组件（状态提升）

---

## 4. 知识点图谱（要掌握什么）

### 模块一：Material 3 设计系统基础（理念层）

| 知识点 | 说明 |
|--------|------|
| M3 设计理念 | 个性化（个性化配色）、自适应（不同屏幕）、包容性（无障碍）。详见 m3.material.io |
| M2 vs M3 差异 | 圆角更大、阴影更柔和、颜色系统改为 tone-based、部分组件样式重设计 |
| `useMaterial3` | `ThemeData` 的标志位，控制使用 M2 还是 M3 的组件样式 |
| 官方设计规范 | Material 3 规范：颜色 / 排版 / 组件 / 高度 / 动效 |

### 模块二：主题与颜色系统（核心，最重点）

**入口代码**：`lib/main.dart` → `ThemeData` 构建

- `MaterialApp` 的 `theme`、`darkTheme`、`themeMode` 三个参数的关系
- `ThemeMode.system / light / dark` 与 `Brightness.light / dark`
- **种子颜色**：`ThemeData(colorSchemeSeed: ...)` 内部即调用 `ColorScheme.fromSeed`
- `ColorScheme.fromImageProvider(provider: NetworkImage(url))` —— 从图片提取配色
- `ColorScheme` 的角色色体系（阅读 `lib/src/theme/scheme.dart` 会全部看到）：
  - 主要色：`primary` / `onPrimary` / `primaryContainer` / `onPrimaryContainer`
  - 次要 / 强调色：`secondary*`、`tertiary*`
  - 表面色：`surface`、`surfaceDim`、`surfaceBright`、`surfaceContainer*`（5 个层级）、`onSurface`、`onSurfaceVariant`
  - 描边色：`outline`、`outlineVariant`
  - 错误色：`error` / `errorContainer` 及其 on 系列
  - 反面色：`inverseSurface`、`onInverseSurface`、`inversePrimary`
  - 其他：`scrim`、`shadow`
- 色调（tone）概念：M3 色板用色调编号（如 P-40、N-90）表示，明/暗模式下同角色色使用不同色调
- `Theme.of(context).colorScheme` 在 Widget 中读取颜色（**不要写死颜色**）

### 模块三：M3 组件（动手层）

**入口代码**：`lib/src/components/`（组件页代码按语义分组拆分到多个文件，见 `component_list.dart` 与各组件分组文件）

组件分组（M3 语义分类）：

| 分类 | 组件 |
|------|------|
| 动作 Actions | `FilledButton`、`FilledButton.tonal`、`ElevatedButton`、`OutlinedButton`、`TextButton`、`IconButton`、`FloatingActionButton`（FAB） |
| 通信 Communication | 进度指示器：`LinearProgressIndicator`、`CircularProgressIndicator` |
| 包含 Containment | `Card`、`Divider`、`Dialog`（`AlertDialog`、`SimpleDialog`） |
| 导航 Navigation | `AppBar`、`NavigationBar`（底部）、`NavigationRail`（侧边）、`PopupMenuButton` |
| 选择 Selection | `Checkbox`、`Radio`、`Switch`、`Chip` |
| 文本输入 TextInputs | `TextField`（含 `TextEditingController` 的状态管理） |

需要掌握每个组件的：

- 构造参数（尤其是 `onPressed` / `onChanged` / `onSelected` 等回调）
- 与 M2 的差异（例：M2 的 `RaisedButton` → M3 的 `FilledButton`；M2 的 `FlatButton` → M3 的 `TextButton`）
- 图标按钮相关：`IconButton` + `Tooltip` 组合（阅读 `lib/src/settings/buttons.dart`，AppBar 上的主题切换按钮）

### 模块四：自适应布局（响应式）

**入口代码**：`lib/src/screens/home.dart` + `lib/src/constants.dart`

- `MediaQuery.of(context).size.width` 获取屏幕宽度
- 断点常量：`mediumWidthBreakpoint = 1000`、`largeWidthBreakpoint = 1500`、`narrowScreenWidthThreshold = 450`
- 布局规则：窄屏（<1000）→ 底部 `NavigationBar`；宽屏 → 左侧 `NavigationRail`（≥1500 时 `extended: true` 展开显示文字）
- `didChangeDependencies` 中监听宽度变化（窗口大小改变时触发重建）
- `elevation_screen.dart` 中还用 `SliverLayoutBuilder` 根据 `crossAxisExtent` 切换网格列数（3 列 / 6 列）

### 模块五：动画与过渡（进阶）

**入口代码**：`lib/src/transitions/`（`animations.dart`、`one_two_transition.dart`、`rail_transition.dart`、`bar_transition.dart`、`navigation_transition.dart`）

- `AnimationController`（需要 `SingleTickerProviderStateMixin`）
- `CurvedAnimation` + `Interval`（分段曲线，让两个过渡串联播放）
- `AnimatedBuilder`（监听动画逐帧重建）
- 布局切换动画：窄屏↔宽屏切换时，组件列表在两种布局间平滑过渡
- `dispose()` 中释放 AnimationController（防止内存泄漏）

### 模块六：Dart 语言与工程模式（贯穿全项目）

| 知识点 | 示例 |
|--------|------|
| 带字段的增强枚举 | `enum ColorSeed { baseColor('M3 Baseline', Color(0xff6750a4)), ... }`（constants.dart） |
| Dart 3 switch 表达式 | `createScreenFor` 中的 `switch (screenSelected) { ... }`（home.dart） |
| 状态提升（Lifting State Up） | 所有主题状态放在 `_AppState`，通过回调函数（如 `handleBrightnessChange`）传给子组件，子组件保持无状态 |
| 回调类型字段 | `final void Function(bool useLightMode) handleBrightnessChange;` |
| `const` 构造函数与不可变 Widget | 全项目惯例 |
| RenderObject 自定义 | `_CacheHeight` / `_RenderCacheHeight`（`lib/src/components/component_list.dart`，缓存组件高度避免跳动） |
| 列表懒加载 | `SliverChildBuilderDelegate` / `CustomScrollView` / `SliverGrid` |

### 模块七：测试（巩固）

- `test/`：color_screen、component_screen、elevation_screen、typography_screen 的 Widget 测试
- `integration_test/`：集成测试
- 依赖 `flutter_test` / `integration_test`，可自行运行 `flutter test` 验证

---

## 5. 推荐学习路线（按此顺序阅读代码）

> 遵循 `BEGINNER_GUIDE.md` 第 5 节的阅读方法：README → pubspec → main.dart → 逐层深入。

### 第 1 步：运行体验（30 分钟）

```bash
cd material_3_demo && flutter run -d windows
```

在桌面上**逐个尝试**：

1. 点击 AppBar 右上角的明暗切换按钮
2. 点击切换 M2 / M3 按钮，对比组件外观差异（注意按钮圆角、Checkbox 样式等）
3. 用调色板按钮切换 9 种种子颜色，观察整套配色变化
4. 用图片按钮切换 6 张图片，观察「从图片提取配色」
5. 拖动窗口宽度，观察底部 NavigationBar ↔ 侧边 NavigationRail 的切换
6. 浏览 4 个页面：Components（组件）、Colors（颜色）、Typography（排版）、Elevation（高度）

### 第 2 步：阅读主题与入口（重点，60 分钟）

| 文件 | 学什么 |
|------|--------|
| `lib/main.dart` → `lib/src/app.dart` | ThemeData 构建、colorSchemeSeed、useMaterial3、themeMode、状态提升模式 |
| `lib/src/constants.dart` | 增强枚举、断点常量、颜色角色定义 |

> 疑问自查：为什么 `_AppState` 里要管理 6 个状态？为什么用回调而不是把 State 传下去？

### 第 3 步：阅读主页面与自适应布局（60 分钟）

| 文件 | 学什么 |
|------|--------|
| `lib/src/screens/home.dart` | 自适应布局、NavigationRail / NavigationBar、didChangeDependencies 宽度监听 |

> 疑问自查：`controllerInitialized` 这个标志位是干什么的？（提示：避免首次布局时动画从 0 播放）

### 第 4 步：阅读组件页（90 分钟，最花时间）

| 文件 | 学什么 |
|------|--------|
| `lib/src/components/` | 全部 M3 组件用法，按「动作/通信/包含/导航/选择/输入」分组：`actions.dart`、`communication.dart`、`containment.dart`、`navigation.dart`、`selection.dart`、`text_inputs.dart` |

> 方法建议：按组件分类逐文件读（每个分组文件都很短），每读完一类组件，回到运行中的 App 里实际点一点。

### 第 5 步：阅读颜色 / 排版 / 高度页（60 分钟）

| 文件 | 学什么 |
|------|--------|
| `lib/src/screens/color_palettes_screen.dart` | 明暗色板展示 |
| `lib/src/theme/scheme.dart` | ColorScheme 全部角色色（配合 m3.material.io 的 color roles 页面） |
| `lib/src/screens/typography_screen.dart` | TextTheme 的 15 种文字样式（5 族 × 大中小） |
| `lib/src/screens/elevation_screen.dart` | elevation 层级、surfaceTintColor、SliverLayoutBuilder |
| `lib/src/theme/color_box.dart` | 小组件复用 |

### 第 6 步：动画与过渡（选学，60 分钟）

| 文件 | 学什么 |
|------|--------|
| `lib/src/transitions/animations.dart` | 动画曲线定义 |
| `lib/src/transitions/one_two_transition.dart` / `rail_transition.dart` / `bar_transition.dart` | 三种过渡 |
| `lib/src/transitions/navigation_transition.dart` | 导航组件整体过渡 |

> 动画是加分项。如果第一遍觉得难，可以先跳过，完成下面「动手练习」后再回来。

---

## 6. 动手练习（边改边学，强烈建议）

基于 `BEGINNER_GUIDE.md` 第 8 节的建议，在示例上做小改动观察效果：

1. **加一个种子颜色**：在 `constants.dart` 的 `ColorSeed` 枚举中新增一种颜色（如紫色系外的 `pinkAccent`），看是否自动出现在调色板菜单中。
2. **改断点**：把 `mediumWidthBreakpoint` 从 1000 改成 600，重新运行，拖动窗口观察 NavigationRail 出现时机变化。
3. **自定义文字样式**：在 `ThemeData` 中添加 `textTheme: TextTheme(...)` 覆盖某个样式（如把 `titleLarge` 加粗），观察 Typography 页面变化。
4. **新建一个页面**：仿照 `ElevationScreen` 新建一个 `MyComponentScreen`，在 `home.dart` 的 `ScreenSelected` 枚举中注册，实践完整流程（枚举 → 分支 → 导航）。
5. **写一个测试**：仿照 `test/` 中的测试，为你的新页面写一个 Widget 测试。
6. **挑战：布局三档**：利用三个断点（450 / 1000 / 1500）实现 窄 / 中 / 宽 三种布局形态。

---

## 7. 知识掌握自测清单

学完后，试着不看代码回答以下问题：

1. M3 与 M2 在组件样式上有哪些可见差异？
2. 如何从一个颜色生成整套明暗主题？`colorSchemeSeed` 背后做了什么？
3. `onPrimary` 与 `primary` 的关系是什么？为什么每个颜色都有对应的 `on*` 色？
4. `surfaceContainerLow` 与 `surfaceContainerHighest` 谁更浅？分别适合什么场景？
5. 为什么设计上要把 FAB 用 `FloatingActionButton` 而不是 `ElevatedButton`？
6. NavigationRail 与 NavigationBar 各自适合什么屏幕？本项目如何切换？
7. `surfaceTintColor` 和 `shadowColor` 分别是干什么的？Elevation 页的三种展示方式说明了什么？
8. TextTheme 的 Display / Headline / Title / Label / Body 五族分别用于什么场景？
9. 本项目为什么不使用第三方状态管理库？`setState` + 回调在这个规模下够用的原因是什么？
10. 如果要在你的应用里全局切换亮暗模式，参照本项目你会怎么做？

---

## 8. 参考资源

| 资源 | 说明 |
|------|------|
| [Material 3 官方规范](https://m3.material.io/) | 设计规范权威来源 |
| [Flutter Material 文档](https://docs.flutter.dev/ui/material) | Flutter 中 Material 组件与主题 |
| [ColorScheme API](https://api.flutter.dev/flutter/material/ColorScheme-class.html) | 角色色完整定义 |
| [TextTheme API](https://api.flutter.dev/flutter/material/TextTheme-class.html) | 文字样式 |
| [NavigationRail API](https://api.flutter.dev/flutter/material/NavigationRail-class.html) | 侧边导航 |
| [Flutter Cookbook](https://docs.flutter.dev/cookbook) | 实用技巧（主题、布局、测试） |

---

## 9. 下一步

完成本项目后，你的 Flutter 界面基础已经扎实，建议继续 `BEGINNER_GUIDE.md` 中的：

- **第二阶段**：`navigation_and_routing`（go_router 路由）、`compass_app`（MVVM 架构）
- 或与界面相关的 `animations`（动画专项）深入学习