import 'package:blogapp/core/constants/screens.dart';
import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/core/theme/theme.dart';
import 'package:blogapp/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogapp/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_sign_up.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_signin.dart';
import 'package:blogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:blogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/feature/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(supabase.client),
            ),
          ),
          userSignIn: UserSignIn(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: screens,
        title: 'Blog App Post',
        theme: AppTheme.darkTheme,
        home: SignInPage());
  }
}
