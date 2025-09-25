import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final void Function()? onTap;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscure : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(Icons.visibility_rounded),
                selectedIcon: Icon(Icons.visibility_off_rounded),
                isSelected: obscure,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).inputDecorationTheme.fillColor,
                ),
                onPressed: () => setState(() => obscure = !obscure),
              )
            : null,
      ),
    );
  }
}
