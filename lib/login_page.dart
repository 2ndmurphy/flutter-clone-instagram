import 'package:flutter/material.dart';
import 'extensions.dart';
import 'register_page.dart';
import 'temp_user_storage.dart';
import 'package:login_register_instagram/dashboard/dashboard_instagram.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // User data di hardcoded
    // const hardcodedUsers = {
    //   'user@example.com': 'password123',
    //   'murphy@genz.com': 'genzpower',
    //   'test@insta.com': 'instapass',
    // };

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email == TempUserStorage.email &&
          password == TempUserStorage.password) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardInstagram()),
          );
          // context.showSnackBar('Login successful!');
        }
        return;
      } else {
        if (mounted) {
          context.showSnackBar('Invalid email or password', isError: true);
        }
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Login failed. Please try again.', isError: true);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email or username';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 20 : 40,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo Instagram
                        Center(
                          child: Text(
                            'Instagram',
                            style: TextStyle(
                              fontFamily: 'Billabong',
                              fontSize: isSmallScreen ? 50 : 60,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Email field
                        TextFormField(
                          controller: _emailController,
                          validator: validateEmail,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: validatePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF00376B),
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerRight,
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Login button
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            child:
                                _isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text('Log in'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // OR divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Login with Facebook
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.facebook,
                            color: Color(0xFF385185),
                          ),
                          label: const Text(
                            'Log in with Facebook',
                            style: TextStyle(
                              color: Color(0xFF385185),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Sign up option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign up.',
                                style: TextStyle(
                                  color: Color(0xFF0095F6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
