import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

colorPicker({context, color, onPress, onChange}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          MaterialButton(
            onPressed: onPress,
            child: const Text('Group Color'),
          ),
        ],
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: color,
            onColorChanged: onChange,
          ),
        ),
      );
    },
  );
}
