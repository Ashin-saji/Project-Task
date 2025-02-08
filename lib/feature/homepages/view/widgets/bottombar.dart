import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/navbar.dart';
import '../pages/calendar.dart';
import '../pages/task_page.dart';
import 'task_list_page.dart';

class CustomNavBar extends ConsumerStatefulWidget {
  const CustomNavBar({super.key});

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends ConsumerState<CustomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
  TaskListPage(),
  SchedulePage(),
];

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarIcon(
                icon: CupertinoIcons.list_bullet,
                selected: _selectedIndex == 0,
                onPressed: () => _onNavBarItemTapped(0),
              ),
              const SizedBox(width: 40),
              NavBarIcon(
                icon: CupertinoIcons.calendar,
                selected: _selectedIndex == 1,
                onPressed: () => _onNavBarItemTapped(1),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 106, 81, 206),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: CreateTaskPage(),
            ),
          );
        },
        child: const Icon(
          CupertinoIcons.plus,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
