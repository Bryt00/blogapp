import 'package:blogapp/core/constants/screens.dart';
import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/core/theme/theme.dart';
import 'package:blogapp/core/utils/showsnackbar.dart';
import 'package:blogapp/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogapp/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:blogapp/feature/auth/domain/UseCases/current_user.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_sign_up.dart';
import 'package:blogapp/feature/auth/domain/UseCases/user_signin.dart';
import 'package:blogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/feature/auth/presentation/pages/signin_page.dart';
import 'package:blogapp/feature/auth/presentation/pages/signup_page.dart';
import 'package:blogapp/feature/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await sb.Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(bloc.MultiBlocProvider(
    providers: [
      bloc.BlocProvider(
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
          currentUser: CurrentUser(
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCurrentUser());

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: screens,
        title: 'Blog Post App',
        theme: AppTheme.darkTheme,
        home: bloc.BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return const BlogPage();
            }
            return const SignInPage();
          },
        ));
  }
}
