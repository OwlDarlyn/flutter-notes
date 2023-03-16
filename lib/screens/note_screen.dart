import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/note_collection.dart';

class NoteScreen extends StatefulWidget {
  final Note _note;
  const NoteScreen({note}) : _note = note;

  @override
  State<NoteScreen> createState() => _NoteScreenState(note: _note);
}

class _NoteScreenState extends State<NoteScreen> {
  final Note _note;
  _NoteScreenState({note}) : _note = note;

  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bodyController.text = _note.body;

    bodyController.addListener(() {
      Provider.of<NoteCollection>(context, listen: false).updateNote(
        _note.id,
        bodyController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            return Text(notes.getNote(_note.id).noteBody);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Start writing your note here..',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Consumer<NoteCollection>(builder: (contex, notes, child) {
                Note note = notes.getNote(_note.id);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${note.characters} characters',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${note.words} words',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              }),
              decoration: BoxDecoration(color: Colors.teal),
            ),
          )
        ],
      ),
    );
  }
}
