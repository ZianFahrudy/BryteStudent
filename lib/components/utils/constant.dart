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
  static const String calendarEvent =
      baseUrl + "ws_bryte/public/calendarEventDet";
  static const String attendance =
      baseUrl + "moodle/webservice/rest/server.php";

  static const String generalCourse =
      baseUrl + "moodle/webservice/rest/server.php";

  static const String course = baseUrl + "ws_bryte/public/courseStudent";
  static const String assignment =
      baseUrl + "ws_bryte/public/courseAssignStudent";

  static const String profile = baseUrl + "moodle/webservice/rest/server.php";
  static const String detailAssignment =
      baseUrl + "ws_bryte/public/assignDetStudent";

  static const String assignmentPerCourse =
      baseUrl + "ws_bryte/public/assignPerCourseStudent";

  static const String attendanceCourse =
      baseUrl + "ws_bryte/public/attdDetPerCourseStudent";
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
  static const iconDownload = 'assets/icon_download.png';
}
