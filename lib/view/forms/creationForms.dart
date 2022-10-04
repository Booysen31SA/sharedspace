import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/NameTextBoxGlobal.dart';
import 'package:sharedspace/components/colorPicker.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/services/functions.dart';
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
    final firebaseUser = context.watch<User?>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: Header(
        appBar: AppBar(),
        prefixIcon: GestureDetector(
          onTap: () => {
            if (arguments['screen'] == 'home')
              {
                Navigator.pop(context),
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
            arguments['screen'] == 'home'
                ? sharedSpaceCreation(firebaseUser)
                : Container(),
          ],
        )),
      ),
    );
  }

  sharedSpaceCreation(firebaseUser) {
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

            Container(
              margin: const EdgeInsets.only(
                top: 20,
                right: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryClr,
              ),
              width: MediaQuery.of(context).size.width * 1,
              child: MaterialButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  final validateSuccess = _creationSharedSpaceFormKey
                      .currentState!
                      .saveAndValidate();
                  if (validateSuccess) {
                    var data = _creationSharedSpaceFormKey.currentState!.value;

                    var result = await createSharedSpaceGroup(
                      context: context,
                      groupname: data['Group Name'],
                      groupcolor: _groupSettingGroupColorFieldKey,
                      useruid: firebaseUser.uid.toString(),
                    );

                    if (!result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed, Please try again')),
                      );
                    }
                  }
                },
                child: const Text(
                  'Create Group',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
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
