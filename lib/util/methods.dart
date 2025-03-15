import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/util/constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      text: TextSpan(text: body, style: const TextStyle(color: black)),
    ),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: isError ? const Icon(Icons.error) : const Icon(Icons.check_box),
    showProgressBar: false,
  );
}

Widget loadingUploadFile({double size=50}) {
  return Center(
    child: LoadingAnimationWidget.horizontalRotatingDots(
      color: primary,
      size: size,
    ),
  );
}

Future<FilePickerResult?> pickFile() async {
  try {
    // Ouvre le sélecteur de fichiers pour tout type de document
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "png",
        "jpg",
        "jpeg",
      ], // Autoriser tous les types de fichiers
    );
    if (result != null) {
      // Récupérer le nom ou chemin du fichier sélectionné
      return result;
    } else {
      log('Aucun fichier sélectionné.');
      return null;
    }
  } catch (e) {
    log('Erreur lors de la sélection du fichier : $e');
    return null;
  }
}
