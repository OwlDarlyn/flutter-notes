import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/note_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';
import '../providers/note_collection.dart';

class HomeScreen extends StatelessWidget {
  var uuid = new Uuid();
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(builder: (context, notes, child) {
          if (notes.count == 0) {
            return Text('Notes');
          }
          return Text('Notes (${notes.count})');
        }),
      ),
      body: _buildNotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Note note = Note(
            id: uuid.v4(),
          );

          Provider.of<NoteCollection>(context, listen: false).addNote(note);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(note: note),
            ),
          );

          // debugPrint(note.id.toString());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNotesList() {
    return Consumer<NoteCollection>(
      builder: (context, notes, chils) {
        var allNotes = notes.allNotes;

        if (allNotes.length == 0) {
          return Center(
            child: Text('No notes is here'),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            var note = allNotes[index];

            return Dismissible(
              key: Key(note.id),
              onDismissed: (direction) {
                Provider.of<NoteCollection>(context, listen: false)
                    .deleteNote(note.id);
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(note.noteBody),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(note: note),
                    ),
                  );
                },
              ),
            );
          },
          itemCount: allNotes.length,
        );
      },
    );
  }
}
