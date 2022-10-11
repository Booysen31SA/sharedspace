import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sharedspace/configs/themes.dart';

colorPicker({context, color, onPress, onChange}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          MaterialButton(
            onPressed: onPress,
            child: const Text('Change Color'),
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

Container colorPickerContainer({context, onTap, onChange, key}) {
  return Container(
    margin: const EdgeInsets.only(top: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Change Colour',
          style: settingSizes,
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            colorPicker(
              context: context,
              color: key,
              onPress: onTap,
              onChange: onChange,
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.height / 20,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: key,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
