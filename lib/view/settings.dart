import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/NameTextBoxGlobal.dart';
import 'package:sharedspace/components/colorPicker.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';
import 'package:sharedspace/models/sharedspacegroup.dart';
import 'package:sharedspace/models/usermodel.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:sharedspace/services/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sharedspace/util/convertStringToColor.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  var isDarkMode = Get.isDarkMode;
  //Form Key for Group settings
  final _groupSettingFormKey = GlobalKey<FormBuilderState>();
  final _groupSettingGroupNameFieldKey = GlobalKey<FormBuilderState>();
  final _groupSettingGroupIDFieldKey = GlobalKey<FormBuilderState>();
  final _groupSettingUserUidFieldKey = GlobalKey<FormBuilderState>();
  final _groupSettingDateCreatedFieldKey = GlobalKey<FormBuilderState>();

  //Form Key for Profile
  final _profileGroupSettingFormKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingGroupIDFieldKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingUidFieldKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingEmailFieldKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingFirstNameFieldKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingSurnameFieldKey = GlobalKey<FormBuilderState>();
  final _profileGroupSettingDateCreatedFieldKey = GlobalKey<FormBuilderState>();

//general
  var __groupSettingGroupColorFieldKey;
  bool isReloading = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    //print(arguments['isMain']);
    //'groupid': arguments['groupid']

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
          arguments['isMain']
              ? 'Settings'
              : arguments['isprofile']
                  ? 'Profile Settings'
                  : 'Group Settings',
          style: const TextStyle(
            fontSize: 26,
            color: primaryClr,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              arguments['isMain']
                  ? mainSettings(firebaseUser)
                  : arguments['isprofile']
                      ? profileGroupSettings(firebaseUser)
                      : groupSettings(firebaseUser, arguments['groupid']),
            ],
          ),
        ),
      ),
    );
  }

  userDetails(firebaseUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('uuid',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text(
              firebaseUser == null
                  ? 'User is not logged in'
                  : firebaseUser.uid.toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Email',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text(
                firebaseUser == null
                    ? 'User is not logged in'
                    : firebaseUser.email.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ))
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  mainSettings(firebaseUser) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.08,
            child: FormBuilderSwitch(
              //key: _creationNoteIsEditableFieldKey,
              initialValue: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value!;
                  ThemeService().switchTheme();
                });
              },
              decoration: inputDecoration(
                isfocusBorder: true,
              ),
              name: 'Dark Mode',
              title: Text(
                'Dark mode',
                style: settingSizes,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  userDetails(firebaseUser),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red)),
                    child: MaterialButton(
                      onPressed: () async {
                        await context
                            .read<FlutterFireAuthService>()
                            .signOut(context: context);

                        Navigator.popAndPushNamed(context, '/');
                      },
                      child: const Text(
                        'LOG OUT',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  groupSettings(firebaseUser, groupid) {
    // Group Color
    // Group admin read only
    // date created read only
    // users in group do last
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        bottom: 15,
      ),
      child: FutureBuilder(
        future: getSharedSpaceDetailsByGroupId(groupid),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data as SharedSpaceGroup;
              if (!isReloading) {
                __groupSettingGroupColorFieldKey =
                    stringToColor(data.groupcolor.toString());
              }
              return FormBuilder(
                key: _groupSettingFormKey,
                child: Column(
                  children: <Widget>[
                    // Group id
                    nameTextBox(
                      context: context,
                      text: 'Group ID',
                      key: _groupSettingGroupIDFieldKey,
                      data: data.groupid.toString(),
                      readOnly: true,
                      isHidden: true,
                    ),

                    // Group Name
                    nameTextBox(
                      context: context,
                      text: 'Group Name',
                      key: _groupSettingGroupNameFieldKey,
                      data: data.groupname.toString(),
                      readOnly: false,
                      isHidden: false,
                    ),

                    // Created User
                    nameTextBox(
                      context: context,
                      text: 'Created by',
                      key: _groupSettingUserUidFieldKey,
                      data: data.useruid,
                      readOnly: true,
                      isHidden: false,
                    ),

                    // Date Created
                    nameTextBox(
                      context: context,
                      text: 'Date Created',
                      key: _groupSettingDateCreatedFieldKey,
                      data: data.datecreated.toString(),
                      readOnly: true,
                      isHidden: true,
                    ),

                    // Colour Picker
                    colorPickerContainer(
                      context: context,
                      key: __groupSettingGroupColorFieldKey,
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
                                if (!isLoading) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final validateSuccess = _groupSettingFormKey
                                      .currentState!
                                      .saveAndValidate();

                                  if (validateSuccess) {
                                    var fielddata = _groupSettingFormKey
                                        .currentState!.value;

                                    SharedSpaceGroup sharedGroup =
                                        SharedSpaceGroup(
                                      groupid: data.groupid.toString(),
                                      groupname: fielddata['Group Name'],
                                      groupcolor:
                                          __groupSettingGroupColorFieldKey
                                              .toString(),
                                      useruid: data.useruid,
                                      datecreated: data.datecreated.toString(),
                                    );

                                    var result = await updateGroupSetting(
                                        id: data.updateid, data: sharedGroup);

                                    if (!result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Failed, Please try again')),
                                      );
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }
                                  }
                                }
                              },
                              child: const Text(
                                'Update Group',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    )
                  ],
                ),
              );

              //return Text(data.groupname.toString());
            }
          }
          return const DataLoading();
        }),
      ),
    );
  }

  profileGroupSettings(firebaseUser) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      child: FutureBuilder(
        future: getUserDetailsFuture(firebaseUser),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView(
                shrinkWrap: true,
                children: snapshot.data.map<Widget>((document) {
                  if (!isReloading) {
                    __groupSettingGroupColorFieldKey =
                        stringToColor(document.color.toString());
                  }
                  return FormBuilder(
                    key: _profileGroupSettingFormKey,
                    child: Column(
                      children: <Widget>[
                        // Group id
                        nameTextBox(
                          context: context,
                          text: 'Group ID',
                          key: _profileGroupSettingGroupIDFieldKey,
                          data: document.groupid.toString(),
                          readOnly: true,
                          isHidden: true,
                        ),

                        // uid
                        nameTextBox(
                          context: context,
                          text: 'Unique ID',
                          key: _profileGroupSettingUidFieldKey,
                          data: document.uid.toString(),
                          readOnly: true,
                          isHidden: true,
                        ),

                        // email
                        nameTextBox(
                          context: context,
                          text: 'Email',
                          key: _profileGroupSettingEmailFieldKey,
                          data: document.email.toString(),
                          readOnly: true,
                          isHidden: false,
                        ),

                        // Firstname
                        nameTextBox(
                          context: context,
                          text: 'First Name',
                          key: _profileGroupSettingFirstNameFieldKey,
                          data: document.firstname.toString(),
                          isHidden: false,
                        ),

                        // Surname
                        nameTextBox(
                          context: context,
                          text: 'Surname',
                          key: _profileGroupSettingSurnameFieldKey,
                          data: document.surname.toString(),
                          isHidden: false,
                        ),

                        // Date Created
                        nameTextBox(
                          context: context,
                          text: 'Date Created',
                          key: _profileGroupSettingDateCreatedFieldKey,
                          data: document.dateCreated.toString(),
                          readOnly: true,
                          isHidden: false,
                        ),

                        // Colour Picker
                        colorPickerContainer(
                          context: context,
                          key: __groupSettingGroupColorFieldKey,
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
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              final validateSuccess =
                                  _profileGroupSettingFormKey.currentState!
                                      .saveAndValidate();

                              if (validateSuccess) {
                                var fielddata = _profileGroupSettingFormKey
                                    .currentState!.value;

                                UserModel userModel = UserModel(
                                  uid: document.uid.toString(),
                                  firstname: fielddata['First Name'],
                                  surname: fielddata['Surname'],
                                  dateCreated: document.dateCreated.toString(),
                                  color: __groupSettingGroupColorFieldKey
                                      .toString(),
                                  groupid: document.groupid.toString(),
                                  email: document.email.toString(),
                                );

                                var result = await updateProfileSetting(
                                    id: document.id, data: userModel);

                                if (!result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed, Please try again'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Sucess!')),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Update Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return const DataLoading();
        },
      ),
    );
  }

  nameTextBox({context, text, key, data, readOnly, isHidden}) {
    return Visibility(
      visible: !isHidden,
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: settingSizes,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 0.5,
              child: FormBuilderTextField(
                readOnly: readOnly ?? false,
                key: key,
                name: text,
                initialValue: data,
                decoration: inputDecoration(
                  borderColor: primaryClr,
                  isfocusBorder: true,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeColorOnTap() {
    setState(() {
      __groupSettingGroupColorFieldKey = __groupSettingGroupColorFieldKey;
    });
    Navigator.of(context).pop();
  }

  void changeColor(Color color) {
    isReloading = true;
    setState(() => {__groupSettingGroupColorFieldKey = color});
  }
}
