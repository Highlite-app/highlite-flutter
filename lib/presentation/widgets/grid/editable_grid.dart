import 'package:flutter/material.dart';

import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import 'package:highlite_flutter_mvp/presentation/widgets/grid/upload_tile.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/onboarding/file_model.dart';
import '../buttons/tiny_button.dart';
import '../gallery/gallery_grid.dart';
import '../gallery/gallery_tile.dart';
import '../sectionable/sectionable.dart';
import '../utils/file.dart';

class EditableGrid extends StatefulWidget {
  final String emptyLabel;
  final String moreLabel;
  final Function(List<FileModel>) onChangeFiles;
  final Function(List<FileModel>) onAddFiles;
  final Function(FileModel, int) onEditFile;
  final Function(int) onRemoveFile;
  final List<FileModel> files;
  const EditableGrid({
    super.key,
    required this.emptyLabel,
    required this.moreLabel,
    required this.onChangeFiles,
    required this.onAddFiles,
    required this.onEditFile,
    required this.onRemoveFile,
    required this.files,
  });

  @override
  State<EditableGrid> createState() => _EditableGridState();
}

class _EditableGridState extends State<EditableGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.files.isEmpty) {
      return Section(
        child: SizedBox(
          width: double.infinity,
          height: 200.0,
          child: UploadTile(
            icon: AssetConstant.pickerFromGalleryIcon,
            label: widget.emptyLabel,
            onTap: () async {
              final pickedImages =
                  await fileManager.selectMultiplePhotos(ImageSource.gallery);
              widget.onChangeFiles(pickedImages);
            },
          ),
        ),
      );
    }
    return GalleryGrid(
      isAddEnabled: true,
      addText: widget.moreLabel,
      onAdd: () async {
        final pickedImages =
            await fileManager.selectMultiplePhotos(ImageSource.gallery);
        widget.onAddFiles(pickedImages);
      },
      items: widget.files
          .mapIndexed(
            (fileModel, index) => GalleryGridItem(
              url: fileModel.url ?? "",
              file: fileModel,
              blurred: fileModel.url == null,
              type: GalleryTileType.none,
              footerChild: GridEditOptions(
                onEdit: (fileModel) {
                  widget.onEditFile(fileModel, index);
                },
                onDelete: () {
                  widget.onRemoveFile(index);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class GridEditOptions extends StatelessWidget {
  final Function(FileModel) onEdit;
  final Function() onDelete;
  const GridEditOptions(
      {super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TinyButton(
            color: ColorConstant.shade00.withOpacity(0.8),
            splashColor: ColorConstant.shade00,
            onTap: () async {
              FileModel? fileModel =
                  await fileManager.getPhotoWithModel(ImageSource.gallery);
              if (fileModel != null) {
                onEdit(fileModel);
              }
            },
            icon: AssetConstant.editIcon,
            iconColor: ColorConstant.neutral800,
            size: 12,
            iconPadding: 8.0,
          ),
          const SizedBox(
            width: 12,
          ),
          TinyButton(
            color: ColorConstant.shade00.withOpacity(0.8),
            splashColor: ColorConstant.shade00,
            onTap: () async {
              onDelete();
            },
            icon: AssetConstant.trashIcon,
            iconColor: ColorConstant.neutral800,
            size: 12,
            iconPadding: 8.0,
          ),
        ],
      ),
    );
  }
}
