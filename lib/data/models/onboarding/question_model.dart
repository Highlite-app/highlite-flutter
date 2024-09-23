import 'package:highlite_flutter_mvp/domain/entites/onboarding/onboarding_questions.dart';

class QuestionsModel extends OnBoardingQuestions{
 const  QuestionsModel({required String  question}):super(question: question);

  factory QuestionsModel.fromJson(Map<String , dynamic> json){
   return QuestionsModel(question: json['question']);
  }

   Map<String ,dynamic> toJson() {
   return
    {"question": question};
 }

}