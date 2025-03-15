import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/util/constant.dart';
import 'package:food_saver/util/methods.dart';
import 'package:get/route_manager.dart';

class FileWidgetForm extends FormField<String> {
  FileWidgetForm({
    super.key,
    required String title,
    required String? fileName,
    required double widthScreen,
    required double heightScreen,
    required Function(FilePickerResult? file, String? name) onSelectedFile,
    String url = "",
    bool isEnabled = true,
    bool isInfo = false,
    super.restorationId,
    super.onSaved,
  }) : super(
         autovalidateMode: AutovalidateMode.disabled,
         enabled: isEnabled,
         initialValue: fileName,
         validator: (value) {
           if (fileName == null || fileName == "") {
             return "Select a picture";
           } else {
             return null;
           }
         },
         builder: (FormFieldState<String> field) {
           return UnmanagedRestorationScope(
             child: FileWidget(
               title: title,
               filesName: fileName,
               widthScreen: widthScreen,
               heightScreen: heightScreen,
               url: url,
               isEnabled: isEnabled,
               isInfo: isInfo,
               hasError: field.hasError,
               errorText: field.errorText,
               onSelectedFile: onSelectedFile,
             ),
           );
         },
       );

  @override
  FormFieldState<String> createState() => _FileWidgetFormState();
}

class _FileWidgetFormState extends FormFieldState<String> {}

class FileWidget extends StatefulWidget {
  FileWidget({
    super.key,

    required this.title,
    required this.filesName,
    required this.widthScreen,
    required this.heightScreen,
    required this.onSelectedFile,
    this.url = "",
    this.isEnabled = true,
    this.isInfo = false,
    this.hasError = false,
    this.errorText = "",
  });
  String title;
  String? filesName;
  final double widthScreen;
  final double heightScreen;
  final Function(FilePickerResult? file, String? name) onSelectedFile;
  final bool isEnabled;
  final bool isInfo;
  final String url;
  final bool hasError;
  final String? errorText;
  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  bool isLoading = false;
  FilePickerResult? file;

  @override
  Widget build(BuildContext context) {
    double width = widget.widthScreen;
    double height = widget.heightScreen;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width - paddingXLarge - 5,
              child: AutoSizeText(
                widget.title,
                style: TextStyle(fontSize: widget.title == "" ? 0 : 18),
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: paddingSMedium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: DottedBorder(
            color: primary,
            // Couleur de la bordure
            dashPattern: const [8, 4],
            // Longueur des traits et des espaces
            borderType: BorderType.RRect,
            // Type de bordure (RRect, Rect, Circle)
            radius: const Radius.circular(12),
            child: Container(
              width: width,
              height: (height * 0.25) < 100 ? 170 : (height * 0.25) + 30,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.isEnabled ? Colors.green[50] : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 50, color: primary),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    widget.filesName == null
                        ? 'Import your picture'
                        : widget.filesName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: black, fontSize: 22),
                    maxLines: 1,
                  ),
                  SizedBox(height: height * 0.02),
                  isLoading
                      ? loadingUploadFile(size: 30)
                      : ElevatedButton(
                        onPressed:
                            widget.isEnabled
                                ? () async {
                                  await pickedfFile();
                                }
                                : null,
                        child: AutoSizeText(
                          widget.filesName != null ? "Modify" : "Browse",
                          style: const TextStyle(color: primary),
                          maxLines: 1,
                        ),
                      ),
                  SizedBox(height: height * 0.02),
                  widget.hasError
                      ? Text(
                        widget.errorText ?? "",
                        style: const TextStyle(color: red),
                      )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: paddingSMedium),
      ],
    );
  }

  Future<void> pickedfFile() async {
    setState(() {
      isLoading = true;
    });
    file = await pickFile();
    if (file != null) {
      widget.filesName = file!.files.single.name;
      widget.onSelectedFile.call(file, widget.filesName);
    }
    setState(() {
      isLoading = false;
    });
  }
}
