import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constants.dart';
import '../../constants/assets_path.dart';
import '../../constants/router/app_routes_list.dart';
import '../../providers/auth_form_provider.dart';
import '../../providers/auth_provider.dart';
import '../../shared/utils/screen_util.dart';
import '../../shared/validators/app_validators.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Future<void> _launchLink(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthFormProvider>(
      create: (_) => AuthFormProvider(
        enableName: true,
        enableConfirmPassword: true,
        enableTerms: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Account', style: TextStyle(fontSize: 18.h)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppScreenUtil.horizontalPadding(context),
              vertical: 16.h,
            ),
            child: Consumer2<AuthProvider, AuthFormProvider>(
              builder:
                  (
                    BuildContext context,
                    AuthProvider authProvider,
                    AuthFormProvider formProvider,
                    _,
                  ) {
                    return Form(
                      key: formProvider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                              AssetsPath.logoImagePath,
                              height: 75.h,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Get Started with BYAMN',
                            style: TextStyle(
                              fontSize: 25.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Create your account in under a minute.',
                            style: TextStyle(
                              fontSize: 14.h,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          TextFormField(
                            controller: formProvider.nameController,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: formProvider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: AppValidators.email,
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: formProvider.passwordController,
                            obscureText: formProvider.obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: formProvider.togglePassword,
                                icon: Icon(
                                  formProvider.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            validator: AppValidators.password,
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: formProvider.confirmPasswordController,
                            obscureText: formProvider.obscureConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
                              suffixIcon: IconButton(
                                onPressed: formProvider.toggleConfirmPassword,
                                icon: Icon(
                                  formProvider.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            validator: (String? value) =>AppValidators.confirmPassword(
                                    value,
                                    formProvider.passwordController.text,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: formProvider.termsAccepted,
                                onChanged: (bool? value) => formProvider
                                    .setTermsAccepted(value ?? false),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.h,
                                      color: Colors.grey.shade700,
                                    ),
                                    children: <InlineSpan>[
                                      const TextSpan(text: 'I agree to '),
                                      TextSpan(
                                        text: 'Terms',
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => _launchLink(
                                            AppConstants.termsUrl,
                                          ),
                                      ),
                                      const TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => _launchLink(
                                            AppConstants.privacyUrl,
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      if (!formProvider.validate()) return;
                                      if (!formProvider.termsAccepted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please accept terms and privacy policy',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      final bool ok = await authProvider
                                          .signUpWithEmail(
                                            name: formProvider
                                                .nameController
                                                .text
                                                .trim(),
                                            email: formProvider
                                                .emailController
                                                .text
                                                .trim(),
                                            password: formProvider
                                                .passwordController
                                                .text,
                                          );
                                      if (ok && context.mounted) {
                                        context.go(
                                          RouteList.homeShellRoutePath,
                                        );
                                      }
                                    },
                              child: authProvider.isLoading
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Create account',
                                      style: TextStyle(fontSize: 15.h),
                                    ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      final bool ok = await authProvider
                                          .signInWithGoogle();
                                      if (ok && context.mounted) {
                                        context.go(
                                          RouteList.homeShellRoutePath,
                                        );
                                      }
                                    },
                              icon: Image.asset(
                                AssetsPath.googleImagePath,
                                height: 22.h,
                              ),
                              label: Text(
                                'Sign up with Google',
                                style: TextStyle(fontSize: 14.h),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Center(
                            child: TextButton(
                              onPressed: () => context.pop(),
                              child: Text(
                                'Already have an account? Sign in',
                                style: TextStyle(fontSize: 13.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
            ),
          ),
        ),
      ),
    );
  }
}
