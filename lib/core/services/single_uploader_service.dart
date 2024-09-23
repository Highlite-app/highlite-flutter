
enum FileType {
  photo,
  video,
  document;
}

enum FeatureType {
  chatAttachment,
  userProfileWork;
}


class SingleUploadPresignedURLResponse {
  final String timestampFile;
  final String url;
  final String s3url;
  const SingleUploadPresignedURLResponse({
    required this.timestampFile,
    required this.url,
    required this.s3url,
  });
}

// extension SingleUploadingService on IAPIService {
//   Future<SingleUploadPresignedURLResponse>
//       getSingleUploadPresignedURLWithoutClient(
//           FeatureType eFeatureType, FileType eFileType, String fileExt) async {
//     int randomNumber = Random().nextInt(100);
//     int timestamp = DateTime.now().millisecondsSinceEpoch;
//     String fileName = "${timestamp}_$randomNumber$fileExt";
//     QueryResult queryResult;
//
//     if (eFeatureType == FeatureType.userProfileWork) {
//       if (eFileType == FileType.photo) {
//         queryResult = await performQuery(getPreSignedWorkPhotoURL,
//             variables: {"fileName": fileName});
//         final String urlToPut =
//             queryResult.data?['getPreSignedWorkPhotoURLWithoutClient']['data']
//                     ['preSignedWorkPhotoURLWithoutClient'] ??
//                 "";
//         final urlFragments = urlToPut.split('?');
//         return SingleUploadPresignedURLResponse(
//           timestampFile: fileName,
//           url: urlToPut,
//           s3url: urlFragments.first,
//         );
//       } else {
//         queryResult = await performQuery(getPreSignedWorkVideoURL,
//             variables: {"fileName": fileName});
//         final String urlToPut =
//             queryResult.data?['getPreSignedWorkVideoURLWithoutClient']['data']
//                     ['preSignedWorkVideoURLWithoutClient'] ??
//                 "";
//         final urlFragments = urlToPut.split('?');
//         return SingleUploadPresignedURLResponse(
//           timestampFile: fileName,
//           url: urlToPut,
//           s3url: urlFragments.first,
//         );
//       }
//     } else {
//       if (eFileType == FileType.photo) {
//         queryResult = await performQuery(getPreSignedMessagePhotoURL,
//             variables: {"fileName": fileName});
//         final String urlToPut =
//             queryResult.data?['getPreSignedMessageFilePhotoURLWithoutClient']
//                     ['data']['preSignedMessageFilePhotoURLWithoutClient'] ??
//                 "";
//         final urlFragments = urlToPut.split('?');
//         return SingleUploadPresignedURLResponse(
//           timestampFile: fileName,
//           url: urlToPut,
//           s3url: urlFragments.first,
//         );
//       }
//
//       if (eFileType == FileType.video) {
//         queryResult = await performQuery(getPreSignedMessageVideoURL,
//             variables: {"fileName": fileName});
//         final String urlToPut =
//             queryResult.data?['getPreSignedMessageFileVideoURLWithoutClient']
//                     ['data']['preSignedMessageFileVideoURLWithoutClient'] ??
//                 "";
//         final urlFragments = urlToPut.split('?');
//         return SingleUploadPresignedURLResponse(
//           timestampFile: fileName,
//           url: urlToPut,
//           s3url: urlFragments.first,
//         );
//       } else {
//         queryResult = await performQuery(getPreSignedMessageDocumentURL,
//             variables: {"fileName": fileName});
//         final String urlToPut =
//             queryResult.data?['getPreSignedMessageFileDocumentURLWithoutClient']
//                     ['data']['preSignedMessageFileDocumentURLWithoutClient'] ??
//                 "";
//         final urlFragments = urlToPut.split('?');
//         return SingleUploadPresignedURLResponse(
//           timestampFile: fileName,
//           url: urlToPut,
//           s3url: urlFragments.first,
//         );
//       }
//     }
//   }
// }
