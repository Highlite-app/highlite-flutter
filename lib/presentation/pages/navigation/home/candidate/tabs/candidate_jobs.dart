// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../../../../core/resources/asset_constants.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_job_post.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_profile.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_user_profile.dart';
// import '../../../../../bloc/center_prompt/center_prompt_builder.dart';
// import '../../../../../bloc/center_prompt/center_prompt_event.dart';
// import '../../../../../bloc/toast/toast_bloc.dart';
// import '../../../../../bloc/toast/toast_event.dart';
// import '../../../../../widgets/overlay/bookmark/select_bookmark_overlay.dart';
// import '../../../../../widgets/overlay/super_message/super_message_sender.dart';
// import '../../../../../widgets/toaster/toast_alert.dart';
// import '../../../../../widgets/video_feed/video_feed_item.dart';
// import 'candidate_tab.dart';
// class CandidateJobs extends StatefulWidget {
//   const CandidateJobs({super.key});
//
//   @override
//   State<CandidateJobs> createState() => _CandidateJobsState();
// }
//
// class _CandidateJobsState extends State<CandidateJobs> {
//
//   late HighliteCompanyUserProfile companyProfile ;
//   List<HighliteCompanyJobPost> jobPosts = [];
//
//
//   List<VideoPlayerController> _controllers = [];
//   final List<String> _videoUrls = [
//     'https://media.istockphoto.com/id/1130630420/video/be-confident-when-pursuing-success.mp4?s=mp4-640x640-is&k=20&c=Swi9qOj04Le1tOT0EkV0Jc932m2LmSqTGqHhGTf_wW8=',
//     'https://v.ftcdn.net/03/26/38/65/240_F_326386522_NEznX8zBBHuh8rXhXiSEWLhNo2pykzfx_ST.mp4',
//     'https://highlite-bucket.s3.us-east-1.amazonaws.com/IMG_9084.MOV?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIH2wJfBrm7%2FHMAK71vopEVekDO7adoQkVA%2FED1z44eiLAiEA8TGUsMtLzePhisWRzR%2F96Fx0xNdXMxbtyRS%2B9xKo4aYq%2BwIIKxABGgw5MjQ3MjQwMDg0MTgiDMv8FafeYWU%2BCyU54CrYAmLYDOlgA%2BaXyDZaA2ArR6Jwx43PwGF3zjh6A9eKRU0QJ%2F2ng08pQIqbspr%2FZ3RAVSxvvGWUxNIKkMDxVG8dts8QU%2B30QJ2juMobh%2BwHIL7Fj6hfUEhW%2FpzrGkRVTJJ2RcYpbz%2FcDIVfyflBwV4B8k4my8l%2FBXhRX28yWKuT%2FpeypxTo1xBptFDP8dyvxt5KMIPC7z1VV2LtVU1gI3XqWrKJuBaH6Kn2IpMiFvtEjCpvfqpj6XfZmzL1WdKHfyOJklrBQ2w7lz1qUBNwyDGGpw181Hp4OQ4ZJr1bQGX6yHyfWg2RV4o4j1mbyWteMW44Wv0jiCQJSfhPjYPsSgvc00i6BUsBrdteJKkYpviIpkAgAC32KJplYIOAwDnUHb2gI6P9oEil3Z5uU3MpUh%2FxOyolqVtKBI%2FS9ibql8rS%2BtN%2FjpVCynyk7oS2fStFPzfrFQ6iY4WrPf2QMJHr2LAGOrMCzq%2Flv%2FK0ZlkwjoyaypEFvBkmeA%2FYLW9MhjTmf%2F3WhOoRMPpzESVJ5G7pgfVLRPgAvk1g6geBQi67JFbzC0qnewb1nE2E4uAmXOaoRwO1Yw9lBCo%2BUYRegE6aPfHPUoxOl3NX%2Fc8BIcS9JUzrNsQ%2B%2BqyKPPobzVcceaynYM9m9l%2FhXT4nKrZArp5wZ1iusSTSJX%2B6x6Nnm3Ch0zggY2tYnZGCRT%2B8NjfKXJZZi65odu5q4TrifMLo%2BhuTC49d3kJ5PPK%2FcOQeSq01uaynss9mvIQ3nXvdeiGjCBZfqyTqN%2FQGOE5qjfUrnYHuiVbW5aWWyT5WpDeMGXMwlgn%2F0hVAI8X8A%2B744FzII5EqIr8onUeyoqICyTh53elkvMDJwtG06%2FeJaVUdRY1U6tezp%2FhxruUUlw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240410T095149Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA5OTOYSXRJOOQQS4L%2F20240410%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=a9efda40860b43259b16656763bf86e2126af93b611047a4273e2da1a75490d7',
//     'https://highlite-bucket.s3.us-east-1.amazonaws.com/IMG_1892.mov?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIH2wJfBrm7%2FHMAK71vopEVekDO7adoQkVA%2FED1z44eiLAiEA8TGUsMtLzePhisWRzR%2F96Fx0xNdXMxbtyRS%2B9xKo4aYq%2BwIIKxABGgw5MjQ3MjQwMDg0MTgiDMv8FafeYWU%2BCyU54CrYAmLYDOlgA%2BaXyDZaA2ArR6Jwx43PwGF3zjh6A9eKRU0QJ%2F2ng08pQIqbspr%2FZ3RAVSxvvGWUxNIKkMDxVG8dts8QU%2B30QJ2juMobh%2BwHIL7Fj6hfUEhW%2FpzrGkRVTJJ2RcYpbz%2FcDIVfyflBwV4B8k4my8l%2FBXhRX28yWKuT%2FpeypxTo1xBptFDP8dyvxt5KMIPC7z1VV2LtVU1gI3XqWrKJuBaH6Kn2IpMiFvtEjCpvfqpj6XfZmzL1WdKHfyOJklrBQ2w7lz1qUBNwyDGGpw181Hp4OQ4ZJr1bQGX6yHyfWg2RV4o4j1mbyWteMW44Wv0jiCQJSfhPjYPsSgvc00i6BUsBrdteJKkYpviIpkAgAC32KJplYIOAwDnUHb2gI6P9oEil3Z5uU3MpUh%2FxOyolqVtKBI%2FS9ibql8rS%2BtN%2FjpVCynyk7oS2fStFPzfrFQ6iY4WrPf2QMJHr2LAGOrMCzq%2Flv%2FK0ZlkwjoyaypEFvBkmeA%2FYLW9MhjTmf%2F3WhOoRMPpzESVJ5G7pgfVLRPgAvk1g6geBQi67JFbzC0qnewb1nE2E4uAmXOaoRwO1Yw9lBCo%2BUYRegE6aPfHPUoxOl3NX%2Fc8BIcS9JUzrNsQ%2B%2BqyKPPobzVcceaynYM9m9l%2FhXT4nKrZArp5wZ1iusSTSJX%2B6x6Nnm3Ch0zggY2tYnZGCRT%2B8NjfKXJZZi65odu5q4TrifMLo%2BhuTC49d3kJ5PPK%2FcOQeSq01uaynss9mvIQ3nXvdeiGjCBZfqyTqN%2FQGOE5qjfUrnYHuiVbW5aWWyT5WpDeMGXMwlgn%2F0hVAI8X8A%2B744FzII5EqIr8onUeyoqICyTh53elkvMDJwtG06%2FeJaVUdRY1U6tezp%2FhxruUUlw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240410T095230Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA5OTOYSXRJOOQQS4L%2F20240410%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=b7c14ea5c2802c2b9d91b2340ed1fa127020522ccb34fb3d701b7feee61a8830',
//     'https://highlite-bucket.s3.us-east-1.amazonaws.com/IMG_2287.MOV?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIH2wJfBrm7%2FHMAK71vopEVekDO7adoQkVA%2FED1z44eiLAiEA8TGUsMtLzePhisWRzR%2F96Fx0xNdXMxbtyRS%2B9xKo4aYq%2BwIIKxABGgw5MjQ3MjQwMDg0MTgiDMv8FafeYWU%2BCyU54CrYAmLYDOlgA%2BaXyDZaA2ArR6Jwx43PwGF3zjh6A9eKRU0QJ%2F2ng08pQIqbspr%2FZ3RAVSxvvGWUxNIKkMDxVG8dts8QU%2B30QJ2juMobh%2BwHIL7Fj6hfUEhW%2FpzrGkRVTJJ2RcYpbz%2FcDIVfyflBwV4B8k4my8l%2FBXhRX28yWKuT%2FpeypxTo1xBptFDP8dyvxt5KMIPC7z1VV2LtVU1gI3XqWrKJuBaH6Kn2IpMiFvtEjCpvfqpj6XfZmzL1WdKHfyOJklrBQ2w7lz1qUBNwyDGGpw181Hp4OQ4ZJr1bQGX6yHyfWg2RV4o4j1mbyWteMW44Wv0jiCQJSfhPjYPsSgvc00i6BUsBrdteJKkYpviIpkAgAC32KJplYIOAwDnUHb2gI6P9oEil3Z5uU3MpUh%2FxOyolqVtKBI%2FS9ibql8rS%2BtN%2FjpVCynyk7oS2fStFPzfrFQ6iY4WrPf2QMJHr2LAGOrMCzq%2Flv%2FK0ZlkwjoyaypEFvBkmeA%2FYLW9MhjTmf%2F3WhOoRMPpzESVJ5G7pgfVLRPgAvk1g6geBQi67JFbzC0qnewb1nE2E4uAmXOaoRwO1Yw9lBCo%2BUYRegE6aPfHPUoxOl3NX%2Fc8BIcS9JUzrNsQ%2B%2BqyKPPobzVcceaynYM9m9l%2FhXT4nKrZArp5wZ1iusSTSJX%2B6x6Nnm3Ch0zggY2tYnZGCRT%2B8NjfKXJZZi65odu5q4TrifMLo%2BhuTC49d3kJ5PPK%2FcOQeSq01uaynss9mvIQ3nXvdeiGjCBZfqyTqN%2FQGOE5qjfUrnYHuiVbW5aWWyT5WpDeMGXMwlgn%2F0hVAI8X8A%2B744FzII5EqIr8onUeyoqICyTh53elkvMDJwtG06%2FeJaVUdRY1U6tezp%2FhxruUUlw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240410T095259Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIA5OTOYSXRJOOQQS4L%2F20240410%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=d481b8797686bf1abb6ea14232d1fddc3eec76cd745e0b461e908a0b4fc37f45',
//     // Add more video URLs as needed
//   ];
//
//   final List<String> _thumbnailUrls = [
//     'https://t3.ftcdn.net/jpg/03/50/12/98/240_F_350129850_pNoBnoAfElxMAUMRK73JbynyZwxiY9AD.jpg',
//     'https://t3.ftcdn.net/jpg/03/32/38/72/240_F_332387269_d9jwaESXJjeSMrwm3GokuOG9Bi8DDyBh.jpg',
//     'https://t3.ftcdn.net/jpg/02/07/88/76/240_F_207887651_bp00jcwUR724H9118VZAaBhXypeZzfDR.jpg'
//     // Add more thumbnail URLs as needed
//   ];
//
//
//   bool isSuperMessaged = false ;
//   bool isBookmerked = false ;
//   bool isLiked = false ;
//   bool isdisliked = false ;
//
//
//
//   Future<void> initializeData() async{
//
//     try{
//
//       companyProfile = await getCompanyProfile();
//       HighliteCompanyJobPost jobPost = await getJobPost();
//       setState(() {
//         jobPosts.add(jobPost);
//       });
//
//     }catch(e){
//       debugPrint("Error in Inatlization data $e");
//     }
//
//   }
//
//
//   Future<HighliteCompanyJobPost> getJobPost() async{
//     String configString  = await rootBundle.loadString(AssetConstant.highliteCompanyJobPostFixture);
//     final  configResponse = jsonDecode(configString);
//     debugPrint("The config Response HighliteCompanyJobPostFixture Candidate For you Tab  ::::::$configResponse");
//     final response = HighliteCompanyJobPost.fromJson(configResponse);
//     return response ;
//   }
//
//   Future<HighliteCompanyUserProfile> getCompanyProfile() async{
//     String configString  = await rootBundle.loadString(AssetConstant.highliteCompanyProfileFixture);
//     final  configResponse = jsonDecode(configString);
//     debugPrint("The config Response HighliteCompanyProfileFixture Company For you Tab  ::::::$configResponse");
//     final response = HighliteCompanyUserProfile.fromJson(configResponse);
//     return response ;
//   }
//
//
//   @override
//   void initState() {
//     initializeData();
//     for (String url in _videoUrls) {
//       VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(url))
//         ..initialize().then((_) {
//           setState(() {});
//         })
//         ..play();
//       _controllers.add(controller);
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     JobFeedResponse jobFeedResponse = generateSampleData();
//     return  PageView.builder(
//         itemCount: _controllers.length,
//         scrollDirection: Axis.vertical,
//         physics: const ClampingScrollPhysics(),
//         onPageChanged: (page) {},
//         itemBuilder: (context, index) {
//           var item = jobFeedResponse.items[index];
//           var controller = _controllers[index];
//           var thumbnail = _thumbnailUrls[index % _thumbnailUrls.length];
//           return GestureDetector(
//               child:
//               VideoFeedItem(
//                   controller :controller,
//                   imageProvider: NetworkImage(thumbnail),
//                   contents:  VideoFeedContents(
//                      hiringTag:  true,
//                       title: jobFeedResponse!.items[index].title,
//                       name: jobFeedResponse!.items[index].companyProfile.companyName,
//                       location:"${jobFeedResponse!.items[index].companyProfile.city}, ${jobFeedResponse!.items[index].companyProfile.country}",
//                       salary: "${jobFeedResponse!.items[index].salary}/hr",
//                       jobFlexibility: jobFeedResponse!.items[index].jobFlexibility ,
//                       skills: jobFeedResponse!.items[index].skills,
//                       profile: 'https://t3.ftcdn.net/jpg/01/90/53/66/240_F_190536658_ODEdawlEQstAhBoxuuujz0fXlOtANylc.jpg'
//
//                   ),
//                   state: VideoFeedContentState(
//                       isFollowing: false ,
//                       enabledFollowButton: true,
//                       enabledActionButtons: true,
//                       isSuperMessaged: isSuperMessaged,
//                       isBookmarked: isBookmerked,
//                       isLiked: isLiked,
//                       isDisliked: isdisliked,
//                       isShared: false),
//                   onTapProfile: (){},
//                   onFollowTap: (){},
//                   onSuperMessageTap: (){
//                     SuperMessageSenderOverlay.showSuperMessage([])
//                         .then((sendResponse) {
//                       setState(() {
//                         centerPrompt.add(
//                           const ShowPromptEvent(asset: AssetConstant.lightingSelectedIcon),
//                         );
//                         isSuperMessaged = !isSuperMessaged ;
//                       });
//
//                       toaster.add(
//                         const ShowToastEvent(
//                           text: "Your super message has been sent successfully.",
//                           icon: AssetConstant.checkCircleIcon,
//                           state: ToastState.normal,
//                           duration: Duration(seconds: 3),
//                         ),
//                       );
//
//                     })  ;
//
//                   },
//                   onBookmarkTap: (){
//                     setState(() async{
//                       await SelectBookmarkOverlay
//                           .showBookmarkSelectionByUserId(
//                           context,
//                           "aaaaa",
//                           "cscss",
//                           "feed").then((value) {
//                         centerPrompt.add(
//                           const ShowPromptEvent(asset: AssetConstant.bookmarkIconSelectedV2),
//                         );
//                         isBookmerked = !isBookmerked ;
//                       });
//
//
//                     });
//                   },
//                   onLike: (){
//                     setState(() {
//                       centerPrompt.add(
//                         const ShowPromptEvent(asset: AssetConstant.likeSelectedIcon),
//                       );
//                       isLiked = !isLiked ;
//                       isdisliked =false ;
//                     });
//
//                   },
//                   onDislike: (){
//                     setState(() {
//                       centerPrompt.add(
//                         const ShowPromptEvent(asset: AssetConstant.dislikeSelectedIcon),
//                       );
//                       isLiked = false ;
//                       isdisliked = !isdisliked ;
//
//                     });
//                   },
//                   onShare: (){
//                     centerPrompt.add(
//                       const ShowPromptEvent(asset: AssetConstant.sharedIcon),
//                     );
//                   })
//
//
//           );
//         }
//     );
//   }
// }
//
// class JobFeedResponse {
//   final List<JobFeedItem> items;
//
//   JobFeedResponse({required this.items});
// }
//
// // Generate sample data
// JobFeedResponse generateSampleData() {
//   return JobFeedResponse(
//     items: [
//       JobFeedItem(
//         title: 'Flutter Developer',
//         salary: '5000',
//         jobFlexibility: 'Remote',
//         skills: ['Flutter', 'Dart'],
//         companyProfile: CompanyProfiles(
//           companyName: '0260 LABS LLC',
//           city: 'New York',
//           country: 'USA',
//         ),
//       ),
//       JobFeedItem(
//         title: 'Fluter Developer',
//         salary: '7000',
//         jobFlexibility: 'Full-Time',
//         skills: ['Java', 'Spring Boot'],
//         companyProfile: CompanyProfiles(
//           companyName: 'abc pvt.ltd',
//           city: 'Berlin',
//           country: 'Germany',
//         ),
//       ),
//       JobFeedItem(
//         title: 'Frontend Developer',
//         salary: '6000',
//         jobFlexibility: 'Part-Time',
//         skills: ['React', 'JavaScript'],
//         companyProfile: CompanyProfiles(
//           companyName: 'Oriental Limited',
//           city: 'London',
//           country: 'UK',
//         ),
//       ),
//       JobFeedItem(
//         title: 'Frontend Developer',
//         salary: '6000',
//         jobFlexibility: 'Part-Time',
//         skills: ['React', 'JavaScript'],
//         companyProfile: CompanyProfiles(
//           companyName: 'Oriental LLC',
//           city: 'London',
//           country: 'UK',
//         ),
//       ),
//       JobFeedItem(
//         title: 'Frontend Developer',
//         salary: '6000',
//         jobFlexibility: 'Part-Time',
//         skills: ['React', 'JavaScript'],
//         companyProfile: CompanyProfiles(
//           companyName: '0260 LABS',
//           city: 'London',
//           country: 'UK',
//         ),
//       ),
//       JobFeedItem(
//         title: 'Frontend Developer',
//         salary: '6000',
//         jobFlexibility: 'Part-Time',
//         skills: ['React', 'JavaScript'],
//         companyProfile: CompanyProfiles(
//           companyName: 'TATA DIGITAL',
//           city: 'Bangalore',
//           country: 'India',
//         ),
//
//       ),
//       JobFeedItem(
//         title: 'AWS Cloud Engineer',
//         salary: '6000',
//         jobFlexibility: 'Part-Time',
//         skills: ['React', 'JavaScript'],
//         companyProfile: CompanyProfiles(
//           companyName: 'Amazon' ,
//           city: 'London',
//           country: 'UK',
//         ),
//
//       ),
//       // Add more JobFeedItem instances with unique data as needed
//     ],
//   );
// }
//
// void main() {
//   JobFeedResponse jobFeedResponse = generateSampleData();
//
//   // Use jobFeedResponse in your Flutter widgets
//   // For example:
//   int index = 0; // Assume we are displaying the first item
//   var item = jobFeedResponse.items[index];
//   print('Title: ${item.title}');
//   print('Name: ${item.companyProfile.companyName}');
//   print('Location: ${item.companyProfile.city}, ${item.companyProfile.country}');
//   print('Salary: ${item.salary}/hr');
//   print('Job Flexibility: ${item.jobFlexibility}');
//   print('Skills: ${item.skills.join(", ")}');
// }