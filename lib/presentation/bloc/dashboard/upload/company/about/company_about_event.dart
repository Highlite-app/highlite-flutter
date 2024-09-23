abstract class CompanyUploadInfoEvent{
  CompanyUploadInfoEvent() ;
}

class UploadAboutStartEvent extends CompanyUploadInfoEvent{}



class SubmitCompanyAboutFormEvent extends CompanyUploadInfoEvent{
  SubmitCompanyAboutFormEvent() ;
}


class LanguagesSelectionCompanyEvent  extends CompanyUploadInfoEvent{
  final List<String> selectedLanguage ;
  LanguagesSelectionCompanyEvent({required this.selectedLanguage}) ;
}

