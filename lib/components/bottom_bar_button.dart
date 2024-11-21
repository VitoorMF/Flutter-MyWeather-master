import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black26)),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
      ),
      width: 300 / 3,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
        ),
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(
            Size(300 / 3, 90),
          ),
        ),
      ),
    );
  }
}
