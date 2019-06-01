/// Dataclass for defining questions in the [QuestionCarousel] or the [Question] widget.
///
class QuestionData {
  String quizId;
  String questionId;
  int likertPoints;
  String question;
  String category;
  String fileName;

  String freeText;
  bool isFreeText;
  bool isLikert;

  bool scoringReversed;
  int _score;
  List<String> labels;
  bool showNumbers;

  int get score => _score;

  QuestionData({
    this.likertPoints,
    this.question,
    this.quizId,
    this.fileName,
    this.category = "Default",
    this.scoringReversed = false,
    this.freeText = "",
    this.isFreeText = false,
    this.isLikert = true,
    this.questionId,
    this.labels,
    this.showNumbers = true,
  });

  /// Sets the _score.
  ///
  /// The method takes into account if the scoring is reversed.
  void setScore(int result) {
    scoringReversed ? _score = reverseScoring(result) : _score = result;
  }

  int reverseScoring(int result) {
    return (likertPoints - 1) - result;
  }

  /// The original value entered on the [LikertScale]
  int likertValue() {
    if (_score == null) {
      return null;
    } else if (scoringReversed) {
      return reverseScoring(_score);
    } else {
      return _score;
    }
  }

  hasNoAnswer() {
    return _score == null;
  }

  void printMeShort() {
    String toPrint = "category: $category - " +
        "_score: ${_score.toString()} - " +
        "question: $question";

    print(toPrint);
  }

  void printMe() {
    String toPrint = "quizId: ${this.quizId}\n"
        "questionId: ${this.questionId}\n"
        "likertPoints: ${this.likertPoints}\n"
        "question: ${this.question}\n"
        "category: ${this.category}\n"
        "fileName: ${this.fileName}\n"
        "scoringReversed: ${this.scoringReversed}\n"
        "_score: ${this._score}\n"
        "labels: ${this.labels}\n";

    print(toPrint);
  }
}
