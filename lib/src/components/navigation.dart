import 'package:flutter/material.dart';
import 'package:material_3_demo/src/components/component_constants.dart';
import 'package:material_3_demo/src/components/component_decoration.dart';

class Navigation extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const Navigation({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentGroupDecoration(
        label: 'Navigation',
        children: [
          const BottomAppBars(),
          const NavigationBars(selectedIndex: 0, isExampleBar: true),

        ]
    );
  }
}

class NavigationBars extends StatefulWidget {

  final int selectedIndex;
  final bool isExampleBar;
  final bool isBadgeExample;
  final void Function(int)? onSelectItem;

  const NavigationBars({
    super.key,
    this.onSelectItem,
    required this.selectedIndex,
    required this.isExampleBar,
    this.isBadgeExample = false,
  });

  @override
  State<NavigationBars> createState() {
    // TODO: implement createState
    return _NavigationBarsState();
  }
}

class _NavigationBarsState extends State<NavigationBars> {
  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget navigationBar = Focus(
      autofocus: !(widget.isExampleBar || widget.isBadgeExample),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (!widget.isExampleBar) {
            widget.onSelectItem!(index);
          }
        },
        destinations: widget.isExampleBar && widget.isBadgeExample
            ? barWithBadgeDestinations
            : widget.isExampleBar ? exampleBarDestinations : appBarDestinations,
      ),
    );

    if (widget.isExampleBar && widget.isBadgeExample) {
      navigationBar = ComponentDecoration(
        label: 'Badges',
        tooltipMessage: 'Use Badge or Badge.count',
        child: navigationBar,
      );
    } else if (widget.isExampleBar) {
      navigationBar = ComponentDecoration(
        label: 'Navigation bar',
        tooltipMessage: 'Use NavigationBar',
        child: navigationBar,
      );
    }
    return navigationBar;
  }
}

List<Widget> barWithBadgeDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Badge.count(count: 1000, child: const Icon(Icons.mail_outlined)),
    label: 'Mail',
    selectedIcon: Badge.count(count: 1000, child: const Icon(Icons.mail)),
  ),
  const NavigationDestination(
    tooltip: '',
    icon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble_outline)),
    label: 'Chat',
    selectedIcon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble)),
  ),
  const NavigationDestination(
    tooltip: '',
    icon: Badge(child: Icon(Icons.group_outlined)),
    label: 'Rooms',
    selectedIcon: Badge(child: Icon(Icons.group_rounded)),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Badge.count(
      count: 3,
      child: const Icon(Icons.videocam_outlined),
    ),
    label: 'Meet',
    selectedIcon: Badge.count(count: 3, child: const Icon(Icons.videocam)),
  ),
];


const List<Widget> exampleBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.explore_outlined),
    label: 'Explore',
    selectedIcon: Icon(Icons.explore),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.pets_outlined),
    label: 'Pets',
    selectedIcon: Icon(Icons.pets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.account_box_outlined),
    label: 'Account',
    selectedIcon: Icon(Icons.account_box),
  ),
];

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.widgets_outlined),
    label: 'Components',
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.format_paint_outlined),
    label: 'Color',
    selectedIcon: Icon(Icons.format_paint),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.text_snippet_outlined),
    label: 'Typography',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.invert_colors_on_outlined),
    label: 'Elevation',
    selectedIcon: Icon(Icons.opacity),
  ),
];

class BottomAppBars extends StatelessWidget {

  const BottomAppBars({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentDecoration(
      label: 'Bottom app bar',
      tooltipMessage: 'Use BottomAppBar',
      child:
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 0.0,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              const IconButtonAnchorExample(),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconButtonAnchorExample extends StatelessWidget {

  const IconButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        }, icon: const Icon(Icons.more_vert)
        );
      },
      menuChildren: [
        MenuItemButton(
          child: const Text('Menu 1'),
          onPressed: () {},
        ),
        MenuItemButton(
          child: const Text('Menu 2'),
          onPressed: () {},
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.1'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.2'),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Text('Menu 3.3'),
            ),
          ],
          child: const Text('Menu 3'),
        )
      ],
    );
  }
}


class NavigationDrawers extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavigationDrawers({
    super.key,
    required this.scaffoldKey
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ComponentDecoration(
      label: 'Navigation drawer',
      tooltipMessage: 'Use NavigationDrawer. For modal navigation drawers, see Scaffold.endDrawer',
      child: Column(
        children: [
          const SizedBox(
            height: 520,
            child: NavigationDrawerSection(),

          ),
         colDivider,
         colDivider,
         TextButton(
            child: const Text(
              'Show modal navigation drawer',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
           onPressed: (){
              scaffoldKey.currentState!.openDrawer();
           },
         )
        ],
      ),
    );
  }
}

class NavigationDrawerSection extends StatefulWidget{

  const NavigationDrawerSection({super.key});

  @override
  State<NavigationDrawerSection> createState() {
    // TODO: implement createState
      return _NavigationDrawerSectionState();
  }
}

class _NavigationDrawerSectionState extends State<NavigationDrawerSection> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavigationDrawer(
      onDestinationSelected: (selectedIndex){
        setState(() {
          navDrawerIndex = selectedIndex;
        });
      },
      selectedIndex: navDrawerIndex,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Mail',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...labelDestinations.map((destination){
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        })
      ],
    );
  }
}

class ExampleDestination {

  final String label;
  final Widget icon;
  final Widget selectedIcon;

const ExampleDestination(this.label, this.icon, this.selectedIcon);

}

const List<ExampleDestination> labelDestinations = <ExampleDestination>[
  ExampleDestination(
    'Family',
    Icon(Icons.bookmark_border),
    Icon(Icons.bookmark),
  ),
  ExampleDestination(
    'School',
    Icon(Icons.bookmark_border),
    Icon(Icons.bookmark),
  ),
  ExampleDestination(
    'Work',
    Icon(Icons.bookmark_border),
    Icon(Icons.bookmark),
  ),
];
