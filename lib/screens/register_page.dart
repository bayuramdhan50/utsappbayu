import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers untuk input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Error message
  String? _usernameError, _emailError, _passwordError, _confirmPasswordError;

  bool _isEmailValid = false; // Status validasi email

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan data user di SharedPreferences
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
    print('User data saved!');
  }

  // Fungsi untuk validasi input registrasi
  void _validateRegistration() {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _usernameError = username.isEmpty ? 'Please enter your username' : null;
      _emailError = !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
              .hasMatch(email)
          ? 'Please enter a valid email'
          : null;
      _passwordError = password.isEmpty ? 'Please enter a password' : null;
      _confirmPasswordError =
          password != confirmPassword ? 'Passwords do not match' : null;
    });

    if (_usernameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      _saveUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildHeader(),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Header
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple[800],
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: const [
          SizedBox(height: 10),
          Text(
            'Create Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Fill in the details below',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Form Input
  Widget _buildForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _usernameController,
              labelText: 'Username',
              icon: Icons.person,
              errorText: _usernameError,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
              suffixIcon: _isEmailValid
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red),
              onChanged: (value) {
                setState(() {
                  _isEmailValid = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value);
                });
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscureText: true,
              errorText: _passwordError,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              icon: Icons.lock,
              obscureText: true,
              errorText: _confirmPasswordError,
            ),
            const SizedBox(height: 20),
            _buildRegisterButton(),
            const SizedBox(height: 20),
            _buildLoginFooter(),
          ],
        ),
      ),
    );
  }

  // Widget TextField Builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Icon? suffixIcon,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }

  // Widget Register Button
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _validateRegistration,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'REGISTER',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget Footer untuk Login
  Widget _buildLoginFooter() {
    return Column(
      children: [
        Text('Already have an account?',
            style: TextStyle(color: Colors.grey[600])),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Log In',
            style: TextStyle(
              color: Colors.deepPurple[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
