import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:task_file_manager/utils/app_strings.dart';
import 'package:task_file_manager/main.dart';

String lottieURL = 'assets/lottie/Animation.json';

// Empty title or description warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppString.oopsMsg,
      subMsg: 'You must fill all fields!',
      corner: 20,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

// Nothing entered warning
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppString.oopsMsg,
      subMsg: 'You must edit the task then try to update it!',
      corner: 20,
      duration: 4000,
      padding: const EdgeInsets.all(20));
}

// No task warning for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppString.oopsMsg,
      message: 'There is no Task for Delete!',
      buttonText: "Okay", onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

// Delete all tasks from DB warning
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      title: AppString.areYouSure,
      message: 'Do you really want to delete all tasks?',
      confirmButtonText: "Yes",
      cancelButtonText: "No", onTapConfirm: () {
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error,
  barrierDismissible: false);
}
