
import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
   
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? const Color.fromARGB(255, 106, 81, 206): Colors.black54,
          ),
        ),
      
      ],
    );
  }
}
