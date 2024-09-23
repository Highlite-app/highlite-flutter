import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:video_player/video_player.dart';

import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import '../../../../../data/models/onboarding/file_model.dart';

abstract class CompanyEditorEvent {
  const CompanyEditorEvent();
}

class UpdateCompanyEvent extends CompanyEditorEvent {
  const UpdateCompanyEvent({required this.companyProfile});
  final CompanyOnboarding companyProfile;
}

class UpdateCompanyUserEvent extends CompanyEditorEvent {
  const UpdateCompanyUserEvent({required this.companyUserProfile});
  final CompanyOnboarding companyUserProfile;
}

class ChangeCompanyProfilePictureEvent extends CompanyEditorEvent {
  const ChangeCompanyProfilePictureEvent({required this.companyLogo});
  final FileImage? companyLogo;
}

class AttachCompanyVideoEvent extends CompanyEditorEvent {
  const AttachCompanyVideoEvent(
      {required this.fileToUpload, required this.jobVideoFeedId});
  final FileModel? fileToUpload;
  final String? jobVideoFeedId;
}

class CreateJobPostEvent extends CompanyEditorEvent {
  const CreateJobPostEvent({required this.jobPostItem});
  final CompanyJobPost jobPostItem;
}

class DeleteJobPostEvent extends CompanyEditorEvent {
  const DeleteJobPostEvent({required this.jobPostItem});
  final CompanyJobPost jobPostItem;
}

class UpdateJobPostEvent extends CompanyEditorEvent {
  const UpdateJobPostEvent({required this.jobPostItem});
  final CompanyJobPost jobPostItem;
}

class CancelJobPostEvent extends CompanyEditorEvent {
  const CancelJobPostEvent();
}

class DeleteVideoEvent extends CompanyEditorEvent {
  const DeleteVideoEvent({required this.jobVideoFeedId});
  final String? jobVideoFeedId;
}

class SaveVideoEvent extends CompanyEditorEvent {
  const SaveVideoEvent({required this.jobPostItem});
  final CompanyJobPost jobPostItem;
}

class UploadVideoEvent extends CompanyEditorEvent {
  const UploadVideoEvent();
}

class FileVideoEmptyEvent extends CompanyEditorEvent {
  const FileVideoEmptyEvent();
}

class RetrieveNetworkVideoEvent extends CompanyEditorEvent {
  const RetrieveNetworkVideoEvent({required this.itemIndex});
  final int itemIndex;
}


class RetrieveJobPostListEvent extends CompanyEditorEvent {
  const RetrieveJobPostListEvent({required this.companyProfile});
  final CompanyOnboarding companyProfile;
}



class AttachEditCompanyVideoEvent extends CompanyEditorEvent {
  const AttachEditCompanyVideoEvent({required this.fileToUpload, required this.itemIndex});
  final FileModel? fileToUpload;
  final int itemIndex;
}

class UploadhEditCompanyVideoEvent extends CompanyEditorEvent {
  const UploadhEditCompanyVideoEvent({required this.jobPostVideoItem});
  final CompanyJobPostVideoFeed jobPostVideoItem;
}

class SaveVideoEditEvent extends CompanyEditorEvent {
  const SaveVideoEditEvent({required this.jobPostVideoItem, required this.controller, required this.fileNameToUpload});
  final CompanyJobPostVideoFeed jobPostVideoItem;
  final VideoPlayerController controller;
  final String fileNameToUpload;
}

class DeleteVideoEditEvent extends CompanyEditorEvent {
  const DeleteVideoEditEvent({required this.itemIndex});
  final int itemIndex;
}
