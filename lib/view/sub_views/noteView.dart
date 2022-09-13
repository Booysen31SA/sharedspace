import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notes Section'),
    );
  }
}
