import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:food_saver/util/methods.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A generic class for handling CRUD (Create, Read, Update, Delete) operations
/// with Supabase. It simplifies interactions with a specified table.
///
/// Example usage:
/// ```dart
/// final userCRUD = CRUD(table: 'users');
/// ```
class CRUD {
  /// The table name in the database.
  final String table;

  /// A SupabaseQueryBuilder instance for interacting with the specified table.
  late final SupabaseQueryBuilder database;

  /// Constructor to initialize the CRUD instance with a table name.
  ///
  /// Example:
  /// ```dart
  /// final userCRUD = CRUD(table: 'users');
  /// ```
  CRUD({required this.table}) {
    database = Supabase.instance.client.from(table);
  }

  /// Inserts a new record into the table.
  ///
  /// [data] is a map containing the values for the new record.
  ///
  /// Example:
  /// ```dart
  /// await userCRUD.create({'name': 'John', 'email': 'john@example.com'});
  /// ```
  Future<void> create(Map<String, dynamic> data) async {
    try {
      final response = await database.insert(data);
      if (response != null) {
        print('Data created successfully: $response');
      } else {
        print('Error creating data: $response');
      }
    } catch (e) {
      print('Exception during create: $e');
      rethrow;
    }
  }

  /// Uploads an image to a specified Supabase storage bucket.
  ///
  /// This function uploads an image file to a Supabase storage bucket and generates
  /// a unique path based on the current timestamp.
  ///
  /// [bucketName] is the name of the storage bucket where the image will be uploaded.
  /// [imageFile] is the image file to upload. If null, the function will exit early.
  ///
  /// Example usage:
  /// ```dart
  /// File? image = File('/path/to/image.jpg'); // Replace with your image file.
  /// await uploadImage('my_bucket', image);
  /// ```
  Future<void> uploadImage(String bucketName, File? imageFile) async {
    // Check if an image file is provided
    if (imageFile == null) {
      print(
        'Error UploadImage : No image selected. Please select an image to upload.',
      );
      return;
    }

    try {
      // Generate a unique file name based on the current timestamp
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
      final path = 'uploads/$fileName';
      // Perform the upload
      final response = await Supabase.instance.client.storage
          .from(bucketName)
          .upload(path, imageFile);

      // Log success
      print('Image uploaded successfully! File path: $path');
      print('Storage response: $response');
    } catch (e) {
      // Handle and log any errors
      print('Error uploading image: $e');
    }
  }

  /// Retrieves data from the table as a stream.
  ///
  /// [toElement] is a function to transform each row (a map) into a specific object type.
  ///
  /// Example:
  /// ```dart
  /// final stream = userCRUD.readStream<User>(toElement: User.fromMap);
  /// stream.listen((users) => print(users));
  /// ```
  Stream<List<T>> readStream<T>({
    required T Function(Map<String, dynamic>) toElement,
  }) {
    return database
        .stream(primaryKey: ['id'])
        .map((data) => data.map(toElement).toList());
  }

  Stream<T?> specificReadStream<T>({
    required T Function(Map<String, dynamic>) toElement,
    required String id,
  }) {
    return database.stream(primaryKey: ['id']).map((data) {
      final matchingElement = data.firstWhere(
        (element) => element['id'].toString() == id,
      );
      return toElement(matchingElement);
    });
  }

  /// Lit un flux pour un élément spécifique en fonction d'un champ et d'une valeur.
  Stream<T?> specificStream<T>({
    required T Function(Map<String, dynamic>) toElement,
    required String field, // Champ à vérifier
    required dynamic value, // Valeur à rechercher
  }) {
    return database.stream(primaryKey: ['id']).map((data) {
      try {
        final matchingElement = data.firstWhere(
          (element) =>
              element[field].toString() ==
              value
                  .toString(), // Retourne null si aucun élément correspondant n'est trouvé
        );
        return toElement(matchingElement);
      } catch (e) {
        print('Erreur lors de la recherche d\'un élément spécifique : $e');
        return null;
      }
    });
  }

  /// Retrieves all data from the table as a one-time read.
  ///
  /// Example:
  /// ```dart
  /// await userCRUD.readSimple();
  /// ```
  Future<void> readSimple() async {
    try {
      final data = await database.select();
      print('Fetched data: $data');
    } catch (e) {
      print('Read simple Error: $e');
      rethrow;
    }
  }

