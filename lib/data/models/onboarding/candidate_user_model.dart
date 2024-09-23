
import '../../../core/constants/mocked_image.dart';
import 'onboarding_data.dart';


class CandidateUser {
  final UserType userType;
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String language;
  final String city;
  final String country;
  final String jobType;
  final String communication;
  final String salary;
  List<String> skills;
  List<String> tools;
  final String profile;
  final String organization;
  final String workType;
  final String aboutMe;
  final String jobLocation;
  final String workStatus;
  final String personalWebsite;
  final String title;
  CandidateUser({
    required this.id,
    required this.username,
    required this.userType,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.language,
    required this.city,
    required this.country,
    required this.jobType,
    required this.communication,
    required this.salary,
    required this.skills,
    required this.tools,
    required this.profile,
    required this.organization,
    required this.workType,
    required this.aboutMe,
    required this.workStatus,
    required this.jobLocation,
    required this.personalWebsite,
    required this.title,
  });
  CandidateUser.fromDocument(Map<String, dynamic> doc)
      : userType = doc['userType'] == 'company'
      ? UserType.company
      : UserType.applicant,
        id = doc['id'] ?? "",
        username = doc['username'] ?? "",
        firstName = doc['firstName'] ?? "",
        lastName = doc['lastName'] ?? "",
        organization = doc['organization'] ?? "",
        workType = doc['workType'] ?? "",
        phoneNumber = doc['phoneNumber'] ?? "",
        email = doc['email'] ?? "",
        language = doc['language'] ?? "",
        city = doc['city'] ?? "",
        country = doc['country'] ?? "",
        jobType = doc['jobType'] ?? "",
        communication = doc['communication'] ?? "",
        profile = doc['profilePhoto'] ?? "",
        salary = doc['salary'] ?? "",
        skills = List.from(doc['skills'] ?? []),
        tools = List.from(doc['tools'] ?? []),
        workStatus = doc['workStatus'] ?? "",
        jobLocation = doc['jobLocation'] ?? "",
        personalWebsite = doc['personalWebsite'] ?? "",
        title = doc['title'] ?? "",
        aboutMe = doc['aboutme'] ?? "";
  factory CandidateUser.mock() => CandidateUser.fromDocument({
    'id': '',
    'username': '@Srijanjordan',
    'userType': 'company',
    'firstName': 'Srijan',
    'lastName': 'Jordan',
    'organization': 'Highlite',
    'workType': 'Software Development',
    'phoneNumber': '',
    'email': '',
    'language': 'English',
    'city': 'Minessotta',
    'country': 'United States',
    'jobType': 'Full-Time',
    'communication': 'Both',
    'profilePhoto': MockedImage.mockedImageFromS3,
    'salary': '200',
    'skills': ['Software Development'],
    'tools': ['Figma'],
    'workStatus': 'Accepting new clients',
    'jobLocation': 'Remote',
    'personalWebsite': 'www.alrazisiam.com',
    'title': 'Freelance Graphic Designer',
    'aboutme': 'About Me',
  });
  getName() =>
      userType == UserType.applicant ? '$firstName $lastName' : organization;
  getShortenedName() =>
      userType == UserType.applicant ? firstName : organization;
  getFullName() => '$firstName $lastName';
  getAbout() => userType == UserType.applicant ? aboutMe : workType;
  getLocation() => "$city, $country";
  getTitle() => title;
  getSalary() => "\$$salary";
  getRate() => "$salary/hr";
}

class CandidateItem {
  final String id;
  final String userID;
  final String job;
  final String jobKey;
  final CandidateUser user;
  CandidateItem({
    required this.id,
    required this.userID,
    required this.job,
    required this.jobKey,
    required this.user,
  });
  CandidateItem.fromDocument(Map<String, dynamic> doc)
      : id = doc['id'] ?? "",
        userID = doc['userID'] ?? "",
        job = doc['job'] ?? "",
        jobKey = doc['jobKey'] ?? "",
        user = CandidateUser.fromDocument(doc['user']);
  factory CandidateItem.from(Map<String, dynamic> cItem) {
    String id = cItem['id'];
    String userID = cItem['userID'];
    String job = cItem['job'];
    String jobKey = cItem['jobKey'];
    CandidateUser user = CandidateUser.fromDocument(cItem['user']);
    return CandidateItem(
      id: id,
      userID: userID,
      job: job,
      jobKey: jobKey,
      user: user,
    );
  }
}
