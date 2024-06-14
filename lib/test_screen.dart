import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class CustomNavBarWidget extends StatelessWidget {
        final int selectedIndex;
        final List<PersistentBottomNavBarItem> items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
        final ValueChanged<int> onItemSelected;

        CustomNavBarWidget(
            {required Key key,
            required this.selectedIndex,
            required this.items,
            required this.onItemSelected,});

        Widget _buildItem(
            PersistentBottomNavBarItem item, bool isSelected) {
            return Container(
              color: Colors.blue,
            alignment: Alignment.center,
            height: 60.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                Flexible(
                    child: IconTheme(
                    data: IconThemeData(
                        size: 26.0,
                        color: isSelected
                            ? (item.activeColorSecondary == null
                                ? item.activeColorPrimary
                                : item.activeColorSecondary)
                            : item.inactiveColorPrimary == null
                                ? item.activeColorPrimary
                                : item.inactiveColorPrimary),
                    child: item.icon,
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Material(
                    type: MaterialType.transparency,
                    child: FittedBox(
                        child: Text(
                        item.title!,
                        style: TextStyle(
                            color: isSelected
                                ? (item.activeColorSecondary == null
                                    ? item.activeColorPrimary
                                    : item.activeColorSecondary)
                                : item.inactiveColorPrimary,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                    )),
                    ),
                )
                ],
            ),
            );
        }

        @override
        Widget build(BuildContext context) {
            return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                  height: 24,
                  color: Colors.blue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24)),
                        color: Colors.white
                    ),),),
                Container(
                    width: double.infinity,
                    height: 60.0,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: items.map((item) {
                        int index = items.indexOf(item);
                        return Flexible(
                        child: GestureDetector(
                            onTap: () {
                            this.onItemSelected(index);
                            },
                            child: _buildItem(
                                item, selectedIndex == index),
                        ),
                        );
                    }).toList(),
                    ),
                ),
              ],
            ),
            );
        }
    }

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: CustomNavBarWidget(
        key: Key("0"), 
        onItemSelected: (int) {},
        selectedIndex: 0,
        items:  [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work),
        title: "Listings",
        activeColorPrimary: Color.fromARGB(255, 31,69,77),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: "Notifications",
        activeColorPrimary: Color.fromARGB(255, 31,69,77),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Color.fromARGB(255, 31,69,77),
        inactiveColorPrimary: Colors.grey,
      ),
    ]),);
  }
}