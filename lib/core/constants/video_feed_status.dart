
import '../../presentation/widgets/profile/edit_profile/sub_section/edit_profile_graphic_container.dart';
import '../resources/l10n/translation_key.dart';

class VideoFeedStatus {
  static String active = TranslationKeys.active;
  static String inactive = TranslationKeys.inactive;
  static String draft = TranslationKeys.draft;
  static VideoStatus getVideoStatus(String status) {
    if (status == active) {
      return VideoStatus.active;
    } else if (status == inactive) {
      return VideoStatus.inactive;
    } else {
      return VideoStatus.draft;
    }
  }
}
