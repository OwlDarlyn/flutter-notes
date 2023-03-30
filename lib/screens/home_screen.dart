import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../screens/note_screen.dart';
import '../providers/note_collection.dart';
import '../widgets/date_picker_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var uuid = new Uuid();
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    DatePickerRow _datePickerRow = DatePickerRow(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.black,
      selectedTextColor: Colors.white,
      onDateChange: (date) {
        setState(() {
          var _selectedValue = date;
        });
      },
    );

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hi, Darlyn!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.notifications,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_datePickerRow],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIdicator(color: Colors.black87, radius: 4),
                tabs: const [
                  Tab(text: 'Work Projects'),
                  Tab(text: 'Sports'),
                  Tab(text: 'Hobby'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                Tab(text: 'You'),
                Tab(text: 'Bye'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'To-Do Tasks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Consumer<NoteCollection>(
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
            ),
          ),
        ],
      ),
    );
  }
}

class CircleTabIdicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIdicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffcet = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffcet, radius, _paint);
  }
}

  // Widget _buildNotesList() {
  //   return Consumer<NoteCollection>(
  //     builder: (context, notes, chils) {
  //       var allNotes = notes.allNotes;

  //       if (allNotes.length == 0) {
  //         return Center(
  //           child: Text('No notes is here'),
  //         );
  //       }
  //       return ListView.builder(
  //         itemBuilder: (context, index) {
  //           var note = allNotes[index];

  //           return Dismissible(
  //             key: Key(note.id),
  //             onDismissed: (direction) {
  //               Provider.of<NoteCollection>(context, listen: false)
  //                   .deleteNote(note.id);
  //             },
  //             background: Container(color: Colors.red),
  //             child: ListTile(
  //               title: Text(note.noteBody),
  //               onTap: () {
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (context) => NoteScreen(note: note),
  //                   ),
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //         itemCount: allNotes.length,
  //       );
  //     },
  //   );
  // }

