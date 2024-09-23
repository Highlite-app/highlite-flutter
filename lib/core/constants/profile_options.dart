
import '../resources/l10n/translation_key.dart';

class ProfileOptions {
  List<String> workStatus() {
    return [
      TranslationKeys.acceptingNewClients,
      TranslationKeys.notAvailableAtTheMoment,
    ];
  }

  List<String> jobStatus() {
    return [
      TranslationKeys.active,
      TranslationKeys.inactive,
    ];
  }

  List<String> jobStatusInactive() {
    return [
      TranslationKeys.inactive,
    ];
  }

  List<String> jobDuration() {
    return [
      TranslationKeys.fullTime,
      TranslationKeys.partTime,
      TranslationKeys.both,
    ];
  }

  List<String> jobFlexibility() {
    return [
      TranslationKeys.remote,
      TranslationKeys.local,
      TranslationKeys.both,
    ];
  }

  List<String> communication() {
    return [
      TranslationKeys.voice,
      TranslationKeys.nonVoice,
      TranslationKeys.both,
    ];
  }

List<String> workType() {
    return [
      TranslationKeys.remote,
      TranslationKeys.inOffice,
      TranslationKeys.both,
    ];
  }

List<String> workTime() {
    return [
      TranslationKeys.fullTime,
      TranslationKeys.partTime,
      TranslationKeys.both,
    ];
  }

}
