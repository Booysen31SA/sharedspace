import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/NameTextBoxGlobal.dart';
import 'package:sharedspace/components/colorPicker.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
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

  // Creation of Note
  final _creationNoteFormKey = GlobalKey<FormBuilderState>();
  final _creationNoteTitleFieldKey = GlobalKey<FormBuilderState>();
  final _creationNoteDescriptionFieldKey = GlobalKey<FormBuilderState>();
  final _creationNoteIsEditableFieldKey = GlobalKey<FormBuilderState>();

  //general
  var _groupSettingGroupColorFieldKey;
  bool isReloading = false;
  bool isLoading = false;

  // Options
  List<String> isEditableOptions = ['Yes', 'No'];

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
            Navigator.pop(context),
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
            returnScreen(
                arguments['screen'], firebaseUser, arguments['groupid'])
          ],
        )),
      ),
    );
  }

  returnScreen(screen, firebaseUser, groupid) {
    if (screen == 'home') {
      return sharedSpaceCreation(firebaseUser);
    } else if (screen == 'note') {
      return createNoteForm(firebaseUser, groupid);
    } else if (screen == 'calander') {
      return createCalander();
    }
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
              child: isLoading
                  ? const CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final validateSuccess = _creationSharedSpaceFormKey
                            .currentState!
                            .saveAndValidate();
                        if (validateSuccess) {
                          var data =
                              _creationSharedSpaceFormKey.currentState!.value;

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

  createNoteForm(firebaseUser, groupid) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      child: FormBuilder(
        key: _creationNoteFormKey,
        child: Column(
          children: <Widget>[
            //Title
            nameTextBoxGlobal(
              text: 'Title',
              key: _creationNoteTitleFieldKey,
              data: null,
              readOnly: false,
            ),

            // Description
            nameTextBoxGlobal(
              text: 'Description',
              key: _creationNoteDescriptionFieldKey,
              data: null,
              readOnly: false,
            ),

            // isEditable
            Container(
              margin: const EdgeInsets.only(top: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Can other edit',
                    style: settingSizes,
                  ),
                  SizedBox(
                    width: 260,
                    child: FormBuilderDropdown<String>(
                      key: _creationNoteIsEditableFieldKey,
                      name: 'isEditable',
                      initialValue: 'Yes',
                      decoration: inputDecoration(
                        borderColor: primaryClr,
                        isfocusBorder: true,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      items: isEditableOptions
                          .map(
                            (child) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: child,
                              child: Text(child),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            //button
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
              child: isLoading
                  ? const CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: () async {
                        final validateSuccess = _creationNoteFormKey
                            .currentState!
                            .saveAndValidate();
                        if (validateSuccess) {
                          var data = _creationNoteFormKey.currentState!.value;

                          // call create note
                          print(data);
                          var result = createNote(
                            context: context,
                            groupid: groupid,
                            usercreated: firebaseUser,
                            title: data['Title'],
                            description: data['Description'],
                            isEditable: data['isEditable'],
                          );
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

  createCalander() {
    return Container();
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
