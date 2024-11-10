import 'package:flutter/material.dart';
import "register_page.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = false;
  String? _emailError;
  String? _passwordError;
  bool _rememberMe = false; // New variable to track "Remember Me"

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _loadPreferences(); // Load saved preferences when the page is loaded
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = _emailController.text.contains('@');
      if (_isEmailValid) {
        _emailError = null; // Clear error if email is valid
      }
    });
  }

  void _validateLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      // Validate email
      if (email.isEmpty) {
        _emailError = 'Please enter your email';
      } else if (!_isEmailValid) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null; // Clear error if valid
      }

      // Validate password
      if (password.isEmpty) {
        _passwordError = 'Please enter your password';
      } else {
        _passwordError = null; // Clear error if valid
      }
    });

    // Perform login if both fields are valid
    if (_emailError == null && _passwordError == null) {
      if (_rememberMe) {
        _savePreferences(
            email, password); // Save credentials if "Remember Me" is checked
      }
      print('Logging in with email $email and password $password');
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  // Save login data if Remember Me is checked
  void _savePreferences(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Load saved preferences if Remember Me was checked previously
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      String email = prefs.getString('email') ?? '';
      String password = prefs.getString('password') ?? '';
      setState(() {
        _rememberMe = rememberMe;
        _emailController.text = email;
        _passwordController.text = password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(color: Colors.white),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[800],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Hi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        _buildTextField(
                          context,
                          controller: _emailController,
                          labelText: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: (_emailController.text.isNotEmpty)
                              ? (_isEmailValid
                                  ? Icons.check_circle
                                  : Icons.cancel)
                              : null,
                          errorText: _emailError,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          context,
                          controller: _passwordController,
                          labelText: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          errorText: _passwordError,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            Text('Remember Me'),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _validateLogin,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'PROCEED',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Don’t have an account?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()),
                                  );
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.deepPurple[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    IconData? suffixIcon,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon,
                color: suffixIcon == Icons.check_circle
                    ? Colors.green
                    : Colors.red)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        errorText: errorText,
      ),
    );
  }
}
