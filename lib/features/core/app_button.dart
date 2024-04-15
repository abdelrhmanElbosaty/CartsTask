import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? name;
  final Color? color;
  final void Function()? onTap;

  const AppButton({super.key, required this.name, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: color,
        ),
        child: Center(
          child: Text(
            name!,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
