import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cravecrush/screens/signup_screen.dart'; // Import your sign-up page
import 'package:cravecrush/screens/home_screen.dart'; // Import your home page
import 'package:cravecrush/screens/forgot_password_screen.dart'; // Import your forgot password page

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false; // Track password visibility
  String _errorMessage = '';

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to home page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print('Failed to sign in with email and password: $e');
      setState(() {
        // Set error message based on authentication failure
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            _errorMessage = 'No user found with this email.';
          } else if (e.code == 'wrong-password') {
            _errorMessage = 'Incorrect password.';
          } else {
            _errorMessage = 'Incorrect Credentials';
          }
        } else {
          _errorMessage = 'Incorrect Credentials';
        }
      });
    }
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  void _navigateToForgotPasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login.png',
            fit: BoxFit.cover,
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 18), // Padding around the container
            child: Container(
              height: MediaQuery.of(context).size.height / 2.3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                // Semi-transparent background color
                // Rounded corners
                border: Border.all(
                    color: Colors.white, width: 1), // Border color and width
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        const Text(
                          'Welcome Back!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.email, color: Colors.white),
                            // Icon color
                            labelStyle: TextStyle(
                                color: Colors.white), // Label text color
                          ),
                          style: const TextStyle(color: Colors.white),
                          // Input text color
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // You can add more complex email validation if needed
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            icon: const Icon(Icons.lock, color: Colors.white),
                            // Icon color
                            labelStyle: const TextStyle(color: Colors.white),
                            // Label text color
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons
                                    .visibility_off,
                                color: Colors.white, // Icon color
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          // Input text color
                          obscureText: !_isPasswordVisible,
                          // Toggle password visibility
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            // You can add more complex password validation if needed
                            return null;
                          },
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signInWithEmailAndPassword(context);
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                        const SizedBox(height: 3),
                        TextButton(
                          onPressed: () => _navigateToSignUpPage(context),
                          child: const Text('Don\'t have an account? Sign Up'),
                        ),
                        const SizedBox(height: 3),
                        TextButton(
                          onPressed: () =>
                              _navigateToForgotPasswordPage(context),
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}