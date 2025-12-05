import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/textfield_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String id;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TextFieldProvider>(context);
    bool isFocused = provider.isFocused(id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isFocused
            ? const Color.fromARGB(163, 190, 190, 190)
            : const Color.fromARGB(128, 152, 152, 152),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Focus(
        onFocusChange: (value) {
          provider.setFocus(id, value);
        },
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: isFocused ? 12 : 14,
              height: 3,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
