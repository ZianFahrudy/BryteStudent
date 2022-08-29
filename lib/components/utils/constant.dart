class Url {
  static const String baseUrlProdProd = "https://ws-dev.prasetiyamulya.ac.id/";
  static const String baseUrlProdProdProdProd =
      "https://endpoint.prasetiyamulya.ac.id/";
  static const String baseUrlProdProdMoodleProd =
      "https://lms.prasetiyamulya.ac.id/";

  static const String login = baseUrlProdProdMoodleProd + "login/token.php";
  static const String forgotPassword =
      baseUrlProdProd + "ws_bryte/public/forgotPassword";
  static const String verifyOtp = baseUrlProdProd + "ws_bryte/public/verifyOtp";
  static const String resetPass =
      baseUrlProdProd + "ws_bryte/public/resetPassword";
  static const String resenOTP = baseUrlProdProd + "ws_bryte/public/resendOtp";

  static const String classSummaryStudent =
      baseUrlProdProdProdProd + "ws_bryte/public/classesSummaryStudent";

  static const String announcement =
      baseUrlProdProd + "ws_bryte/public/announcement";
  static const String classesDetStudent =
      baseUrlProdProdProdProd + "ws_bryte/public/classesDetStudent";
  static const String upcomingAssignStudent =
      baseUrlProdProdProdProd + "ws_bryte/public/upcomingAssignStudent";
  static const String authorization =
      baseUrlProdProdProdProd + "ws_bryte/public/authorization";
  static const String calendarEvent =
      baseUrlProdProd + "ws_bryte/public/calendarEventDet";
  static const String attendance =
      baseUrlProdProdMoodleProd + "webservice/rest/server.php";

  static const String generalCourse =
      baseUrlProdProdMoodleProd + "webservice/rest/server.php";

  static const String course =
      baseUrlProdProd + "ws_bryte/public/courseStudent";
  static const String assignment =
      baseUrlProdProd + "ws_bryte/public/courseAssignStudent";

  static const String profile =
      baseUrlProdProdMoodleProd + "webservice/rest/server.php";
  static const String detailAssignment =
      baseUrlProdProdProdProd + "ws_bryte/public/assignDetStudent";

  static const String assignmentPerCourse =
      baseUrlProdProd + "ws_bryte/public/assignPerCourseStudent";

  static const String attendanceCourse =
      baseUrlProdProd + "ws_bryte/attdDetPerCourseStudent";

  static const String uploadFile =
      baseUrlProdProd + "moodle/webservice/upload.php";
  static const String assignSaveFile =
      baseUrlProdProd + "moodle/webservice/rest/server.php";
}

// key constant
class KeyConstant {
  static const token = 'KeyToken';
  static const role = 'KeyRole';
  static const username = 'KeyUsername';
  static const userId = 'KeyUserId';
}

class SharedConstant {
  static const wstoken = 'c66dcf796b6cf10d0971da5b7c027847';
  static const wsfunction = 'mod_attendance_update_user_status';
  static const moodlewsrestformat = 'json';
}

class AssetConstant {
  static const noClassToday = 'assets/rummage/empty-no-classes.png';
  static const noAssignment = 'assets/rummage/empty-no-assignment.png';
  static const noClassesLeft = 'assets/rummage/empty-classes-left.png';
  static const noAnnouncement = 'assets/rummage/empty-no-announcement.png';
  static const error = 'assets/rummage/empty-error.png';
  static const connectionLost = 'assets/rummage/connection-lost.png';
  static const emptyCalendar = 'assets/rummage/empty-calendar.png';
  static const emptyCourseAssignmentWomen =
      'assets/rummage/empty-course-assignment-women.png';
  static const emptyCourseAssignmentMan =
      'assets/rummage/empty-course-assignment-man.png';
  static const bryteLogoWhite = 'assets/rummage/bryte-logo-white.png';
  static const bryteLogoWhite4x = 'assets/rummage/bryte-logo-white-4x.png';
  static const bryteLogoPurple = 'assets/rummage/bryte-logo-purple.png';
  static const bryteLogoSplash = 'assets/rummage/bryte-logo-splash.png';
  static const bryteLogoDarkPurple = 'assets/rummage/bryte-logo-darkpurple.png';
  static const prasmulSplash = 'assets/rummage/prasmul-splash.png';
  static const prasmul = 'assets/rummage/prasmul.png';
  static const emptyZzz = 'assets/rummage/empty-zzz.png';
  static const iconZoom = 'assets/rummage/icon_zoom.png';
  static const iconYoutube = 'assets/rummage/icon_youtube.png';
  static const iconUpload = 'assets/rummage/icon_upload.png';
  static const iconDownload = 'assets/rummage/icon_download.png';
}
