import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_taxi/core/screens/home/data/sourceAddressRepository.dart';
import 'package:get_taxi/core/screens/main/main_page.dart';
import 'package:get_taxi/repository_data/UserDataRepository.dart';
import 'package:get_taxi/router/custom_router.dart';

import 'bloc/show_loader_cubit.dart';
import 'core/screens/home/bloc/source_address_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child(
    "users");


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SourceAddressRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserDataRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShowLoaderCubit(),
          ),
          BlocProvider(
            create: (context) => SourceAddressCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.generateRoute,
          initialRoute: CustomRouter.initialPage,
          title: 'Flutter Demo',
          theme: ThemeData(
            // fontFamily: FontFamilyConstant.brandBold,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Colors.black,
            primaryColor: Colors.yellowAccent,
            appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.yellow.shade800
            ),
            brightness: Brightness.dark,

          ),
          home: const MainPage(),
        ),
      ),
    );
  }
}
