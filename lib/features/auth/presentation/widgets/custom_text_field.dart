import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() {
    setState(() {
      hasText = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obscure : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator:
          widget.validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return "This can not be empty";
            }
            return null;
          },

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        prefixIconColor: hasText ? Theme.of(context).primaryColor : null,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(FontAwesomeIcons.solidEye),
                selectedIcon: Icon(FontAwesomeIcons.eyeSlash),
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
