import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import 'package:voumarketinggame/pages/welcome_page.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/providers/user_provider.dart';

class UserInfoScreen extends StatefulWidget {
  final String username;
  final String password;

  const UserInfoScreen({
    required this.username,
    required this.password,
    super.key,
  });

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(picked); // Format YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter Your Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _nameController,
                  label: 'Name',
                  hint: 'Enter your full name',
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: _buildInputField(
                      controller: _birthdayController,
                      label: 'Birthday',
                      hint: 'Select your birthday (YYYY-MM-DD)',
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                      validator: (value) => value!.isEmpty ? 'Please select your birthday' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value?.toUpperCase();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    hintText: 'Select your gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: ['MALE', 'FEMALE', 'OTHER']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please select your gender' : null,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final userInfo = {
                        'name': _nameController.text.trim(),
                        'email': _emailController.text.trim(),
                        'phoneNumber': _phoneController.text.trim(),
                        'avatarUrl': "",
                        'birthday': _birthdayController.text.trim(),
                        'gender': _selectedGender ?? "",
                      };

                      final isSignUpSuccess = await authProvider.signUp(
                        username: widget.username,
                        password: widget.password,
                      );

                      if (isSignUpSuccess) {
                        final isUpdateSuccess = await userProvider.updateUserActive(
                          userInfo: userInfo,
                          context: context,
                        );

                        if (isUpdateSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('User information updated successfully!')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (e) => const WelcomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign up failed')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: userProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Sign Up', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
