import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'home_views.dart';

class LoginTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Bg
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Main Header & Buttons
  static const Color btnLight = Color(0xFFCBE5FF);      // Light Blue Button
  static const String fontFamily = 'Nunito';
}

// ============================================================================
// 1. LOGIN VIEW
// ============================================================================
class LoginView extends StatefulWidget {
  final bool showEmailSentNotif;

  const LoginView({super.key, this.showEmailSentNotif = false});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.showEmailSentNotif) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEmailSentDialog();
      });
    }
  }

  void _showEmailSentDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Email Sent!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: LoginTheme.fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: LoginTheme.btnLight,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: LoginTheme.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontFamily: LoginTheme.fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginTheme.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: LoginTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildInputField('Email', emailController),
                          const SizedBox(height: 16),
                          _buildInputField('Password', passwordController, isObscure: true),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LoginTheme.btnLight,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeView()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: LoginTheme.primaryBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: LoginTheme.fontFamily,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgetPasswordView()),
                              );
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                color: LoginTheme.primaryBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: LoginTheme.fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                        decoration: BoxDecoration(
                          color: LoginTheme.primaryBlue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: LoginTheme.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: LoginTheme.primaryBlue,
              fontSize: 13,
              fontFamily: LoginTheme.fontFamily,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 2. REGISTER USER PROFILE (TAHAP 1)
// ============================================================================
class RegisterUserProfileView extends StatefulWidget {
  const RegisterUserProfileView({super.key});

  @override
  State<RegisterUserProfileView> createState() => _RegisterUserProfileViewState();
}

class _RegisterUserProfileViewState extends State<RegisterUserProfileView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController eduController = TextEditingController();

  void _showUploadPictureDialog() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(color: LoginTheme.btnLight, borderRadius: BorderRadius.circular(16)),
                child: const Text('Upload', style: TextStyle(fontWeight: FontWeight.bold, color: LoginTheme.primaryBlue, fontFamily: LoginTheme.fontFamily)),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: LoginTheme.primaryBlue), borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    result != null ? result.files.first.name : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: LoginTheme.fontFamily),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: LoginTheme.btnLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancle', style: TextStyle(color: LoginTheme.primaryBlue, fontFamily: LoginTheme.fontFamily)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: LoginTheme.btnLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Upload', style: TextStyle(color: LoginTheme.primaryBlue, fontFamily: LoginTheme.fontFamily)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginTheme.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: LoginTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4))],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 130,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: LoginTheme.primaryBlue, width: 2),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: LoginTheme.primaryBlue),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: _showUploadPictureDialog,
                            child: const Text('Choose Picture', style: TextStyle(color: LoginTheme.primaryBlue, fontSize: 12, fontFamily: LoginTheme.fontFamily)),
                          ),
                          const SizedBox(height: 16),
                          _buildInputField('Email', emailController),
                          const SizedBox(height: 10),
                          _buildInputField('Password', passwordController, isObscure: true),
                          const SizedBox(height: 10),
                          _buildInputField('Name', nameController),
                          const SizedBox(height: 10),
                          _buildInputField('Age', ageController),
                          const SizedBox(height: 10),
                          _buildInputField('Education Level', eduController),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LoginTheme.primaryBlue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPetProfileView()),
                              );
                            },
                            child: const Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: LoginTheme.fontFamily)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(color: LoginTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                        child: const Text('User Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: LoginTheme.fontFamily)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: LoginTheme.primaryBlue, fontSize: 13, fontFamily: LoginTheme.fontFamily)),
        ),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3. REGISTER PET PROFILE (TAHAP 2)
// ============================================================================
class RegisterPetProfileView extends StatefulWidget {
  const RegisterPetProfileView({super.key});

  @override
  State<RegisterPetProfileView> createState() => _RegisterPetProfileViewState();
}

class _RegisterPetProfileViewState extends State<RegisterPetProfileView> {
  final TextEditingController petNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginTheme.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: LoginTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4))],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 140,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: LoginTheme.primaryBlue, width: 2),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8, bottom: 4),
                                child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: LoginTheme.primaryBlue, fontSize: 13, fontFamily: LoginTheme.fontFamily)),
                              ),
                              TextField(
                                controller: petNameController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LoginTheme.btnLight,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeView()),
                                (route) => false,
                              );
                            },
                            child: const Text('Save', style: TextStyle(color: LoginTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: LoginTheme.fontFamily)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(color: LoginTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                        child: const Text('Pet Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: LoginTheme.fontFamily)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. FORGET PASSWORD VIEW
// ============================================================================
class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginTheme.pageBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: LoginTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 4),
                              child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: LoginTheme.primaryBlue, fontSize: 13, fontFamily: LoginTheme.fontFamily)),
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: LoginTheme.primaryBlue, width: 1.5)),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LoginTheme.btnLight,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginView(showEmailSentNotif: true)),
                              (route) => false,
                            );
                          },
                          child: const Text('Send Email', style: TextStyle(color: LoginTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: LoginTheme.fontFamily)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        decoration: BoxDecoration(
                          color: LoginTheme.primaryBlue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Forget Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: LoginTheme.fontFamily),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}