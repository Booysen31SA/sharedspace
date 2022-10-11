import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/components/noteCard.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NoteView extends StatefulWidget {
  final String groupid;
  const NoteView({Key? key, required this.groupid}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    // change to use slideup panel to see if it could work
    // https://pub.dev/packages/sliding_up_panel
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: notesHeadingStyle,
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.6,
          //   child: const Divider(color: primaryClr, height: 10.0, thickness: 1),
          // )
          const SizedBox(
            height: 20,
          ),

          SizedBox(
            child: StreamBuilder(
              stream: getGroupNotes(widget.groupid),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data.size == 0) {
                    return const Center(
                      child: Text('No notes available'),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map<Widget>(
                      (details) {
                        return GestureDetector(
                          onTap: () {
                            popupModal();
                          },
                          child: NoteCard(
                            title: details['title'],
                            createdBy: details['usercreated'],
                            created: details['timecreated'],
                          ),
                        );
                      },
                    ).toList(),
                  );
                }

                return const DataLoading();
              },
            ),
          )
        ],
      ),
    );
  }

  popupModal() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            // parent container
            return Container(
              decoration: const BoxDecoration(
                //color: Colors.blue[500],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ), // add this because it covers the parent
              ),
              // child make it scrollable if it gets to long
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // this is for icon that we created that shows as handle
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ), // add this because it covers the parent
                      ),
                      child: const SizedBox(
                        height: 5,
                        width: 100,
                        // child: Icon(
                        //   Icons.minimize_rounded,
                        //   color: Colors.grey,
                        //   size: 100,
                        // ),
                      ),
                    ),

                    // all the data that we want to show, gonna be a stream builder
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      controller: controller, // set this too
                      itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
                    ),

                    // end of this complicated thing hope it made sense :)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
