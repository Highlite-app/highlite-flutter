import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart' as filepicker ;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path_provider/path_provider.dart';

import '../../../core/services/injection_container.dart';
import '../../../core/services/single_uploader_service.dart';
import '../../../data/models/onboarding/file_model.dart';
import '../../sub_pages/preview_photo/preview_photo.dart';

final fileManager = sl.get<IFileManager>(instanceName: InjectionConstant.fileManager);

abstract class IFileManager {
  Future<FileImage?> takePhoto(ImageSource source);
  Future<List<FileModel>> selectMultiplePhotos(ImageSource source);
  Future<FileModel?> getPhotoWithModel(ImageSource source);
  Future<File?> pickFile();
  Future<File?> pickVideo(ImageSource source);
  Future<FileModel?> pickVideoWithModel(ImageSource source);
}


class FileManager implements IFileManager {
  @override
  Future<FileImage?> takePhoto(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return Future.value(null);
    }
    io.File storedImage = io.File(imageFile.path);
    // ignore: unnecessary_null_comparison
    if (storedImage == null) {
      return Future.value(null);
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await storedImage.copy('${appDir.path}/$fileName');
    FileImage image = FileImage(savedImage);
    return Future.value(image);
  }

  Future<FileImage?> takePhotoAndPreview(ImageSource source) async {
    FileImage? image = await takePhoto(source);
    if (image != null) {
      final previewImage = await PreviewPhotoPage.showPreviewPhotoToNavigator(image);
      if (previewImage != null) {
        image = previewImage;
        return image;
      } else {
        return null;
      }
    }
    return image;
  }

  @override
  Future<List<FileModel>> selectMultiplePhotos(ImageSource source) async {
    final imageFiles = await ImagePicker().pickMultiImage(
      maxWidth: 600,
    );
    if (imageFiles.isEmpty) {
      return Future.value([]);
    }
    List<io.File> storedImage =
        imageFiles.map((image) => io.File(image.path)).toList();
    // ignore: unnecessary_null_comparison
    if (storedImage == null) {
      return Future.value([]);
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName =
        imageFiles.map((image) => path.basename(image.path)).toList();
    final savedImage =
        await Future.wait(storedImage.mapIndexed((image, index) async {
      return await image.copy('${appDir.path}/${fileName[index]}');
    }).toList());
    List<FileImage> image =
        savedImage.map((image) => FileImage(image)).toList();
    return Future.value(image
        .map((image) => FileModel(file: image.file, fileType: FileType.photo))
        .toList());
  }

  @override
  Future<FileModel?> getPhotoWithModel(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return Future.value(null);
    }
    io.File storedImage = io.File(imageFile.path);
    // ignore: unnecessary_null_comparison
    if (storedImage == null) {
      return Future.value(null);
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await storedImage.copy('${appDir.path}/$fileName');
    FileImage image = FileImage(savedImage);
    return Future.value(FileModel(file: image.file, fileType: FileType.photo));
  }

  @override
  Future<File?> pickFile() async {
    filepicker.FilePickerResult? result =
        await filepicker.FilePicker.platform.pickFiles(
      withData: true,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      type: filepicker.FileType.custom,
    );
    if (result?.files.first != null) {
      io.File file = File(result!.files.first.path!);
      return file;
    }
    return null;
  }

  @override
  Future<File?> pickVideo(ImageSource source) async {
    final videoFile = await ImagePicker()
        .pickVideo(source: source, maxDuration: const Duration(seconds: 60));
    if (videoFile == null) {
      return Future.value(null);
    }
    File storedVideo = File(videoFile.path);
    // ignore: unnecessary_null_comparison
    if (storedVideo == null) {
      return Future.value(null);
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(videoFile.path);
    final filePath = '${appDir.path}/$fileName';
    final savedVideo = await storedVideo.copy(filePath);
    return Future.value(savedVideo);
  }

  @override
  Future<FileModel?> pickVideoWithModel(ImageSource source) async {
    final videoFile = await ImagePicker()
        .pickVideo(source: source, maxDuration: const Duration(seconds: 60));
    if (videoFile == null) {
      return Future.value(null);
    }
    File storedVideo = File(videoFile.path);
    // ignore: unnecessary_null_comparison
    if (storedVideo == null) {
      return Future.value(null);
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(videoFile.path);
    final filePath = '${appDir.path}/$fileName';
    final savedVideo = await storedVideo.copy(filePath);
    return Future.value(FileModel(file: savedVideo, fileType: FileType.video));
  }
}

extension FileManagement on File {
  Future<String> getFileSize(int decimals) async {
    int bytes = lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

Future<File> writeToFile(String fileName, ByteData data) async {
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = '$tempPath/$fileName';
  return File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
