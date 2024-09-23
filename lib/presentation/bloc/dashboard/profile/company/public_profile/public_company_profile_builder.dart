// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../core/services/injection_container.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_profile.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_user_profile.dart';
// import 'public_company_profile_bloc.dart';
// import 'public_company_profile_event.dart';
// import 'public_company_profile_state.dart';
//
// final publicCompanyProfileBuilder = sl.get<PublicCompanyProfileBloc>();
//
// class PublicCompanyProfileBuilderWidget extends StatelessWidget {
//   final Widget Function(BuildContext, PublicCompanyProfileState) builder;
//   const PublicCompanyProfileBuilderWidget({super.key, required this.builder});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PublicCompanyProfileBloc, PublicCompanyProfileState>(
//       builder: builder,
//     );
//   }
// }
//
// class PublicCompanyProfileProviderWidget extends StatelessWidget {
//   final Widget child;
//   final HighliteCompanyProfile companyProfile;
//
//   const PublicCompanyProfileProviderWidget({
//     super.key,
//     required this.child,
//     required this.companyProfile,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<PublicCompanyProfileBloc>(
//       lazy: true,
//       create: (ctx) {
//         return PublicCompanyProfileBloc()
//           ..add(PublicCompanyProfileStartEvent(companyProfile));
//       },
//       child: child,
//     );
//   }
// }
