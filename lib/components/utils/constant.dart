class Url {
  static const String baseUrlMoodleDev = "https://ws-dev.prasetiyamulya.ac.id/";
  static const String baseUrlDev = "https://be-dev.prasetiyamulya.ac.id/";

  static const String baseUrlProd = "https://endpoint.prasetiyamulya.ac.id/";
  static const String baseUrlMoodleProd = "https://lms.prasetiyamulya.ac.id/";

  static const String login = baseUrlMoodleDev + "moodle/login/token.php";

  static const String forgotPassword = "ws-bryte/public/forgotPassword";
  static const String verifyOtp = "ws-bryte/public/verifyOtp";
  static const String resetPass = "ws-bryte/public/resetPassword";
  static const String resenOTP = "ws-bryte/public/resendOtp";

  static const String classSummaryStudent =
      "ws-bryte/public/classesSummaryStudent";

  static const String announcement = "ws-bryte/public/announcement";
  static const String classesDetStudent = "ws-bryte/public/classesDetStudent";
  static const String upcomingAssignStudent =
      "ws-bryte/public/upcomingAssignStudent";
  static const String authorization = "ws-bryte/public/authorization";
  static const String calendarEvent = "ws-bryte/public/calendarEventDet";
  static const String attendance =
      baseUrlMoodleDev + "moodle/webservice/rest/server.php";

  static const String generalCourse =
      baseUrlMoodleDev + "moodle/webservice/rest/server.php";

  static const String course = "ws-bryte/public/courseStudent";
  static const String assignment = "ws-bryte/public/courseAssignStudent";

  static const String profile =
      baseUrlMoodleDev + "moodle/webservice/rest/server.php";
  static const String detailAssignment = "ws-bryte/public/assignDetStudent";

  static const String assignmentPerCourse =
      "ws-bryte/public/assignPerCourseStudent";

  static const String attendanceCourse = "ws-bryte/attdDetPerCourseStudent";

  static const String uploadFile =
      baseUrlMoodleDev + "moodle/webservice/upload.php";
  static const String assignSaveFile =
      baseUrlMoodleDev + "moodle/webservice/rest/server.php";

  // * academic period student
  static const String academicPeriodStudent = "ws-bryte/getAperiodPerStudent";

  // * attendance rate per student => 56
  static const String attendanceRateStudent = "ws-bryte/getAttdRatePerStudent";

  // * list semester student => 57
  static const String listSemesterStudent =
      "ws-bryte/getListSemesterPerStudent";

  // * list semester student => 57
  static const String finalGpaGrade = "ws-bryte/getFinalGpaGrade";

  // * course participant => 23
  static const String courseParticipant = "ws-bryte/courseParticipant";

  // * course participant => 23
  static const String courseScore = "ws-bryte/gradePerCourseStudent";

  // * master course section => 43
  static const String masterCourseSection = "ws-bryte/mstCourseSection";

  // * master course section => 59
  static const String editSubmission =
      baseUrlMoodleDev + "moodle/webservice/rest/server.php";
}

// key constant
class KeyConstant {
  static const token = 'KeyToken';
  static const role = 'KeyRole';
  static const username = 'KeyUsername';
  static const userId = 'KeyUserId';
  static const profileImage = 'KeyProfileImage';
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
  static const iconWhatsapp = 'assets/rummage/icon_whatsapp.png';
  static const iconInstagram = 'assets/rummage/icon_instagram.png';
}
