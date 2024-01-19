import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:task_file_manager/utils/constants.dart';
import 'package:task_file_manager/main.dart';

class TaskScreenAppBar extends StatefulWidget {
  const TaskScreenAppBar({super.key, required this.drawerKey});

  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<TaskScreenAppBar> createState() => _TaskScreenAppBarState();
}

class _TaskScreenAppBarState extends State<TaskScreenAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 30000));
    super.initState();
  }

  @override
  void dispose() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 30000));
    super.dispose();
  }

  // On toggle
  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animationController.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        animationController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu Icon
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: onDrawerToggle,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: animationController,
                      size: 40,
                    ))),

            // Trash icon
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.trash_fill,
                  size: 40,
                ),
                onPressed: () {
                  // Remove all tasks from database
                  //deleteAllTask(context);
                  base.isEmpty
                    ?noTaskWarning(context)
                    :deleteAllTask(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
