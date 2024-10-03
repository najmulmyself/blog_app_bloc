import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependancy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependancies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
          // service locator does not know which bloc to pass
          // so we need to pass the type of bloc
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      title: 'Material App',
      home: const LoginPage(),
    );
  }
}
