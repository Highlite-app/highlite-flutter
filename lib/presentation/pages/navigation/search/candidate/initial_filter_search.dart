import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/search/candidate/selected_filtered_view.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/profile_picture.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/sectionable/heading.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';
import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../../bloc/dashboard/search/candidate/candidate_search_bloc.dart';
import '../../../../bloc/dashboard/search/candidate/candidate_search_state.dart';
import '../../../../widgets/search/sections/search_card.dart';
import '../../profile/company/company_public_profile.dart';

class InitialFilterSearch extends StatelessWidget {
  const InitialFilterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateSearchBloc, CandidateSearchState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (state.selectedFilteredItem.isNotEmpty)
                  SelectedFiltered(selectedFilters: state.selectedFilteredItem),
                FeaturedCompanies(
                  companyFeed: [],
                ),
                const SizedBox(height: 16,),
                TrendingJobs(companyFeed: [],) ,
                const SizedBox(height: 16,),
                if (state.selectedFilteredItem.isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.filteredCompanyJobPost?.length ?? 0,
                      itemBuilder: (context, index) {
                        var jobPostMap = state.mappedFilteredJobPosts?[index];
                        var companyJobPost =
                            jobPostMap?['jobPost'] as CompanyJobPost?;
                        var companyOnboarding =
                            jobPostMap?['companyOnboarding'] as CompanyOnboarding?;
            
                        return GestureDetector(
                          onTap: () {
                            context.navigator.push(MaterialPageRoute(
                                builder: (_) => CompanyPublicProfile(
                                      companyOnboarding: companyOnboarding!,
                                    )));
                          },
                          child: SearchCard(
                            title: companyOnboarding?.companyName ?? '',
                            jobRole: companyJobPost?.position ?? '',
                            location: state.companyJobPost?[index].location ?? '',
                            skills: companyJobPost?.skills ?? [],
                            tools: companyJobPost?.tools ?? [],
                            jobDuration: companyJobPost?.jobDuration ?? '',
                            workType: companyJobPost?.workType ?? '',
                            salary: companyJobPost?.salary ?? '',
                            imageUrl: '',
                            selectedSkills: state.selectedSkills,
                            selectedTools: state.selectedTools,
                            onTapBookmark: () {},
                          ),
                        );
                      })
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FeaturedCompanies extends StatelessWidget {
  List<CompanyJobFeed> companyFeed;

  FeaturedCompanies({required this.companyFeed, super.key});

  @override
  Widget build(BuildContext context) {
    double itemHeight = MediaQuery.of(context).size.height * 0.30;
    return SizedBox(
      height: itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Heading(title: 'Featured Company' , textStyle: BaseTextStyle(
               color: ColorConstant.neutral900 ,
               fontSize: TypographyTheme.paragraph_p2 ,
               fontWeight: FontWeight.w700
           )) ,
          const SizedBox(height: 16) ,
          Expanded(
            child: ListView.separated(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CompanyCard(
                    companyName: 'Apeejay Group',
                    about: 'We Strive to be a great place to work & bank.',
                    profileUrl: 'https://firebasestorage.googleapis.com/v0/b/highlite-app.appspot.com/o/profile_images%2F1721995435993?alt=media&token=810e0d48-35e3-42b5-b873-2fbb5e8b0df2',
                    onTapFollow: () {},
                    candidateSearchType: CandidateSearchType.featured,
                  );
                },
            separatorBuilder: (context , index){
                return const SizedBox(width: 16);
            },
            ),
          ),
        ],
      ),
    );
  }
}


class TrendingJobs extends StatelessWidget {
  List<CompanyJobFeed> companyFeed;

  TrendingJobs({required this.companyFeed, super.key});

