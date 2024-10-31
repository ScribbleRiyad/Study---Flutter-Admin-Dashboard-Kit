import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:study/helpers/services/auth_service.dart';
import 'package:study/views/auth/fotgot_password_screen.dart';
import 'package:study/views/auth/login_screen.dart';
import 'package:study/views/auth/reset_password_screen.dart';
import 'package:study/views/auth/sign_up_screen.dart';
import 'package:study/views/dashboard.dart';
import 'package:study/views/ui/cart_screen.dart';
import 'package:study/views/ui/chat_screen.dart';
import 'package:study/views/ui/courses/courses_add_screen.dart';
import 'package:study/views/ui/courses/courses_detail_screen.dart';
import 'package:study/views/ui/courses/courses_edit_screen.dart';
import 'package:study/views/ui/courses/courses_list_screen.dart';
import 'package:study/views/ui/courses_screen.dart';
import 'package:study/views/ui/home_screen.dart';
import 'package:study/views/ui/organization/organization_add_screen.dart';
import 'package:study/views/ui/organization/organization_edit_screen.dart';
import 'package:study/views/ui/organization/organization_list_screen.dart';
import 'package:study/views/ui/setting_screen.dart';
import 'package:study/views/ui/students/student_add_screen.dart';
import 'package:study/views/ui/students/student_detail_screen.dart';
import 'package:study/views/ui/students/student_edit_screen.dart';
import 'package:study/views/ui/students/student_list_screen.dart';
import 'package:study/views/ui/subscription/subscription_detail_screen.dart';
import 'package:study/views/ui/subscription/subscription_list_screen.dart';
import 'package:study/views/ui/subscription_screen.dart';
import 'package:study/views/ui/teacher/teacher_edit_screen.dart';
import 'package:study/views/ui/teacher/teacher_add_screen.dart';
import 'package:study/views/ui/teacher/teacher_detail_screen.dart';
import 'package:study/views/ui/teacher/teacher_list_screen.dart';
import 'package:study/views/ui/teacher_dashboard.dart';
import 'package:study/views/ui/wallet_screen.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
        name: '/', page: () => HomeScreen(), middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard',
        page: () => Dashboard(),
        middlewares: [AuthMiddleware()]),

    /// Teacher Dashboard
    GetPage(
        name: '/teacher_dashboard',
        page: () => TeacherDashboardScreen(),
        middlewares: [AuthMiddleware()]),

    /// ********** AUTH ********** ///

    GetPage(
      name: '/auth/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/auth/sign_up',
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: '/auth/forgot_password',
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: '/auth/reset_password',
      page: () => ResetPasswordScreen(),
    ),

    /// ********** CLIENT APP ********** ///

    GetPage(
        name: '/client/home',
        page: () => HomeScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/client/courses',
        page: () => CoursesScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/client/cart',
        page: () => CartScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/client/subscription',
        page: () => SubscriptionScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/client/chat',
        page: () => ChatScreen(),
        middlewares: [AuthMiddleware()]),

    /// ********** ADMIN ********** ///

    /// Subscription
    GetPage(
        name: '/admin/subscription/list',
        page: () => SubscriptionListScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/subscription/detail',
        page: () => SubscriptionDetailScreen(),
        middlewares: [AuthMiddleware()]),

    /// Students
    GetPage(
        name: '/admin/students/list',
        page: () => StudentListScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/students/detail',
        page: () => StudentDetailScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/students/add',
        page: () => StudentAddScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/students/edit',
        page: () => StudentEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// Teachers
    GetPage(
        name: '/admin/teacher/list',
        page: () => TeacherListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/teacher/detail',
        page: () => TeacherDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/teacher/add',
        page: () => TeacherAddScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/teacher/edit',
        page: () => TeacherEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// organization
    GetPage(
        name: '/admin/organization/list',
        page: () => OrganizationListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/organization/add',
        page: () => OrganizationAddScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/organization/edit',
        page: () => OrganizationEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// Courses
    GetPage(
        name: '/admin/Courses/list',
        page: () => CoursesListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/Courses/detail',
        page: () => CoursesDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/Courses/add',
        page: () => CoursesAddScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/Courses/edit',
        page: () => CoursesEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// Wallet
    GetPage(
        name: '/admin/wallet',
        page: () => WalletScreen(),
        middlewares: [AuthMiddleware()]),

    /// Setting
    GetPage(
        name: '/admin/setting',
        page: () => SettingScreen(),
        middlewares: [AuthMiddleware()]),
  ];
  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
