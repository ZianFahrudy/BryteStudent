class Url {
  static const String baseUrl = "https://ws-dev.prasetiyamulya.ac.id/";
  static const String login = baseUrl + "moodle/login/token.php";
  static const String forgotPassword =
      baseUrl + "ws_bryte/public/forgotPassword";
  static const String verifyOtp = baseUrl + "ws_bryte/public/verifyOtp";
  static const String resetPass = baseUrl + "ws_bryte/public/resetPassword";
  static const String resenOTP = baseUrl + "ws_bryte/public/resendOtp";

  static const String classSummaryStudent =
      baseUrl + "ws_bryte/public/classesSummaryStudent";

  static const String announcement = baseUrl + "ws_bryte/public/announcement";
  static const String classesDetStudent =
      baseUrl + "ws_bryte/public/classesDetStudent";
  static const String upcomingAssignStudent =
      baseUrl + "ws_bryte/public/upcomingAssignStudent";
  static const String authorization = baseUrl + "ws_bryte/public/authorization";
}

// key constant
class KeyConstant {
  static const token = 'KeyToken';
  static const role = 'KeyRole';
  static const username = 'KeyUsername';
  static const userId = 'KeyUserId';
}
