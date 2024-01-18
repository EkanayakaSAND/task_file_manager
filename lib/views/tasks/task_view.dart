import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:task_file_manager/extensions/space_exs.dart';
import 'package:task_file_manager/utils/app_strings.dart';
import 'package:task_file_manager/views/home/components/date_time_selection.dart';
import 'package:task_file_manager/views/home/components/rep_textfield.dart';
import 'package:task_file_manager/views/tasks/widgets/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
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
}

// Bottom Side Buttons
Widget _buildBottomSideButtons (){

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Delete Current Task Button
          MaterialButton(
            onPressed: () {
              
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
            onPressed: () {},
            minWidth: 150,
            height: 55,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              AppString.addNewTask,
              style: TextStyle(color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

// Main Task Activity
Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();
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
        RepTextField(controller: titleTaskController),

        10.h,

        // Description
        RepTextField(
          controller: descriptionTaskController,
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
                        dateFormat: 'HH:mm',
                        onConfirm: (dateTime, _) {},
                      ),
                    ));
          },
          title: AppString.timeString,
        ),

        // Date Selection
        DateTimeSelectionWidget(
          ontTap: () {
            DatePicker.showDatePicker(
              context,
              maxDateTime: DateTime(2030, 9, 9),
              minDateTime: DateTime.now(),
              onConfirm: (dateTime, _) {},
            );
          },
          title: AppString.dateString,
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
                text: AppString.addNewTask,
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
