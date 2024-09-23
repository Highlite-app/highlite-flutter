class TranslationKeys{
  TranslationKeys._() ;

  static const link = "Link";
  static const cancel= "Cancel" ;
  static const submit= "Submit" ;
  static const remote= "Remote" ;
  static const fullTime= "Full-time" ;
  static const partTime= "Part-time" ;
  static const inOffice= "In-office" ;
  static const local= "Local" ;
  static const voice= "Voice" ;
  static const nonVoice= "Non Voice" ;
  static const both= "Both" ;
  static const bothFullPartTime= "Hybrid (Both)" ;
  static const yes= "Yes" ;
  static const edit= "Edit" ;
  static const reply= "Reply" ;
  static const pin= "Pin" ;
  static const ok= "Ok" ;
  static const copy= "Copy" ;
  static const unSend= "Unsend" ;
  static const addManually= "Add Manually" ;
  static const continueText= "CONTINUE" ;
  static const provideFeedback ="Provide Feedback" ;
  static const contactSupport ="Contact Support" ;
  static const startOver ="Start Over" ;
  static const inactive ="Inactive" ;
  static const acceptingNewClients ="Accepting new clients" ;
  static const notAvailableAtTheMoment ="Not available at the moment" ;
  static const location ="Location" ;
  static const jobTitle ="Job Title" ;
  static const ourJobs ="Our Job" ;
  static const search ="Search" ;
  static const unMatch ="Unmatch" ;
  static const more  ="More" ;
  static const next  ="Next" ;


  //Networking
  static const noInternetConnection = "Not Internet Connection" ;
  static const technicalIssue = "There may be a technical issue at our end. Please try again in sometime" ;
  static const serverUnderMaintenance = "Server is under maintenance. Please try again in sometime" ;
  static const somethingWentWrong = "Looks like something went wrong. Please try again" ;



  //login
  static const loginStartMessage = "Welcome back! Choose how you want to login below" ;
  static const loginEmail1 = "Taking you to home screen, one moment..." ;
  static  loginEmail(String firstName) => "Login with $firstName" ;



  //general flow text
  static const welcomeToHighLite ="Welcome to Highlite! Let's get started." ;
  static const lookingOrHiring ="Are you looking for a job or hiring for a job?" ;
  static const looking ="Looking" ;
  static const hiring ="Hiring" ;
  static const login ="Login" ;
  static const emailAddress ="Email address" ;
  static const loginEmailOption ="Please enter your email address:" ;
  static  onboardingSentOTP(String emailId) =>"We’ve sent a code to \n*{$emailId}* \n\nEnter your verification code \nbelow:" ;
  static  const onboardingOTPWrong ="The code you entered is incorrect. Please try again?" ;
  static const tryAgainResponse ="Try again" ;
  static const loginNoAccount ="I could not find an account associated with this email address. Try again or let's create a new one!" ;
  static const createNewAccount ="Create a new account" ;
  static const onboardingEmailOptions ="Great! Now how would you prefer to sign up for Highlite?" ;
  static const signUpEmailAddress ="Email address" ;
  static const signUpApple ="Sign Up with Apple" ;
  static const loginWithApple ="Log In with Apple" ;
  static const signUpGoogle ="Sign Up with Google" ;
  static const loginInGoogle ="Login with Google" ;
  static const signUpFacebook ="Sign Up with Facebook" ;
  static const loginWithFacebook ="Login with Facebook" ;
  static const signUpMicrosoft ="Sign Up with Microsoft" ;
  static const signUpTwitter ="Sign Up with Twitter" ;
  static const signUpGithub ="Sign Up with Github" ;
  static const loginWithGithub ="Loginwith Github" ;
  static const signUpEmailAddressMessage ="Please provide your email address below:" ;
  static const onboardingEmailUserExists ="An account already exists with this email address. " ;
  static const onboardingEmailUserExists1 ="You can login or try again with a different email address?" ;


  //candidate Flow
  static const whatKindOfJob ="What kind of job are you looking for?  Example: Graphic Designer or Executive Assistant" ;
  static const onboardingSkills ="Please select your top 3 skills below." ;
  static const onboardingJobType ="Are you looking for remote work, in-office or both?" ;
  static const onboardingJobDuration ="Full-time, part-time or both?" ;
  static const onboardingLocation1 ="Where is your company located?" ;
  static const onboardingCandidateLocation ="Where are you located?" ;
  static const onboardingLocation2 ="Would you like to use your current location?" ;
  static const onboardingHourlyRate ="What is your desired hourly rate, in USD?" ;
  static const onboardingHourlyRateCompany ="What is the hourly rate for this position?" ;
  static const onboardingTools ="Please select your top 3 tools below." ;
  static const successFlow ="Your account has been created successfully!" ;
  static const takingYouToHomeScreen = "Taking you to home screen, one moment...";
  static const onboardingSuccessViewDescription = "Ready to find your next dream job?";
  static const letsGo = "Let's Go!";
  static const aboutCompany = "Please tell me about your \ncompany. What kind of work do \nyou do?";
  static const aboutCandidate = "Please tell me about yourself. What kind of work do you do?";



  //company Flow
  static const companyName = "What is your company name?";
  static const onboardingCompanySize = "What is your company size?";
  static const onboardingCompanyBenefits = "What benefits does your company\noffer?";
  static const onboardingJobLocationJobs = "Remote, in-office or both?";
  static const onboardingToolsJob = "onboarding Tools Job";
  static const whatIsYourWebsite = "What is your company website?";


  // COMPANY SIZE
  static const zeroTwoFifty = "0-50";
  static const fiftyTwoHundred = "50-100";
  static const hundredToTwoFifty = "100-250";
  static const twoFiftyToFiveHundred = "250-500";
  static const fiveHundredToThousand = "500-1000";
  static const thousandPlus = "1000+";

  //Location Service

  static const didntAllowLocation = "Didn't allow";
  static const responseDidntAllowLocation = "We couldn’t get your location. Would you like to try again?";
  static const onboardingCity = "What city are you located in?";
  static const onboardingCountry = "Which country do you live in?";



  //errorState
  static const didntReceiveCode = "Didn't Receive Code?";


  //status
  static const inActive = "Inactive" ;


  //Dialogs
  static const startOverTitle = "Start Over?";
  static const startOverMessage = "Your existing answers will be cleared and you will start again from the beginning.";
  static const typeMessage = "Type a message...";

  //Profile
  static const request = "Request";
  static const save = "Save";
  static const tools = "Tools";
  static const addYourWork = "Add your work";
  static const addYourJob = "addYourJob";
  static const superMessage = "Super Message";
  static const followers = "Followers";
  static const skills = "Skills";
  static const myWork = "My Work";
  static const general = "General";
  static const preview = "Preview";
  static const skillsAndDeliverables = "Skills & Deliverables";
  static const followingTitle = "Following";
  static const buttonFollowing = "Following";
  static const buttonFollow = "Follow";
  static const editProfile = "Edit Profile";
  static const uploadingProfile = "Uploading profile";
  static const uploadingVideo = "Uploading video";
  static const uploadVideo = "Upload Video";
  static const uploadResume = "Upload Resume";
  static const uploadProfileCompleted = "Photo upload completed";
  static const uploadVideoCompleted = "Video upload completed";
  static const invalidVideoDuration = "Looks like the video duration is more than 3 minute. Please keep the video within 3 minute and try again.";

   //Edit Profile
  static const draft = "Draft" ;
  static const active = "Active" ;
  static const pending = "Pending" ;
  static const hourlyRate = "Hourly Rate" ;
  static const changePhoto = "Change Photo" ;
  static const changeVideo = "Change Video" ;
  static const website = "Website" ;
  static const expectedSalary = "Expected Salary" ;
  static const firstName = "First Name" ;
  static const lastName = "Last Name" ;
  static const name = "Name" ;
  static const username = "Username" ;
  static const workTime = "Work time" ;
  static const workType = "Work Type" ;
  static const audioType = "Audio type" ;
  static const editName = "Edit Name" ;
  static const editUsername = "Edit Username" ;
  static const editJobTitle = "Edit Job Title" ;
  static const editJobStatus = "Edit Job Status" ;
  static const editHourlyRate = "Edit Hourly Rate" ;
  static const editWorkType = "Edit Work Type" ;
  static const editWorkTime = "Edit Work Time" ;
  static const editAudioType = "Edit Audio Type" ;
  static const editSkills = "Edit Skills" ;
  static const editTools = "Edit Tools" ;
  static const editLocation = "Edit Location" ;
  static const city = "City" ;
  static const title = "Title" ;
  static const country = "Country" ;
  static const editCurrentLocation = "Use your current location" ;
  static const editWebsite = "Edit Website" ;
  static const editLookingToHire = "Looking to Hire" ;
  static String lookingToHire(String  howMany) => "Looking to hire $howMany Employees" ;
  static const editPositionTitle = "Edit Position Title" ;
  static const editAbout = "Edit About" ;
  static const about = "About" ;
  static const jobStatus = "Job Status" ;
  static const jobStatusCaption = "Selecting “Inactive” option will hide your video job post from the Home Feed." ;
  static const editProfileByCandidateNameCaption = "Please make sure to provide valid full name as shown in your passport or goverment ID or driver license." ;
  static const editAddWork = "Edit/Add your Work" ;
  static const deleteVideo = "Delete Video" ;
  static const retakePhoto = "Retake Photo" ;
  static const chooseFromGallery = "Choose from Gallery" ;
  static const previewProfilePhoto = "Preview Profile Photo" ;
  static const delete = "Delete" ;
  static const workDeleteTitle = "Are you sure you want to delete this work?" ;
  static const workDeleteMessage = "Once you delete it, you won’t be get it back." ;
  static const savedItems = "Saved Item" ;
  static const select = "Select" ;
  static const saveTo = "Save to" ;
  static const bookmarkDeleteTitle = "Are you sure you want to delete these items?" ;
  static const bookmarkDeleteMessage = "Once you delete it, you won’t be able see them in your saved items" ;


  // Upload Section //
  static const  uploadText  = "What do you want to upload ?" ;
  static const  languages  = "Languages" ;
  static const  subHeading  = "These details help recruiter understand your\nprofessional experience" ;
  static const  subHeadingCompany  = "These details help candidate understand your\nprofessional information" ;
  static const  tellAboutYourself  = "Tell about yourself" ;
  static const  shareABriefAboutYourself  = "Share a brief introduction about yourself" ;
  static const  education  = "Education" ;
  static const  degree  = "Degree" ;
  static const  project  = "Project" ;
  static const  projectTitle  = "Project title*" ;
  static const  projectDetails  = "Details of project*" ;
  static const  clientTitle  = "Client*" ;
  static const  startDate  = "Start date*" ;
  static const  endDate  = "End date*" ;
  static const  projectStatus  = "Project Status" ;
  static const  roleDescription  = "Role description" ;
  static const  addMoreDetails  = "Add more details+" ;
  static const  workedTill  = "Worked Till" ;
  static const  workedFrom  = "Worked from" ;

  //Error Validation Message
  static const roleErrorText = "Role description cannot be empty";

  //Company
  static const  tellAboutCompany  = "Tell about the company" ;
  static const  ourServices  = "Our Services" ;
  static const  industry  = "Industry" ;
  static const  benefits  = "Benefits" ;
  static const  companySize  = "Company Size" ;

  //Upload Job Post by Company
  static const  jobDuration  = "Job Duration" ;
  static const  currentStatus  = "Current Status" ;

  // Upload Candidate

  static const projectConfirmation = 'Are you sure you want  to add\nproject details?' ;


  // Search
  static const sortByTools = "Sort by tools" ;
  static const sortBySkills = "Sort by skills" ;
  static const sortBySalary = "Sort by salary" ;
  static const sortByLocation = "Sort by location" ;
  static const sortByJobTitle = "Sort by job title" ;

  static const searchSkills = "Search Skills" ;
  static const searchTools = "Search Tools" ;
  static const searchSalary = "Search Salary" ;
  static const searchLocation = "Search Location" ;
  static const searchJobTitle = "Search Job Title" ;


 //Inbox
  static const all = "All" ;
  static const superMessages = "Super Messages" ;
  static const favorites = "Favourites" ;


  //Setting

  static const aboutUsContent = 'In 2022, finding a job is really hard. Hiring for a job is just as hard. Job matching shouldn’t be hard. So we created Highlite to make your job search / hiring process simpler. We hope you enjoy it!';
  static const termsOfUseContent = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  static const privacyPolicyContent = 'Last Updated: June 2022\n\nWe at 0260 Labs LLC, accessible from www.0260labs.com, take the privacy of our visitors very seriously. This Privacy Policy document contains types of information that is collected and recorded by 0260 Labs LLC and how we use it. If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us. This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in 0260 Labs LLC. This policy is not applicable to any information collected offline or via channels other than this website.\n\nConsent\n\nBy using our website, you hereby consent to our Privacy Policy and agree to its terms.\n\nInformation We Collect\n\nThe personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information. If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.';
  static const openSourceLibraryContent = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';



  // Post
  static const noPostYet = 'No Post Yet';


}