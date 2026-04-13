import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../providers/auth_form_provider.dart';
import '../../providers/auth_provider.dart';
import '../../shared/utils/screen_util.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthFormProvider>(
      create: (_) => AuthFormProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password', style: TextStyle(fontSize: 18.h)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppScreenUtil.horizontalPadding(context),
              vertical: 20.h,
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
                        children: <Widget>[
                          Image.asset(
                            AssetsPath.forgetPasswordImagePath,
                            height: 180.h,
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            'Reset your password',
                            style: TextStyle(
                              fontSize: 24.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Enter your email and we will send a reset link.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.h,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            controller: formProvider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 14.h),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      if (!formProvider.validate()) return;
                                      await authProvider.sendResetPassword(
                                        formProvider.emailController.text
                                            .trim(),
                                      );
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Reset link sent (demo mode supported).',
                                            ),
                                          ),
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
                                      'Send reset link',
                                      style: TextStyle(fontSize: 15.h),
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
