class MuxAsset {
   List<Data>? data;

   MuxAsset({this.data});

   MuxAsset.fromJson(Map<String, dynamic> json) {
      if (json['data'] != null) {
         data = <Data>[];
         json['data'].forEach((v) {
            data!.add(new Data.fromJson(v));
         });
      }
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.data != null) {
         data['data'] = this.data!.map((v) => v.toJson()).toList();
      }
      return data;
   }
}

class Data {
   List<Tracks>? tracks;
   String? status;
   List<PlaybackIds>? playbackIds;
   String? mp4Support;
   String? maxStoredResolution;
   String? resolutionTier;
   String? maxStoredFrameRate;
   String? masterAccess;
   String? id;
   String? encodingTier;
   String? duration;
   String? createdAt;
   String? aspectRatio;

   Data(
       {this.tracks,
          this.status,
          this.playbackIds,
          this.mp4Support,
          this.maxStoredResolution,
          this.resolutionTier,
          this.maxStoredFrameRate,
          this.masterAccess,
          this.id,
          this.encodingTier,
          this.duration,
          this.createdAt,
          this.aspectRatio});

   Data.fromJson(Map<String, dynamic> json) {
      if (json['tracks'] != null) {
         tracks = <Tracks>[];
         json['tracks'].forEach((v) {
            tracks!.add(new Tracks.fromJson(v));
         });
      }
      status = json['status'];
      if (json['playback_ids'] != null) {
         playbackIds = <PlaybackIds>[];
         json['playback_ids'].forEach((v) {
            playbackIds!.add(new PlaybackIds.fromJson(v));
         });
      }
      mp4Support = json['mp4_support'];
      maxStoredResolution = json['max_stored_resolution'];
      resolutionTier = json['resolution_tier'];
      maxStoredFrameRate = json['max_stored_frame_rate'].toString();
      masterAccess = json['master_access'];
      id = json['id'];
      encodingTier = json['encoding_tier'];
      duration = json['duration'].toString();
      createdAt = json['created_at'];
      aspectRatio = json['aspect_ratio'];
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.tracks != null) {
         data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
      }
      data['status'] = this.status;
      if (this.playbackIds != null) {
         data['playback_ids'] = this.playbackIds!.map((v) => v.toJson()).toList();
      }
      data['mp4_support'] = this.mp4Support;
      data['max_stored_resolution'] = this.maxStoredResolution;
      data['resolution_tier'] = this.resolutionTier;
      data['max_stored_frame_rate'] = this.maxStoredFrameRate;
      data['master_access'] = this.masterAccess;
      data['id'] = this.id;
      data['encoding_tier'] = this.encodingTier;
      data['duration'] = this.duration;
      data['created_at'] = this.createdAt;
      data['aspect_ratio'] = this.aspectRatio;
      return data;
   }
}

class Tracks {
   String? type;
   String? maxWidth;
   String? maxHeight;
   String? maxFrameRate;
   String? id;
   String? duration;
   String? maxChannels;

   Tracks(
       {this.type,
          this.maxWidth,
          this.maxHeight,
          this.maxFrameRate,
          this.id,
          this.duration,
          this.maxChannels});

   Tracks.fromJson(Map<String, dynamic> json) {
      type = json['type'];
      maxWidth = json['max_width'].toString();
      maxHeight = json['max_height'].toString();
      maxFrameRate = json['max_frame_rate'].toString() ;
      id = json['id'].toString();
      duration = json['duration'].toString();
      maxChannels = json['max_channels'].toString();
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['type'] = this.type;
      data['max_width'] = this.maxWidth;
      data['max_height'] = this.maxHeight;
      data['max_frame_rate'] = this.maxFrameRate;
      data['id'] = this.id;
      data['duration'] = this.duration;
      data['max_channels'] = this.maxChannels;
      return data;
   }
}

class PlaybackIds {
   String? policy;
   String? id;

   PlaybackIds({this.policy, this.id});

   PlaybackIds.fromJson(Map<String, dynamic> json) {
      policy = json['policy'];
      id = json['id'];
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['policy'] = this.policy;
      data['id'] = this.id;
      return data;
   }
}
