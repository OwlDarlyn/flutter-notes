class Note {
  String id;
  String body;
  // String title;

  static const String defaultName = 'New note';

  Note({
    this.id = '',
    this.body = '',
    // this.title = 'New Title',
  });

  String get noteBody {
    return body.isNotEmpty ? body : Note.defaultName;
  }

  int get characters {
    return body.length;
  }

  int get words {
    if (body.isEmpty) {
      return 0;
    }
    return body.split(' ').length;
  }
}
