import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sharedspace/configs/themes.dart';

nameTextBoxGlobal(
    {context,
    text,
    key,
    data,
    readOnly,
    name,
    description = false,
    validate = true}) {
  return Container(
    margin: const EdgeInsets.only(top: 15, right: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   text,
        //   style: settingSizes,
        // ),

        SizedBox(
          width: MediaQuery.of(context).size.width / 0.5,
          child: FormBuilderTextField(
            maxLines: description ? 5 : 1,
            readOnly: readOnly ?? false,
            key: key,
            name: text,
            initialValue: data,
            decoration: inputDecoration(
              borderColor: primaryClr,
              isfocusBorder: true,
              hintText: text,
            ),
            validator: validate
                ? FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ])
                : FormBuilderValidators.compose([]),
          ),
        ),
      ],
    ),
  );
}
