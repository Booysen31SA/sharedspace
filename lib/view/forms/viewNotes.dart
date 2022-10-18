import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sharedspace/components/NameTextBoxGlobal.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ViewNotes extends StatefulWidget {
  const ViewNotes({
    super.key,
  });

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

// Reading of Note
final _viewNoteFormKey = GlobalKey<FormBuilderState>();
final _viewNoteTitleFieldKey = GlobalKey<FormBuilderState>();
final _viewNoteIsEditableFieldKey = GlobalKey<FormBuilderState>();

// general
quill.QuillController _controller = quill.QuillController.basic();

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
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
          arguments['noteTitle'],
          style: const TextStyle(
            fontSize: 26,
            color: primaryClr,
          ),
        ),
        suffixIcon: const Icon(Icons.check, color: primaryClr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
            stream: getNote(arguments['notekey']),
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
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    left: 15,
                  ),
                  height: MediaQuery.of(context).size.height -
                      (Header(appBar: AppBar()).preferredSize.height) -
                      MediaQuery.of(context).padding.top,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: snapshot.data.docs.map<Widget>((note) {
                      var json = jsonDecode(note['description']);
                      _controller = quill.QuillController(
                        document: quill.Document.fromJson(json),
                        selection: const TextSelection.collapsed(offset: 0),
                      );
                      return FormBuilder(
                        key: _viewNoteFormKey,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              (Header(appBar: AppBar()).preferredSize.height) -
                              MediaQuery.of(context).padding.top,
                          child: Column(
                            children: [
                              nameTextBoxGlobal(
                                context: context,
                                text: 'Title',
                                key: _viewNoteTitleFieldKey,
                                data: note['title'],
                                readOnly: false,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 15,
                                ),
                                child: quill.QuillToolbar.basic(
                                  controller: _controller,
                                  multiRowsDisplay: false,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryClr),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: quill.QuillEditor.basic(
                                    controller: _controller,
                                    readOnly: false, // true for view only mode
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                  // right: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   'Allow others to edit',
                                    //   style: settingSizes,
                                    // ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.17,
                                      child: FormBuilderSwitch(
                                        initialValue: note['isEditable'],
                                        key: _viewNoteIsEditableFieldKey,
                                        decoration: inputDecoration(
                                          borderColor: primaryClr,
                                          isfocusBorder: true,
                                        ),
                                        name: 'isEditable',
                                        title:
                                            const Text('Allow others to edit'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return DataLoading();
            },
          ),
        ),
      ),
    );
  }
}
