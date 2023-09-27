import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../domain/entities/user.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppStrings.regularFontFamily,
                      fontWeight: FontWeight.w700),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ));
            } else if (state is AuthSuccess) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const HomePage()));
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }
                return Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          AppConstants.outerPadding,
                          AppConstants.outerPadding * 2,
                          AppConstants.outerPadding,
                          0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                AppConstants.outerPadding,
                                AppConstants.outerPadding * 2,
                                AppConstants.outerPadding,
                                AppConstants.outerPadding * 2),
                            child: Text(
                              AppStrings.signInTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: AppStrings.regularFontFamily,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          AuthTextFormField(
                            controller: emailController,
                            hintText: "Enter Your Email",
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains("@")) {
                                return 'Valid Email Required';
                              }
                              return null;
                            },
                          ),
                          AuthTextFormField(
                            controller: passwordController,
                            hideText: true,
                            hintText: "Enter Your password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              AppConstants.outerPadding,
                              AppConstants.outerPadding,
                              AppConstants.outerPadding,
                              2,
                            ),
                            child: SizedBox(
                              height: context.screenHeight * 0.1,
                              width: context.screenWidth * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!(formKey.currentState?.validate() ??
                                      true)) {
                                    return;
                                  }
                                  final user = User(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignInEvent(user: user));
                                },
                                child: Text(
                                  AppStrings.signInTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: AppStrings.regularFontFamily,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpPage())),
                            child: Text(
                              AppStrings.doNotHaveAccount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: AppStrings.regularFontFamily,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
