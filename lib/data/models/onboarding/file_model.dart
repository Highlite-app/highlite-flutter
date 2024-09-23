
import 'dart:io';

import '../../../core/services/single_uploader_service.dart';

class FileModel {
  final File? file;
  final String? url;
  final FileType fileType;
  const FileModel({
    required this.file,
    this.url,
    required this.fileType,
  });
  FileModel copyWith({String? url}) => FileModel(
    file: file,
    fileType: fileType,
    url: url ?? this.url,
  );
}