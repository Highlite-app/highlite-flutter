import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:highlite_flutter_mvp/core/constants/user_types.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/company_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/default_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/general/general_flow.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/username_generator.dart';

class FirebaseService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static const String signUpGoogle  = TranslationKeys.signUpGoogle ;
  static const String signUpApple  = TranslationKeys.signUpApple ;
  static const String signUpEmail  = TranslationKeys.signUpEmailAddress ;
  static const String signUpFacebook  = TranslationKeys.signUpFacebook ;

  static Future<String?> sociallyAuthenticate({required String authProvider}) async {
    switch(authProvider){
      case signUpGoogle:
        debugPrint("Google Signin");
       return signInWithGoogle() ;
      case signUpEmail:
        //return signInWithGoogle();
         debugPrint("Coming Soon");
      case signUpApple:
        //return signInWithGoogle();
         debugPrint("Coming Soon");
      case signUpFacebook:
        debugPrint("Facebook SignIn");
      //  return _handleFacebookLogin();
      default:
         return null;
    }
    return null;
  }

  static Future<String?> signInWithGoogle() async {

    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) return null; // User canceled the sign-in process

      // Get GoogleSignInAuthentication
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      // Create a new credential using the GoogleSignInAuthentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the Google Auth credentials
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      //Adding  User Details//
      print("The user type is ::${GeneralFlowTags.userType}");
      if(GeneralFlowTags.userType == UserTypes.candidate){
        CandidateTags.firstName = authResult.user?.displayName?.split(" ").first  ?? "";
        CandidateTags.lastName = authResult.user?.displayName?.split(" ").last  ?? "";
        DefaultTags.email = authResult.user?.email ?? "" ;
        DefaultTags.username   = UserNameGenerator().getUserName(CandidateTags.firstName,  CandidateTags.lastName);
      }else {
        CompanyTags.email = authResult.user?.email ?? "" ;
        CompanyTags.userName   = UserNameGenerator().getUserName(CompanyFlowTags.companyName,  CompanyTags.website);

      }

      // Return the signed-in user
       FirebaseConstant.providerId =   authResult.additionalUserInfo?.providerId ?? '' ;
      return authResult.user?.email;
    } catch (e) {
      logger.logEvent("Error signing in with Google: $e" , tag: "FIREBASE ERROR");
      return null;
    }
  }

  static Future<String?> _handleFacebookLogin() async {
    try {
      // Trigger Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      // Check if the login was successful
      if (result.status == LoginStatus.success) {
        // Obtain the user's Facebook credentials
        final AccessToken accessToken = result.accessToken!;

        // Authenticate with Firebase using Facebook credentials
        final OAuthCredential credential =
        FacebookAuthProvider.credential(accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(credential);


        // User is now signed in with Facebook
        print('User signed in with Facebook: ${FirebaseAuth.instance.currentUser!.displayName}');
        print('User signed in with Facebook email: ${FirebaseAuth.instance.currentUser!.email}');
      } else {
        // Facebook login failed
        print('Facebook login failed');
      }
    } catch (e) {
      print('Error during Facebook login: $e');
    }
    print("The Facebook signin email is :::::${FirebaseAuth.instance.currentUser?.email}");
    return FirebaseAuth.instance.currentUser?.email ;
  }


  static Future<String> storeImageInFirebaseStorage(File image) async{
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageReference.putFile(image);
      try {
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
       return downloadUrl ;
      } catch (e) {
        throw Exception("Firebase Upload image issue $e");
      }
    } catch (e) {

    throw Exception("Error creating storage Instance: $e");

    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}