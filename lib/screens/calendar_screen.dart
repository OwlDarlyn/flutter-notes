import 'package:flutter/material.dart';

import '../widgets/bottom_nav_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/task_list_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          CalendarWidget(),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: const [
                          TaskList(
                              title: 'Task 1',
                              description: 'This is task 1 description',
                              iconImg: Icons.check_box,
                              iconColor: Colors.black),
                          TaskList(
                              title: 'Task 2',
                              description: 'This is task 2 description',
                              iconImg: Icons.check_box,
                              iconColor: Colors.black),
                          TaskList(
                              title: 'Task 3',
                              description: 'This is task 3 description',
                              iconImg: Icons.check_box,
                              iconColor: Colors.black),
                          TaskList(
                              title: 'Task 4',
                              description: 'This is task 4 description',
                              iconImg: Icons.check_box,
                              iconColor: Colors.black),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
