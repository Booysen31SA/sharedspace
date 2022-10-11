import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/components/noteCard.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/services/functions.dart';

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
                        return NoteCard(
                          title: details['title'],
                          createdBy: details['usercreated'],
                          created: details['timecreated'],
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
}
