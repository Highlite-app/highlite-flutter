import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';
import '../../../../../../data/models/onboarding/file_model.dart';
import '../../../../../widgets/form/form.dart';

class UploadCandidateState {
  final bool isVideo;
  final File? pickVideo;
  final MuxResponse? muxResponse;
  final bool isUpload ;
  final String thumbnailUrl;
  final String  thumbnailWidth ;
  final String thumbnailHeight ;
  final TextEditingController descriptionController;
  final ValueNotifier<FormProviderState> formProvider;
  final GlobalKey<FormState> formState;
  final List<String> tags;
  final List<String> category ;
  final List<String> categoryList  ;

  UploadCandidateState({
    this.isVideo = false,
    this.pickVideo,
    this.muxResponse,
    this.thumbnailUrl = '',
    this.isUpload = false ,
    TextEditingController? descriptionController,
    GlobalKey<FormState>? formState,
    ValueNotifier<FormProviderState>? formProvider,
    this.thumbnailWidth = '125' ,
    this.thumbnailHeight  = '150',
    this.tags = const [],
    this.category = const [],
    this.categoryList = const [
      'Packaging and Filling Machine Operator',
      'Painter',
      'Paralegal',
      'Petroleum Engineer',
      'Pharmacist',
      'Photographer',
      'Physical Therapist',
      'Physician Assistant (PA)',
      'Physicist',
      'Pilot',
      'Plant Manager',
      'Plumber',
      'Police Officer',
      'Policy Analyst',
      'Postal Worker',
      'Product Manager',
      'Product Marketing Manager',
      'Production Manager',
      'Production Supervisor',
      'Professor',
      'Project Manager',
      'Psychologist',
      'Public Relations Specialist',
      'Quality Assurance Engineer',
      'Quality Control Inspector',
      'Real Estate Agent',
      'Registered Nurse (RN)',
      'Retail Salesperson',
      'Sales Associate',
      'Sales Manager',
      'Sales Representative',
      'School Counselor',
      'School Principal',
      'Security Guard',
      'SEO Specialist',
      'Ship Captain',
      'Social Media Manager',
      'Social Worker',
      'Software Developer',
      'Solar Energy Technician',
      'Sommelier',
      'Special Education Teacher',
      'Statistician',
      'Stock Broker',
      'Subway and Streetcar Operator',
      'Surgeon',
      'Surveyor',
      'Systems Analyst',
      'Tax Preparer',
      'Teacher',
      'Teaching Assistant',
      'Telemarketer',
      'Tool and Die Maker',
      'Tour Guide',
      'Travel Agent',
      'Truck Driver',
      'Tutor',
      'UI/UX Designer',
      'Urban Planner',
      'Veterinarian',
      'Video Editor',
      'Waitstaff',
      'Web Developer',
      'Welder',
      'Wind Turbine Technician',
      'Writer',
    ] ,
  })  : descriptionController = descriptionController ?? TextEditingController(),
        formProvider = formProvider ?? ValueNotifier(FormProviderState.empty),
        formState = formState ?? GlobalKey<FormState>();

  UploadCandidateState copyWith({
    bool? isVideo,
    File? pickVideo,
    String? thumbnailUrl,
    bool? isUpload ,
    MuxResponse? muxResponse,
    TextEditingController? descriptionController,
    ValueNotifier<FormProviderState>? formProvider,
    GlobalKey<FormState>? formState,
    List<String>? tags,
    List<String>? category,
    String? salary,
  }) {
    return UploadCandidateState(
      isVideo: isVideo ?? this.isVideo,
      isUpload: isUpload ?? this.isUpload,
      pickVideo: pickVideo ?? this.pickVideo,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      muxResponse: muxResponse ?? this.muxResponse,
      descriptionController: descriptionController ?? this.descriptionController,
      formProvider: formProvider ?? this.formProvider,
      formState: formState ?? this.formState,
      tags: tags ?? this.tags,
      category: category ?? this.category,
    );
  }
}
