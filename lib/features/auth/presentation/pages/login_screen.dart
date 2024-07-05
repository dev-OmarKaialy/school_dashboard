import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/string_extensions.dart';
import 'package:school_daashboard/core/config/theme/light_theme.dart';
import 'package:school_daashboard/core/global_functions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/config/extensions/context_extensions.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../main/presentation/pages/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.status == CubitStatus.loading) {
          Toaster.showLoading();
        } else {
          Toaster.closeLoading();
          if (state.status == CubitStatus.success) {
            await GlobalFunctions()
                .setUserInfo(accessToken: state.user?.accessToken);

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const MainScreen();
              },
            ));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: const BoxDecoration(
                color: LightThemeColors.linearThirdColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      LightThemeColors.primaryColor, BlendMode.color),
                  image: AssetImage(
                    'assets/background.png',
                  ),
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: LightThemeColors.linearThirdColor),
                  width: .43.sw,
                  height: 0.68.sh,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: .02.sw, vertical: .02.sw),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Login To Your Account',
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: context.primaryColor)),
                          Text(
                              'Please enter your email and password to continue',
                              style: context.textTheme.titleSmall),
                          MainTextField(
                            text: 'Email address:',
                            hint: 'example@mail.com',
                            height: .08.sh,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            validator: (p0) {
                              if (p0 != null && p0.validateEmail()) {
                                return null;
                              } else {
                                return 'Oops! That doesn\'t look like a valid email. Please try again.';
                              }
                            },
                          ),
                          MainTextField(
                            text: 'Password:',
                            hint: '●●●●●●●●',
                            isPassword: true,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
                            },
                            height: .08.sh,
                            controller: passwordController,
                            validator: (value) {
                              if (value != null && value.isValidPassword) {
                                return null;
                              } else {
                                return 'Password must be at least 8 characters long';
                              }
                            },
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forget Password?'),
                            ),
                          ),
                          MainButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
                            },
                            width: 1.sw,
                            height: .08.sh,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
