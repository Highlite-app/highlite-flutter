
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/question_model.dart';

import '../../fixtures/fixture_reader.dart';

void main(){
  const question = "Whats your name";
  const tQuestionsModel =  QuestionsModel(question: question) ;
  test("Should be the subclass of Question Entity", () async {

    expect(tQuestionsModel, Function<OnBoardingQuestions>() isA){

    }
  });

  group('fromJson', () {
    
    test("should return a valid model when JSON questions is a String", () async{
      final Map<String , dynamic> jsonMap =
          json.decode(fixture('question.json'));

      final result = QuestionsModel.fromJson(jsonMap);
      
      expect(result, tQuestionsModel);

    });
  });
  
  group('toJson', () {
    
    test("should return a JSON map containing the proper data", () {


      var result = const QuestionsModel(question: question)..toJson() ;

      final expectedMap = {"question": "Whats your name"};
      
      expect(result, expectedMap) ;
      
    });
  });

}