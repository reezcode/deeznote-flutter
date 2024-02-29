import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/create_meet/bindings/create_meet_binding.dart';
import '../modules/create_meet/views/create_meet_view.dart';
import '../modules/detail_meet/bindings/detail_meet_binding.dart';
import '../modules/detail_meet/views/detail_meet_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/help_support/bindings/help_support_binding.dart';
import '../modules/help_support/views/help_support_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/meeting_notes/bindings/meeting_notes_binding.dart';
import '../modules/meeting_notes/views/meeting_notes_view.dart';
import '../modules/meeting_photo/bindings/meeting_photo_binding.dart';
import '../modules/meeting_photo/views/meeting_photo_view.dart';
import '../modules/meeting_sign/bindings/meeting_sign_binding.dart';
import '../modules/meeting_sign/views/meeting_sign_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_MEET,
      page: () => const CreateMeetView(),
      binding: CreateMeetBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MEET,
      page: () => const DetailMeetView(),
      binding: DetailMeetBinding(),
    ),
    GetPage(
      name: _Paths.MEETING_NOTES,
      page: () => const MeetingNotesView(),
      binding: MeetingNotesBinding(),
    ),
    GetPage(
      name: _Paths.MEETING_SIGN,
      page: () => const MeetingSignView(),
      binding: MeetingSignBinding(),
    ),
    GetPage(
      name: _Paths.MEETING_PHOTO,
      page: () => const MeetingPhotoView(),
      binding: MeetingPhotoBinding(),
    ),
  ];
}
