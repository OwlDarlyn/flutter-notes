import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NoteCollection extends ChangeNotifier {
  final List<Note> _notes = [
    // Note(id: '1', body: 'First note', title: '1 test note'),
    // Note(id: '2', body: 'Second note', title: '2 test note'),
  ];

  get count {
    return _notes.length;
  }

  get allNotes => _notes;

  Note getNote(String id) {
    return _notes.where((note) => note.id == id).first;
  }

  void addNote(Note note) {
    _notes.add(note);

    notifyListeners();
  }

  void updateNote(String id, String body) {
    var currentNote = _notes.where((note) => note.id == id).first;

    currentNote.body = body;

    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);

    notifyListeners();
  }
}
