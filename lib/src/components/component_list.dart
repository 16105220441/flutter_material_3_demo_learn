import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_3_demo/src/components/communication.dart';
import 'package:material_3_demo/src/components/selection.dart';
import 'package:material_3_demo/src/components/text_inputs.dart';

import 'component_constants.dart';
import 'containment.dart';
import 'actions.dart' as actions;
import 'navigation.dart';

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
      const actions.Actions(),
      colDivider,
      const Communication(),
      if(!showSecondList) ...[
        colDivider,
        Navigation(scaffoldKey: scaffoldKey),
        colDivider,
        const Selection(),
        colDivider,
        const TextInputs(),
      ],


    ];

    List<double?> heights = List.filled(
        children.length, null
    );

    return FocusTraversalGroup(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: showSecondList ? const EdgeInsetsDirectional.only(
                end: smallSpacing) : EdgeInsets.zero,
            sliver: SliverList(
              delegate: BuildSlivers(
                  heights: heights,
                  builder: (context, index) {
                    return _CacheHeight(
                      heights: heights,
                      index: index,
                      child: children[index],
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SecondComponentList extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SecondComponentList({
    super.key,
    required this.scaffoldKey
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> children = [
      Navigation(
        scaffoldKey: scaffoldKey),
      colDivider,
      const Selection(),
      colDivider,
      const Selection(),
      colDivider,
      const TextInputs(),
    ];
    List<double?> heights = List.filled(
      children.length,null
    );

    return FocusTraversalGroup(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsetsDirectional.only (end: smallSpacing),
            sliver: SliverList(
              delegate: BuildSlivers(
                heights: heights,
                builder: (context,index){
                  return _CacheHeight(
                      heights: heights,
                      index: index,
                    child: children[index],
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuildSlivers extends SliverChildBuilderDelegate {


  final List<double?> heights;

  BuildSlivers({
    required NullableIndexedWidgetBuilder builder,
    required this.heights,
  }) :super(builder, childCount: heights.length);

  @override
  double? estimateMaxScrollOffset(int firstIndex,
      int lastIndex,
      double leadingScrollOffset,
      double trailingScrollOffset,) {
    return heights.reduce((sum, height) => (sum ?? 0) + (height ?? 0)
    )!;
  }
}

class _RenderCacheHeight extends RenderProxyBox {


  List<double?> _heights;

  List<double?> get heights => _heights;

  set heights(List<double?> value) {
    if (value == _heights) {
      return;
    }
    _heights = value;
  }

  int _index;

  int get index => _index;

  set index(int value) {
    if (value == index) {
      return;
    }

    _index = value;
    markNeedsLayout();
  }

  _RenderCacheHeight({
    required List<double?> heights,
    required int index
  })
      : _heights =heights,
        _index = index,
        super();


  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
    heights[index] = size.height;
  }

}


class _CacheHeight extends SingleChildRenderObjectWidget {


  final List<double?> heights;
  final int index;

  const _CacheHeight({
    super.child,
    required this.heights,
    required this.index,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return _RenderCacheHeight(
        heights: heights, index: index
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderCacheHeight renderObject) {
    // TODO: implement updateRenderObject
    renderObject
      ..heights = heights
      ..index = index;
  }
}
