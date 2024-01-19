import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:task_file_manager/extensions/space_exs.dart';
import 'package:task_file_manager/main.dart';
import 'package:task_file_manager/utils/app_strings.dart';
import 'package:task_file_manager/utils/constants.dart';
import 'package:task_file_manager/views/home/components/date_time_selection.dart';
import 'package:task_file_manager/views/home/components/rep_textfield.dart';
import 'package:task_file_manager/views/tasks/widgets/task_view_app_bar.dart';
import 'package:task_file_manager/models/task.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  // Show seleted time as String
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  // Show selected Date as String
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date!).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  //main functions for creating and updating tasks
  dynamic isTaskAlreadyExistsUpdateOtherwiseCreate() {
    if (widget.titleTaskController?.text != null &&
        widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subtitle;

        widget.task?.save();

       Navigator.pop(context); 
      } catch (e) {
        updateTaskWarning(context);
      }
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
            title: title,
            subtitle: subtitle,
            createdAtDate: date,
            createdAtTime: time);
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

  //delete tasks
  dynamic deleteTask(){
    return widget.task?.delete();
  }

  // if any task already exists return true otherwise false
  bool isTaskAlreadyExists() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // App bar
        appBar: TaskViewAppBar(),

        // Body
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Side Texts
                _buildTopSideTexts(textTheme),

                // Main Task View Activity
                _buildMainTaskViewActivity(textTheme, context),

                // Bottom Side Buttons
                _buildBottomSideButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Side Buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExists()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExists()
              ? Container()
              :
              // Delete Current Task Button
              MaterialButton(
                  onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  },
                  minWidth: 150,
                  height: 55,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      5.w,
                      const Text(
                        AppString.deleteTask,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),

          //Add of Update Task
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistsUpdateOtherwiseCreate();
            },
            minWidth: 150,
            height: 55,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              isTaskAlreadyExists()
              ?AppString.addTask
              :AppString.updateTask,
              style: TextStyle(color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

// Main Task Activity
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 430,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // Task Title
          RepTextField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          // Description
          RepTextField(
            controller: widget.descriptionTaskController,
            onChanged: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
            onFieldSubmitted: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
            isForDescription: true,
          ),

          // Time Selection
          DateTimeSelectionWidget(
            ontTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 280,
                        child: TimePickerWidget(
                          onChange: (_, __) {},
                          initDateTime: showDateAsDateTime(time),
                          dateFormat: 'HH:mm',
                          onConfirm: (selectedTime, _) {
                            setState(() {
                              if (widget.task?.createdAtTime == null) {
                                time = selectedTime;
                              } else {
                                widget.task!.createdAtTime = selectedTime;
                              }
                            });
                          },
                        ),
                      ));
            },
            title: "Time",
            time: showTime(time),
          ),

          // Date Selection
          DateTimeSelectionWidget(
            ontTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 9, 9),
                minDateTime: DateTime.now(),
                initialDateTime: showDateAsDateTime(date),
                onConfirm: (selectedDate, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = selectedDate;
                    } else {
                      widget.task!.createdAtDate = selectedDate;
                    }
                  });
                },
              );
            },
            title: AppString.dateString,
            isTime: true,
            time: showDate(date),
          )
        ],
      ),
    );
  }

// Top Side Texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
              text: TextSpan(
                  text: isTaskAlreadyExists()
                      ? AppString.addNewTask
                      : AppString.updateCurrentTask,
                  style: textTheme.titleLarge,
                  children: const [
                TextSpan(
                    text: AppString.taskStrnig,
                    style: TextStyle(fontWeight: FontWeight.w400))
              ])),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
