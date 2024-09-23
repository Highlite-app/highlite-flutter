import 'package:flutter_bloc/flutter_bloc.dart';
import 'public_company_profile_event.dart';
import 'public_company_profile_state.dart';



class PublicCompanyProfileBloc
    extends Bloc<PublicCompanyProfileEvent, PublicCompanyProfileState> {
  PublicCompanyProfileBloc() : super(PublicCompanyProfileState());
}
