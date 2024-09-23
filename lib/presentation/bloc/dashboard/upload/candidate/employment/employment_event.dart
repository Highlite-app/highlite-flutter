abstract class EmploymentEvent {}



class UpdateCurrentEmploymentEvent extends EmploymentEvent {
  final String employmentStatus ;
  final bool onNext ;
  final Function()? onUnemployed ;
  UpdateCurrentEmploymentEvent( this.employmentStatus  ,this.onNext , {this.onUnemployed} );
}


class UpdateEmploymentTypeEvent extends EmploymentEvent{
  final String employmentType ;
  final bool onNext  ;
  UpdateEmploymentTypeEvent(this.employmentType , this.onNext ) ;
}



class UpdateCurrentJobTitleEvent extends EmploymentEvent {
  final String jobTitle;
  final bool onNext ;

  UpdateCurrentJobTitleEvent(this.jobTitle , this.onNext);
}

class UpdateCurrentCompanyNameEvent extends EmploymentEvent {
  final String companyName;
  final bool onNext ;

  UpdateCurrentCompanyNameEvent(this.companyName , this.onNext);
}

class UpdateTotalExperienceEvent extends EmploymentEvent {
  final String startDate;
  final String endDate;
  final bool onNext ;

  UpdateTotalExperienceEvent(this.startDate  , this.endDate ,  this.onNext);
}

class SetEmploymentType extends EmploymentEvent {
  List<String> employmentType ;

  SetEmploymentType(this.employmentType) ;
}

class SaveEmploymentDetails extends EmploymentEvent{
  SaveEmploymentDetails() ;
}

