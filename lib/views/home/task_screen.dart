import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:task_file_manager/extensions/space_exs.dart';
import 'package:task_file_manager/main.dart';
import 'package:task_file_manager/utils/app_colors.dart';
import 'package:task_file_manager/utils/app_strings.dart';
import 'package:task_file_manager/utils/constants.dart';
import 'package:task_file_manager/views/home/components/fab.dart';
import 'package:task_file_manager/views/home/components/slider_drawer.dart';
import 'package:task_file_manager/views/home/components/task_screen_app_bar.dart';
import 'package:task_file_manager/views/home/widget/task_widget.dart';
import 'package:task_file_manager/models/task.dart';

class TaskScreenView extends StatefulWidget {
  const TaskScreenView({super.key});

  @override
  State<TaskScreenView> createState() => _TaskScreenViewState();
}

class _TaskScreenViewState extends State<TaskScreenView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  //check value for circle indicator
  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }
  
  //check done task
  int checkDoneTask(List<Task> tasks){
    int i = 0;
    for (Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(), 
      builder:(ctx, Box<Task> box, Widget? child){
        var tasks = box.values.toList();

        tasks.sort((a,b) => a.createdAtDate.compareTo(b.createdAtDate));
        return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Fab(),
        body: SliderDrawer(
          key: drawerKey,
          isDraggable: false,
          animationDuration: 1000,

          slider: CustomDrawer(),
          appBar: TaskScreenAppBar(drawerKey: drawerKey,),
          child: _buildTaskScreenBody(
            textTheme,
            base,
            tasks),
        ));
      });
  }


Widget _buildTaskScreenBody(
  TextTheme textTheme,
  BaseWidget base,
  List<Task> tasks) {

  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: [
        // Custom app bar
        Container(
          margin: const EdgeInsets.only(
            top: 60,
          ),
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Progress Indicator
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),

              // space
              25.w,

              // Top Level Task infomation
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.mainTitle,
                    style: textTheme.displayLarge,
                  ),
                  3.h,
                  Text(
                    "${checkDoneTask(tasks)} of ${tasks.length} tasks",
                    style: textTheme.titleMedium,
                  )
                ],
              )
            ],
          ),
        ),

        // Divider
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Divider(
            thickness: 2,
            indent: 100,
          ),
        ),

        // Tasks
        SizedBox(
            width: double.infinity,
            height: 467,
            child: tasks.isNotEmpty

                // When task list is not empty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      // get single task for showing in list
                      var task = tasks[index];
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            base.dataStore.deleteTask(task: task);
                          },
                          background: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ),
                                8.w,
                                const Text(
                                  AppString.deletedTask,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ]),
                          key: Key(task.id),
                          child: TaskWidget(
                            task:task
                            ),
                      );
                    })

                // When task list is empty
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie Animation
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(lottieURL,
                              animate: tasks.isNotEmpty ? false : true),
                        ),
                      ),

                      // Sub text
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppString.doneAllTask,
                        ),
                      )
                    ],
                  ))
      ],
    ),
  );
}
}