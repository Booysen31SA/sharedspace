import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sharedspace/components/NameTextBoxGlobal.dart';
import 'package:sharedspace/components/colorPicker.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/util/convertStringToColor.dart';

class CreationForms extends StatefulWidget {
  const CreationForms({Key? key}) : super(key: key);

  @override
  State<CreationForms> createState() => _CreationFormsState();
}

class _CreationFormsState extends State<CreationForms> {
  // Creation of SharedSpace
  final _creationSharedSpaceFormKey = GlobalKey<FormBuilderState>();
  final _creationSharedSpaceGroupNameFieldKey = GlobalKey<FormBuilderState>();

  //general
  var _groupSettingGroupColorFieldKey;
  bool isReloading = false;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: Header(
        appBar: AppBar(),
        prefixIcon: GestureDetector(
          onTap: () => {
            if (arguments['screen'] == 'home')
              {
                Navigator.pushReplacementNamed(context, '/home'),
              },
          },
          child: Icon(backArrow, color: primaryClr),
        ),
        heading: Text(
          arguments['creationtitle'],
          style: const TextStyle(
            fontSize: 26,
            color: primaryClr,
          ),
        ),
        suffixIcon: null,
      ),
      body: SafeArea(
        child: FormBuilder(
            child: Column(
          children: <Widget>[
            arguments['screen'] == 'home' ? sharedSpaceCreation() : Container(),
          ],
        )),
      ),
    );
  }

  sharedSpaceCreation() {
    if (!isReloading) {
      _groupSettingGroupColorFieldKey = primaryClr;
    }
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      child: FormBuilder(
        key: _creationSharedSpaceFormKey,
        child: Column(
          children: <Widget>[
            //Group Name
            nameTextBoxGlobal(
              text: 'Group Name',
              key: _creationSharedSpaceGroupNameFieldKey,
              data: null,
              readOnly: false,
            ),

            // Colour Picker
            colorPickerContainer(
              context: context,
              key: _groupSettingGroupColorFieldKey,
              onTap: changeColorOnTap,
              onChange: changeColor,
            ),
          ],
        ),
      ),
    );
  }

  void changeColorOnTap() {
    setState(() {
      _groupSettingGroupColorFieldKey = _groupSettingGroupColorFieldKey;
    });
    Navigator.of(context).pop();
  }

  void changeColor(Color color) {
    isReloading = true;
    setState(() => {_groupSettingGroupColorFieldKey = color});
  }
}
