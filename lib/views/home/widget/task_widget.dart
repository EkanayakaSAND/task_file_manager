import 'package:flutter/material.dart';
import 'package:task_file_manager/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 6),
                  blurRadius: 14)
            ]),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              // Check or Uncheck task
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 600),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  // color: Widget.task.isComplted
                  //     ? AppColors.primaryColor
                  //     : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.grey, width: .2)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
    
          // Task title
          title: const Padding(
            padding: EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
    
          // Task description
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.lineThrough),
              ),
    
              // Date of Task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10, top: 10),
                  child: Column(
                    children: [
                      Text(
                        "date",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        " subdate",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
