import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:school_daashboard/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:school_daashboard/features/programs/presentation/bloc/programs_bloc.dart';
import 'package:school_daashboard/features/section/presentation/bloc/section_bloc.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/lessons_bloc.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/subject_bloc.dart';
import 'package:school_daashboard/features/teacher/presentation/bloc/teacher_bloc.dart';
import 'package:school_daashboard/features/users/presentation/bloc/users_bloc.dart';

import 'core/config/theme/dark_theme.dart';
import 'core/config/theme/light_theme.dart';
import 'features/examps/presentation/bloc/examps_bloc.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'features/type/presentation/bloc/type_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => ExampsBloc(),
      ),
      BlocProvider(
        create: (context) => SubjectBloc()..add(GetSubjectsEvent()),
      ),
      BlocProvider(
        create: (context) => LessonsBloc()..add(IndexLessonsEvent()),
      ),
      BlocProvider(
        create: (context) => SectionBloc()..add(IndexSectionsEvent()),
      ),
      BlocProvider(
        create: (context) => TypeBloc()..add(IndexTypesEvent()),
      ),
      BlocProvider(
        create: (context) => TeacherBloc()..add(IndexTeachersEvent()),
      ),
      BlocProvider(
        create: (context) => NotificationBloc(),
      ),
      BlocProvider(
        create: (context) => ProgramsBloc()..add(IndexProgramsEvent()),
      ),
      BlocProvider(
        create: (context) => UsersBloc()..add(GetUsersEvent()),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1070),
      minTextAdapt: true,
      enableScaleText: () {
        return true;
      },
      ensureScreenSize: true,
      splitScreenMode: false,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: LightTheme.getTheme(),
          darkTheme: DarkTheme.getTheme(),
          themeMode: ThemeMode.light,
          builder: BotToastInit(),
          home: const SplashScreen(),
          navigatorObservers: [BotToastNavigatorObserver()],
        ),
      ),
    );
  }
}
