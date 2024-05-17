import 'package:flutter/material.dart';

class HomeSearchSection extends StatelessWidget {
  const HomeSearchSection({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.onEditingComplete,
  });

  final String hint;
  final Function(String value) onChanged;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}