  Future<PostgrestMap> readRowByPhoneNumber(String phoneNumber) async {
    try {
      if (phoneNumber[0] == "0") {
        phoneNumber = phoneNumber.replaceFirst(RegExp(r'0'), "+243");
      }
      final data = await database.select().eq("phone_number", phoneNumber);
      return data.isEmpty ? {} : data.first;
    } catch (e) {
      print('Read phoneNumber Error: $e');
      return {};
    }
  }

  Future<PostgrestMap> readRowByID(String ID) async {
    try {
      final data = await database.select().eq("UID", ID);
      return data.isEmpty ? {} : data.first;
    } catch (e) {
      print('Read UID Error: $e');
      return {};
    }
  }

  Future<PostgrestMap> readRowByMatricule(String matricule) async {
    try {
      final data = await database.select().eq("matricule", matricule);
      return data.isEmpty ? {} : data.first;
    } catch (e) {
      print('Read Matricule Error: $e');
      return {};
    }
  }

  Future<PostgrestMap> readRowByEmail(String email) async {
    try {
      final data = await database.select().eq("email", email);
      return data.isEmpty ? {} : data.first;
    } catch (e) {
      print('Read Email Error: $e');
      return {};
    }
  }

  Future<bool> isPhoneNumberAndMatriculeExist(
    String phoneNumber,
    String matricule,
  ) async {
    try {
      final dataPhoneNumber = await database.select().eq(
        "phone_number",
        phoneNumber,
      );
      final dataEmail = await database.select().eq("matricule", matricule);
      if (dataPhoneNumber.isEmpty && dataEmail.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print('Is Phone Number and Matricule exist Error: $e');
      return false;
    }
  }

  /// Updates a record in the table based on its [id].
  ///
  /// [id] is the primary key of the record to update.
  /// [newValue] is a map containing the updated values.
  ///
  /// Example:
  /// ```dart
  /// await userCRUD.updateData(1, {'name': 'Jane'});
  /// ```
  Future<void> updateByID(int id, Map<String, dynamic> newValue) async {
    try {
      final response = await database.update(newValue).eq('id', id);
      if (response == null) {
        print('Data updated successfully: $response');
      } else {
        print('Error updating data: ${response!.message}');
      }
    } catch (e) {
      print('Exception during updateByID: $e');
      rethrow;
    }
  }

  Future<void> updateByPhoneNumber(
    String phoneNumber,
    Map<String, dynamic> newValue,
  ) async {
    try {
      final response = await database
          .update(newValue)
          .eq('phone_number', phoneNumber);
      if (response == null) {
        print('Data updated successfully: $response');
      } else {
        print('Error updating data: ${response!.message}');
      }
    } catch (e) {
      print('Exception during updateByPhoneNumber: $e');
      rethrow;
    }
  }

  /// Deletes a record from the table based on its [id].
  ///
  /// Example:
  /// ```dart
  /// await userCRUD.deleteData(1);
  /// ```
  Future<void> delete(int? id) async {
    try {
      final response = await database.delete().eq('id', id as Object);
      if (response == null) {
        showSuccessNotification('Le procès-verbal a été supprimé avec succès.');
        print('Data deleted successfully.');
      } else {
        showNotification(
          title: "Erreur",
          body: "Une erreur se produite lors de la suppression",
        );
        print('Error deleting data: ${response!.message}');
      }
    } catch (e) {
      showNotification(
        title: "Erreur",
        body: "Une erreur se produite lors de la suppression.",
      );
      print('Exception during delete: $e');
      rethrow;
    }
  }

  /// Uploads a PDF file to Supabase storage and returns the public URL.
  ///
  /// This function allows the user to select a PDF file, upload it to a specified
  /// Supabase storage bucket, and get the file's public URL.
  ///
  /// [bucketName] : The name of the storage bucket.
  ///
  /// Returns the public URL of the uploaded file as a string.
  Future<String?> uploadFile(
    String bucketName,
    String idDocument,
    String document,
    FilePickerResult? result,
  ) async {
    try {
      // Vérifiez si un fichier est sélectionné
      if (result == null) {
        print(
          'Erreur lors de la sauvegarde du fichier : Aucun fichier sélectionné.',
        );
        return null;
      }
      PlatformFile platformFile = result.files.single;
      // Créez l'objet fichier
      Uint8List? fileBytes = await _getFileBytes(platformFile);
      if (fileBytes == null) {
        print(
          "Erreur lors de la sauvegarde du fichier: Le fichier sélectionné n'existe pas.",
        );
        return null;
      }

      String fileName = result.files.single.name;
      String filePath = '$idDocument/$document/$fileName';

      // Upload le fichier vers Supabase
      await _uploadToSupabase(
        bucketName,
        filePath,
        fileBytes,
        platformFile.name,
      );

      // Obtenir l'URL publique du fichier
      final publicUrl = Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(filePath);

      if (publicUrl.isEmpty) {
        showNotification(
          title: "Erreur",
          body: "Impossible de récupérer l'URL publique.",
        );
        return null;
      }

      return publicUrl;
    } on StorageException catch (e) {
      showNotification(
        title: "Erreur",
        body: "La base de données à un problème ${e.message}",
      );
      return null;
    } on FileSystemException catch (e) {
      showNotification(
        title: "Erreur",
        body: "Erreur système de fichier : ${e.message}",
      );
      return null;
    } catch (e) {
      showNotification(title: "Erreur", body: "Une erreur inattendue : $e");
      return null;
    }
  }

  Future<void> removeFile({
    required String bucketName,
    required String? oldFilePath,
  }) async {
    if (oldFilePath == null || oldFilePath.isEmpty) {
      throw ArgumentError('Le chemin du fichier ne peut pas être nul ou vide.');
    }

    try {
      await Supabase.instance.client.storage.from(bucketName).remove([
        oldFilePath,
      ]);
    } catch (e) {
      print('Erreur: $e');
      rethrow; // Relancer l'exception pour la gestion en amont
    }
  }

  /// Fonction pour remplacer un fichier dans Supabase
  Future<String?> replaceFileInSupabase({
    required String bucketName,
    required String? oldFilePath,
    required String idDocument,
    required String document,
    required dynamic result,
  }) async {
    try {
      // Étape 1 : Supprimer l'ancien fichier
      removeFile(bucketName: bucketName, oldFilePath: oldFilePath);

      // Étape 2 : Téléverser le nouveau fichier
      PlatformFile platformFile = result!.files.single;
      // Créez l'objet fichier
      Uint8List? fileBytes = await _getFileBytes(platformFile);
      if (fileBytes == null) {
        print(
          "Erreur lors de la sauvegarde du fichier: Le fichier sélectionné n'existe pas.",
        );
        return null;
      }
      String fileName = result.files.single.name;
      String filePath = '$idDocument/$document/$fileName';
      await _uploadToSupabase(
        bucketName,
        filePath,
        fileBytes,
        platformFile.name,
      );
      // Obtenir l'URL publique du fichier
      final publicUrl = Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(filePath);

      if (publicUrl.isEmpty) {
        showNotification(
          title: "Erreur",
          body: "Impossible de récupérer l'URL publique.",
        );
        return null;
      }

      return publicUrl;
    } on StorageException catch (e) {
      showNotification(
        title: "Erreur",
        body: "La base de données à un problème ${e.message}",
      );
      return null;
    } on FileSystemException catch (e) {
      showNotification(
        title: "Erreur",
        body: "Erreur système de fichier : ${e.message}",
      );
      return null;
    } catch (e) {
      print(e);
      showNotification(title: "Erreur", body: "Une erreur inattendue : $e");
      return null;
    }
  }

  Future<Uint8List?> _getFileBytes(PlatformFile platformFile) async {
    try {
      if (kIsWeb) {
        return platformFile.bytes;
      } else {
        final path = platformFile.path;
        if (path == null) {
          showErrorNotification('Chemin de fichier indisponible');
          return null;
        }
        return await File(path).readAsBytes();
      }
    } on FileSystemException catch (e) {
      showErrorNotification('Erreur d\'accès au fichier: ${e.message}');
      return null;
    }
  }

  Future<String?> _uploadToSupabase(
    String bucketName,
    String filePath,
    Uint8List fileBytes,
    String fileName,
  ) async {
    try {
      final fileOptions = FileOptions(contentType: _getMimeType(fileName));

      await Supabase.instance.client.storage
          .from(bucketName)
          .uploadBinary(filePath, fileBytes, fileOptions: fileOptions);
    } on StorageException catch (e) {
      showErrorNotification(
        'Erreur lors de la sauvegarde du fichier: ${e.message}',
      );
      throw StorageException(
        'Erreur lors de la sauvegarde du fichier: ${e.message}',
      );
    }
  }

  String _getMimeType(String fileName) {
    const _mimeTypeMap = {
      // Documents
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'txt': 'text/plain',
      'rtf': 'application/rtf',
      'csv': 'text/csv',
      'odt': 'application/vnd.oasis.opendocument.text',

      // Images
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'svg': 'image/svg+xml',
      'webp': 'image/webp',
      'bmp': 'image/bmp',

      // Audio/Vidéo
      'mp3': 'audio/mpeg',
      'wav': 'audio/wav',
      'mp4': 'video/mp4',
      'mov': 'video/quicktime',
      'avi': 'video/x-msvideo',
      'mkv': 'video/x-matroska',

      // Archives
      'zip': 'application/zip',
      'rar': 'application/x-rar-compressed',
      'tar': 'application/x-tar',
      'gz': 'application/gzip',
      '7z': 'application/x-7z-compressed',

      // Autres
      'html': 'text/html',
      'css': 'text/css',
      'js': 'text/javascript',
      'json': 'application/json',
      'xml': 'application/xml',
    };
    final extension = fileName.split('.').last.toLowerCase();
    return _mimeTypeMap[extension] ?? 'application/octet-stream';
  }

  /// Updates a file in Supabase storage with the given parameters.
  ///
  /// This function updates an existing file in a specified Supabase storage bucket.
  /// If the `upsert` option is set to `false`, the operation will fail if the file
  /// already exists.
  ///
  /// - [bucketName]: The name of the Supabase storage bucket.
  /// - [filePath]: The path to the file in the storage bucket.
  /// - [localFile]: The local file to be uploaded.
  /// - [cacheControl]: Optional cache control header (default: '3600').
  /// - [upsert]: Whether to overwrite the file if it exists (default: `false`).
  ///
  /// Returns:
  ///   - A `String` containing the path of the updated file.
  ///
  /// Throws:
  ///   - A `StorageException` if the file update fails.
  ///   - Any other exception related to Supabase or file handling.
  Future<String> updateFileInStorage({
    required String bucketName,
    required String? filePath,
    required FilePickerResult? result,
    String cacheControl = '3600',
    bool upsert = false,
  }) async {
    File localFile = File(result!.files.single.path!);
    final supabase = Supabase.instance.client;
    return await supabase.storage
        .from(bucketName)
        .update(
          filePath!,
          localFile,
          fileOptions: FileOptions(cacheControl: cacheControl, upsert: upsert),
        );
  }

  Future<String?> uploadFileMergeFile(
    String bucket,
    String id_document,
    String fileName,
    Uint8List fileBytes,
  ) async {
    try {
      final filePath = '$id_document/$fileName';

      print("Début de l'upload vers Supabase : $filePath...");
      final supabase = Supabase.instance.client;
      try {
        await supabase.storage
            .from(bucket)
            .uploadBinary(
              filePath,
              fileBytes,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );
      } catch (e) {
        print("error uploadFileMergeFile :$e");
      }

      // Générer l'URL publique du fichier
      final publicUrl = supabase.storage.from(bucket).getPublicUrl(filePath);
      print("Fichier téléversé avec succès : $publicUrl");

      return publicUrl;
    } catch (e) {
      print('Erreur lors du téléversement du fichier : $e');
      return null;
    }
  }
}

/// Example usage of the CRUD class:
/// ```dart
/// void main() async {
///   final userCRUD = CRUD(table: 'users');
///
///   // Create a new record
///   await userCRUD.create({'name': 'Alice', 'email': 'alice@example.com'});
///
///   // Read all data as a one-time fetch
///   await userCRUD.readSimple();
///
///   // Stream data in real-time
///   final stream = userCRUD.readStream<Map<String, dynamic>>(
///     toElement: (row) => row, // Directly use the row as a map
///   );
///   stream.listen((data) => print('Streamed data: $data'));
///
///   // Update a record
///   await userCRUD.updateData(1, {'name': 'Alice Doe'});
///
///   // Delete a record
///   await userCRUD.deleteData(1);
/// }
/// ```