  @override
  Widget build(BuildContext context) {
    double itemHeight = MediaQuery.of(context).size.height * 0.30;
    double itemHeight1 = MediaQuery.of(context).size.height * 0.27;
    return SizedBox(
      height: CandidateSearchType.trending == 'trending' ?  itemHeight :itemHeight1 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Heading(title: 'Trending Jobs'  , textStyle: BaseTextStyle(
              color: ColorConstant.neutral900 ,
              fontSize: TypographyTheme.paragraph_p2 ,
              fontWeight: FontWeight.w700
          )) ,
          const SizedBox(height: 16) ,
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CompanyCard(
                  skills: ['UX Research'],
                  companyName: 'Apeejay Group',
                  profileUrl: 'https://firebasestorage.googleapis.com/v0/b/highlite-app.appspot.com/o/profile_images%2F1721995438192?alt=media&token=d1c8176d-6cdd-4de8-b3e8-dbcadde029b1',
                  candidateSearchType: CandidateSearchType.trending,
                );
              },
              separatorBuilder: (context , index){
                return const SizedBox(width: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopCompanies extends StatelessWidget {
  List<CompanyJobFeed> companyFeed;


  TopCompanies({required this.companyFeed, super.key});

  @override
  Widget build(BuildContext context) {
    double itemHeight = MediaQuery.of(context).size.height * 0.30;
    return SizedBox(
      height:  itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Heading(title: 'Top Companies' ,textStyle: BaseTextStyle(
              color: ColorConstant.neutral900 ,
              fontSize: TypographyTheme.paragraph_p2 ,
              fontWeight: FontWeight.w700
            ), ) ,
          const SizedBox(height: 16) ,
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CompanyCard(
                  companyName: 'Apeejay Group',
                  profileUrl: 'https://firebasestorage.googleapis.com/v0/b/highlite-app.appspot.com/o/profile_images%2F1721995435993?alt=media&token=810e0d48-35e3-42b5-b873-2fbb5e8b0df2',
                  candidateSearchType: CandidateSearchType.topCompanies,
                );
              },
              separatorBuilder: (context , index){
                return const SizedBox(width: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}


enum CandidateSearchType { featured , trending , topCompanies}
class CompanyCard extends StatelessWidget {
  final String companyName;
  final String? about;
  final List<String>? skills ;
  final CandidateSearchType candidateSearchType ;
  final VoidCallback? onTapFollow;
  final String? profileUrl ;

  const CompanyCard(
      {super.key,
        this.profileUrl ,
        required this.candidateSearchType ,
      required this.companyName,
       this.about,
        this.skills ,
       this.onTapFollow });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    
    return IntrinsicHeight(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: candidateSearchType == CandidateSearchType.topCompanies ?Colors.white : ColorConstant.neutral50,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(!profileUrl.isNullOrEmpty)
            ProfilePicture(
              size: 60,
              url:  profileUrl ?? ''
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
                maxLines: 1,
                companyName,
                style: BaseTextStyle(
                  color: ColorConstant.neutral900,
                     fontSize: TypographyTheme.paragraph_p3,
                    fontWeight: FontWeight.w500)),
            const  SizedBox(height: 8),
            if(!about.isNullOrEmpty) ...[
              Expanded(
                  child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      about ?? '' ,
                      style: BaseTextStyle(
                          color: ColorConstant.neutral600,
                          fontSize: TypographyTheme.paragraph_p5,
                          fontWeight: FontWeight.w500) )),
              const SizedBox(height: 8),
            ] ,
      
            if(!skills.isNullOrEmpty) ...[
              Chip(
                backgroundColor: ColorConstant.shade00,
                elevation: 0,
                clipBehavior: Clip.none,
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 0.5,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstant.neutral300),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(100)),
                ),
                label: Text(
                  skills?.first ?? '',
                  style: BaseTextStyle(
                      color: ColorConstant.shade100,
                      fontWeight: FontWeight.w500,
                      fontSize: TypographyTheme.paragraph_p4),
                ),
              ),
              const SizedBox(height: 8),
            ],
      
           if(candidateSearchType == CandidateSearchType.featured)
            ElevatedButton(
              onPressed: onTapFollow,
      
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                backgroundColor: ColorConstant.neutral200 ,
              ),
              child: Text('Follow' , style: BaseTextStyle(
                color: ColorConstant.neutral800 ,
                fontSize: TypographyTheme.paragraph_p5 ,
                fontWeight: FontWeight.w700 ,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
