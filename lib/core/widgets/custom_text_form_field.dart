import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sabzi/core/widgets/radio_widget.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String? hintText;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final int maxLines;
  final bool expands;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.expands = false,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 15),
          cursorColor: Theme.of(context).colorScheme.onSurface,
          expands: expands,
          maxLines: maxLines,
          textInputAction: TextInputAction.done,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Theme.of(context).colorScheme.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        if (errorText != null)
          Row(
            children: [
              const Icon(
                Icons.info,
                size: 20,
                color: Colors.red,
              ),
              const SizedBox(width: 5),
              Text(
                errorText!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
