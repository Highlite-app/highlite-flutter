import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';

import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

const MUX_TOKEN_ID = "bf62e27c-a4cf-4df3-9cb6-0417286f030e" ;
const MUX_SECRET_KEY = "DsIvkDdd4a45gyz2SZS1epqY0OBR/jFXos4sjHGvdGBVGCaojWa0FI8WZSIJtpMRO6EiZY4pPaJ" ;

const MUX_TOKEN_ID_PROD = "5c3ed874-0bcd-474a-a153-f979c156d558";
const MUX_SECRET_KEY_PROD = "t9YK69qxf7bR8gXvelw2pOu1h7FR0TMQoinwXzhsi+cQeONvdBbkHQh9On++kqYmb8Mir5+aHsP";

const MUX_TOKEN_SRIJAN ="c6d714ec-a6af-4150-9d1d-e8ae2520b6e8" ;
const MUX_TOKEN_SECRET_SRIJAN = 'HeqyM4w8z3kPlEinxj41KgZ2BBxSo8NiDwaGNQppL12WeFLtblV7NT75LbjK3+GUgUs0HoIe6SE';




class MuxVideoClient {
  final http.Client _client;

  MuxVideoClient({http.Client? client}) : _client = client ?? http.Client();






  Future<Map<String, dynamic>> getMuxAssets({String? muxToken , String? muxSecret }) async {
    final muxTokenId =muxToken ?? MUX_TOKEN_ID_PROD;
    final muxSecretKey = muxSecret?? MUX_SECRET_KEY_PROD;

    final response = await _client.get(
        Uri.parse('https://api.mux.com/video/v1/assets'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
        });

    if (response.statusCode == 200) {

      return jsonDecode(response.body) as Map<String, dynamic>;

    } else {
      throw Exception('Failed to load assets');
    }
  }


  Future<Map<String, dynamic>> createDirectUploadUrl({
    String? muxToken,
    String? muxSecret,
  }) async {
    final muxTokenId = muxToken ?? MUX_TOKEN_SRIJAN;
    final muxSecretKey = muxSecret ?? MUX_TOKEN_SECRET_SRIJAN;

    Dio dio = Dio();

    try {
      final response = await dio.post(
        'https://api.mux.com/video/v1/uploads',
        data: jsonEncode({
          "new_asset_settings": {
            "playback_policy": [
              "public"
            ],
            "max_resolution_tier": "1080p",
            "encoding_tier": "smart"
          },
          "cors_origin": "*"
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.logEvent(response.data , isJson: true) ;
        return response.data is Map<String, dynamic>
            ? response.data['data']
            : jsonDecode(response.data) as Map<String, dynamic>;
      } else {
        // Log response data for further inspection
        print('Failed with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw Exception('Failed to upload assets: ${response.statusCode}');
      }
    } catch (e) {
      print('Upload failed: $e');
      throw Exception('Failed to upload assets');
    }
  }

  Future<void> uploadVideoFile(String uploadUrl, File videoFile) async {
    Dio dio = Dio();


    final response = await dio.put(
      uploadUrl,
      data: videoFile.openRead(),
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',

        },
      ),
      onSendProgress:(int totalLength ,int  progress) {
        logger.logEvent("The total length of video: $totalLength") ;
        logger.logEvent("The total progress of video: $progress") ;
      }
    );

    if (response.statusCode == 200) {
      print('Upload successful!');
      logger.logEvent(response.data , isJson: true) ;
    } else {
      throw Exception('Failed to upload video file: ${response.statusCode}');
    }
  }



  Future<String> getAssetIdFromUploadId({required String uploadId}) async{
    Dio dio = Dio() ;

    var muxTokenId = MUX_TOKEN_SRIJAN ;
    var muxSecretKey = MUX_TOKEN_SECRET_SRIJAN ;

    String assetId = ''  ;

    final response  = await dio.get('https://api.mux.com/video/v1/uploads/$uploadId' , options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
      },
    ) ) ;
    try{
      if(response.statusCode == 200 ){
        logger.logEvent(response.data , isJson: true) ;
        assetId = response.data['data']['asset_id'] ;



      }
      print('The asset it $assetId') ;
      return assetId ;
    }catch(e){
      throw Exception(e) ;
    }

  }

  Future<MuxResponse> getPlaybackId({required String assetId}) async{

    Dio dio = Dio() ;

    var muxTokenId = MUX_TOKEN_SRIJAN ;
    var muxSecretKey = MUX_TOKEN_SECRET_SRIJAN ;

    final response  = await dio.get('https://api.mux.com/video/v1/assets/$assetId' , options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
      },
    ) ) ;
    try{
      if(response.statusCode == 200 ){
        logger.logEvent(response.data , isJson: true) ;

       String  playbackId = response.data['data']['playback_ids'][0]['id'] ;
        String assetIds = response.data['data']['id'] ;
        String  uploadId = response.data['data']['upload_id'] ;

        logger.logEvent("Playback id:: $playbackId") ;


        return  MuxResponse(uploadId: uploadId , assertId:  assetIds , playbackId: playbackId);


      }else {
        throw Exception('Failed to load playback ID');
      }

    }catch(e){
      throw Exception("Api issue in uploadId Api $e") ;
    }
  }

  Future<MuxResponse> uploadMuxAssets({
    String? muxToken ,
    String? muxSecret,
    required File videoFile,
  }) async {
    final muxTokenId = muxToken ?? MUX_TOKEN_SRIJAN;
    final muxSecretKey = muxSecret ??MUX_TOKEN_SECRET_SRIJAN;



    try {
      Map<String, dynamic> uploadData = await createDirectUploadUrl(muxToken: muxTokenId, muxSecret: muxSecretKey);
      String uploadUrl = uploadData['url'];
      String uploadId = uploadData['id'];

      await uploadVideoFile(uploadUrl, videoFile);

      debugPrint('Video upload completed successfully with upload ID: $uploadId');
     String assetId  =  await getAssetIdFromUploadId(uploadId:uploadId ) ;
     MuxResponse response = await getPlaybackId(assetId: assetId ) ;
     return response ;

    } catch (e) {
      print('Error during upload: $e');
      throw Exception(e) ;
    }
  }







  Future<Map<String, dynamic>> getMuxAsset(String assetId) async {
    final muxTokenId = MUX_TOKEN_ID_PROD;
    final muxSecretKey = MUX_SECRET_KEY_PROD;

    final response = await _client.get(
        Uri.parse('https://api.mux.com/video/v1/assets/$assetId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'Basic ${base64Encode(utf8.encode('$muxTokenId:$muxSecretKey'))}',
        });

    if (response.statusCode == 200) {
      debugPrint("The resposne is ::${response.body}");
      return jsonDecode(response.body) as Map<String, dynamic>;

    } else {
      throw Exception('Failed to load the asset from MUX');
    }
  }
}
