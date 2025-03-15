import 'package:flutter/material.dart';
import 'package:food_saver/util/constant.dart';
import 'package:toastification/toastification.dart';

void showSuccessNotification(String message) {
  showNotification(title: "Message", body: message, isError: false);
}

void showErrorNotification(String message) {
  showNotification(title: "Erreur", body: message);
}

showNotification({String title = "", String body = "", bool isError = true}) {
  toastification.show(
    type: isError ? ToastificationType.error : ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title),
    description: RichText(
        text: TextSpan(text: body, style: const TextStyle(color: black))),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: isError ? const Icon(Icons.error) : const Icon(Icons.check_box),
    showProgressBar: false,
  );
}