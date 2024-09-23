// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyFlowModel _$CompanyFlowModelFromJson(Map<String, dynamic> json) =>
    CompanyFlowModel(
      city: json['city'] as String,
      country: json['country'] as String,
      jobTitle: json['jobTitle'] as String,
      companyWebsite: json['companyWebsite'] as String,
      organization: json['organization'] as String,
      about: json['about'] as String,
      username: json['username'] as String,
      jobIndustry: json['jobIndustry'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CompanyFlowModelToJson(CompanyFlowModel instance) =>
    <String, dynamic>{
      'organization': instance.organization,
      'jobIndustry': instance.jobIndustry,
      'companyWebsite': instance.companyWebsite,
      'city': instance.city,
      'country': instance.country,
      'jobTitle': instance.jobTitle,
      'about': instance.about,
      'username': instance.username,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
