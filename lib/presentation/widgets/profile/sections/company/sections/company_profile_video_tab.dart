import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/company/company_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/self_comapany_video_player.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/tabs/self_video/self_video_player_screen.dart';

import '../../../../../bloc/dashboard/profile/company/company_editor_state.dart';

class CompanyProfileVideTab extends StatelessWidget {
  const CompanyProfileVideTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final thumbnailWidth = (screenWidth - 35) / 3.3;
    debugPrint('$thumbnailWidth'); // 32 accounts for padding and spacing

    return BlocBuilder<CompanyEditorBloc , CompanyEditorState>(
        builder: (context , state ) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                  state.companyJobPostVideoFeed.length ?? 0, (index) {

                return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfCompanyVideoPlayer( companyOnboarding: state.companyProfile, companyJobPostVideoFeed: state.companyJobPostVideoFeed, index: index,),
                          ));
                    },
                    child: VideoThumbnail(companyJobPostVideoFeed:  state.companyJobPostVideoFeed , index: index, width: thumbnailWidth));
              }),
            ),
          );
        }
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final List<CompanyJobPostVideoFeed> companyJobPostVideoFeed ;
  final int index;
  final double width;

  const VideoThumbnail({
    super.key,
    required this.companyJobPostVideoFeed ,
    required this.index, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ,
      height: width,
      color: Colors.grey[300],
      child: Stack(
        children: [
          Image.network(
            companyJobPostVideoFeed[index].playbackId ,
            width: width,
            height: width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  '${index * 100 + 100}', // Example play count
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
