import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:icon/global/theme/bloc/theme_bloc.dart';
import 'package:icon/repositories/public_user_info_repository.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/utils/simple_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

Future main() async {
  /// Ensure Initialized
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load();

  // configure Icon Network
  _configureIconNetwork();

  runApp(MyApp());
}

Future<void> _configureIconNetwork() async {
  await FlutterIconNetwork.instance
      ?.init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
          ),
          // RepositoryProvider<TaskRepository>(
          //   create: (context) => TaskRepository(),
          // ),
          RepositoryProvider<PublicInfoRepository>(
            create: (context) => PublicInfoRepository(),
          ),
          // RepositoryProvider<ProjectRepository>(
          //   create: (context) => ProjectRepository(),
          // ),
          // RepositoryProvider<QuickNoteRepository>(
          //   create: (context) => QuickNoteRepository(),
          // ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(
              create: (context) =>
                  SectionCubit(userRepository: context.read<UserRepository>()),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, theme) => _buildWithTheme(theme),
          ),
        ),
      ),
    );
  }

  MaterialApp _buildWithTheme(ThemeData theme) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ICON",
      theme: theme,
      navigatorKey: Routes.rootNavigatorKey,
      initialRoute: RouteNames.initial,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
