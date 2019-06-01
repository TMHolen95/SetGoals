import 'package:augmented_goals/util/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:augmented_goals/questionnaire_system/question_carousel.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';

class BfiQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          title: Text("BFI Quiz"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Center(child: QuestionCarousel(
              bfi: true,
              onResults: (map) => print(map),
              onCategoryResult: (map) => FirestoreAPI.uploadBFI(map),
              showQuestionNumbers: true,
              showTotalQuestions: true,
              questionData: <QuestionData>[
                QuestionData(question: "I am someone who is talkative", category: "Extraversion", likertPoints: 5, scoringReversed: false),//  1 false
                QuestionData(question: "I am someone who tends to find fault with others", category: "Agreeableness", likertPoints: 5, scoringReversed: true),//  2 true
                QuestionData(question: "I am someone who does a thorough job", category: "Conscientiousness", likertPoints: 5, scoringReversed: false),//  3 false
                QuestionData(question: "I am someone who is depressed, blue", category: "Neuroticism", likertPoints: 5, scoringReversed: false),//  4 false
                QuestionData(question: "I am someone who is original, comes up with new ideas", category: "Openness", likertPoints: 5, scoringReversed: false),//  5 false
                QuestionData(question: "I am someone who is reserved", category: "Extraversion", likertPoints: 5, scoringReversed: true),//  6 true
                QuestionData(question: "I am someone who is helpful and unselfish with others", category: "Agreeableness", likertPoints: 5, scoringReversed: false),//  7 false
                QuestionData(question: "I am someone who can be somewhat careless", category: "Conscientiousness", likertPoints: 5, scoringReversed: true),//  8 true
                QuestionData(question: "I am someone who is relaxed, handles stress well.", category: "Neuroticism", likertPoints: 5, scoringReversed: true),//  9 true
                QuestionData(question: "I am someone who is curious about many different things", category: "Openness", likertPoints: 5, scoringReversed: false), //  10 false
                QuestionData(question: "I am someone who is full of energy", category: "Extraversion", likertPoints: 5, scoringReversed: false), //  11 false
                QuestionData(question: "I am someone who starts quarrels with others", category: "Agreeableness", likertPoints: 5, scoringReversed: true), //  12 true
                QuestionData(question: "I am someone who is a reliable worker", category: "Conscientiousness", likertPoints: 5, scoringReversed: false), //  13 false
                QuestionData(question: "I am someone who can be tense", category: "Neuroticism", likertPoints: 5, scoringReversed: false), //  14 false
                QuestionData(question: "I am someone who is ingenious, a deep thinker", category: "Openness", likertPoints: 5, scoringReversed: false), //  15 false
                QuestionData(question: "I am someone who generates a lot of enthusiasm", category: "Extraversion", likertPoints: 5, scoringReversed: false), //  16 false
                QuestionData(question: "I am someone who has a forgiving nature", category: "Agreeableness", likertPoints: 5, scoringReversed: false), //  17 false
                QuestionData(question: "I am someone who tends to be disorganized", category: "Conscientiousness", likertPoints: 5, scoringReversed: true), //  18 true
                QuestionData(question: "I am someone who worries a lot", category: "Neuroticism", likertPoints: 5, scoringReversed: false), //  19 false
                QuestionData(question: "I am someone who has an active imagination", category: "Openness", likertPoints: 5, scoringReversed: false), //  20 false
                QuestionData(question: "I am someone who tends to be quiet", category: "Extraversion", likertPoints: 5, scoringReversed: true), //  21 true
                QuestionData(question: "I am someone who is generally trusting", category: "Agreeableness", likertPoints: 5, scoringReversed: false), //  22 false
                QuestionData(question: "I am someone who tends to be lazy", category: "Conscientiousness", likertPoints: 5, scoringReversed: true), //  23 true
                QuestionData(question: "I am someone who is emotionally stable, not easily upset", category: "Neuroticism", likertPoints: 5, scoringReversed: true), //  24 true
                QuestionData(question: "I am someone who is inventive", category: "Openness", likertPoints: 5, scoringReversed: false), //  25 false
                QuestionData(question: "I am someone who has an assertive personality", category: "Extraversion", likertPoints: 5, scoringReversed: false), //  26 false
                QuestionData(question: "I am someone who can be cold and aloof", category: "Agreeableness", likertPoints: 5, scoringReversed: true), //  27 true
                QuestionData(question: "I am someone who perseveres until the task is finished", category: "Conscientiousness", likertPoints: 5, scoringReversed: false), //  28 false
                QuestionData(question: "I am someone who can be moody", category: "Neuroticism", likertPoints: 5, scoringReversed: false), //  29 false
                QuestionData(question: "I am someone who values artistic, aesthetic experiences", category: "Openness", likertPoints: 5, scoringReversed: false), //  30 false
                QuestionData(question: "I am someone who is sometimes shy, inhibited", category: "Extraversion", likertPoints: 5, scoringReversed: true), //  31 true
                QuestionData(question: "I am someone who is considerate and kind to almost everyone", category: "Agreeableness", likertPoints: 5, scoringReversed: false), //  32 false
                QuestionData(question: "I am someone who does things efficiently", category: "Conscientiousness", likertPoints: 5, scoringReversed: false), //  33 false
                QuestionData(question: "I am someone who remains calm in tense situations", category: "Neuroticism", likertPoints: 5, scoringReversed: true), //  34 true
                QuestionData(question: "I am someone who prefers work that is routine", category: "Openness", likertPoints: 5, scoringReversed: true), //  35 true
                QuestionData(question: "I am someone who is outgoing, sociable", category: "Extraversion", likertPoints: 5, scoringReversed: false), //  36 false
                QuestionData(question: "I am someone who is sometimes rude to others", category: "Agreeableness", likertPoints: 5, scoringReversed: true), //  37 true
                QuestionData(question: "I am someone who makes plans and follows through with them", category: "Conscientiousness", likertPoints: 5, scoringReversed: false), //  38 false
                QuestionData(question: "I am someone who gets nervous easily", category: "Neuroticism", likertPoints: 5, scoringReversed: false), //  39 false
                QuestionData(question: "I am someone who likes to reflect, play with ideas", category: "Openness", likertPoints: 5, scoringReversed: false), //  40 false
                QuestionData(question: "I am someone who has few artistic interests", category: "Openness", likertPoints: 5, scoringReversed: true), //  41 true
                QuestionData(question: "I am someone who likes to cooperate with others", category: "Agreeableness", likertPoints: 5, scoringReversed: false), //  42 false
                QuestionData(question: "I am someone who is easily distracted", category: "Conscientiousness", likertPoints: 5, scoringReversed: true), //  43 true
                QuestionData(question: "I am someone who is sophisticated in art, music, or literature", category: "Openness", likertPoints: 5, scoringReversed: false), //   44 false
              ],

              likertScalePoints: 5,
              labels: ["Disagree Strongly", "Agree Strongly"],
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Note: Only a numeric score on five personality traits is uploaded to the database. The answers to the questions are private and not stored."),
            ),
          ],
        ));
  }
}

