import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_file_manager/extensions/space_exs.dart';
import 'package:task_file_manager/utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // Icons
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  // Texts
  final List<String> texts = ["Home", "Profile", "Settings", "Details"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.primaryGradientColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_640.png"),
        ),
        8.h,
        Text(
          "SANDE",
          style: textTheme.displayMedium?.copyWith(color: Colors.black),
        ),
        Text(
          "Flutter Dev",
          style: textTheme.displaySmall?.copyWith(color: Colors.black),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      print('${texts[index]} Item tapped.');
                    },
                    child: Container(
                      margin: EdgeInsets.all(3),
                      child: ListTile(
                        leading: Icon(
                          icons[index],
                          size: 30,
                        ),
                        title: Text(texts[index]),
                      ),
                    ),
                  );
                }))
      ]),
    );
  }
}
