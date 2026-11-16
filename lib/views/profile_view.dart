import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProfileTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Bg
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Primary Blue
  static const Color btnLight = Color(0xFFCBE5FF);      // Light Blue Button
  static const String fontFamily = 'Nunito';
}

// ============================================================================
// 1. MAIN PROFILE VIEW
// ============================================================================
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String name = 'Aliya';
  String age = '20';
  String email = 'aliya@gmail.com';
  String petName = 'Aliya';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Header Back Button & Pill Title "Profile"
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: ProfileTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: ProfileTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: ProfileTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH UTAMA (USER PROFILE)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // User Photo Profile Box
                    Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ProfileTheme.primaryBlue, width: 2.5),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 80, color: ProfileTheme.primaryBlue),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Profile Display Fields
                    _buildDisplayField('Name', name),
                    const SizedBox(height: 12),
                    _buildDisplayField('Age', age),
                    const SizedBox(height: 12),
                    _buildDisplayField('Email', email),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH KEDUA (PET SECTION)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Pet Section Pill Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      decoration: BoxDecoration(
                        color: ProfileTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Pet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: ProfileTheme.fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Pet Avatar Circle
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: ProfileTheme.pageBg, width: 4),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/mipo_kuning.png',
                          width: 85,
                          errorBuilder: (context, error, stackTrace) =>
                              const Text('🐙', style: TextStyle(fontSize: 50)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Pet Name Display Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ProfileTheme.primaryBlue, width: 1.5),
                      ),
                      child: Text(
                        petName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ProfileTheme.primaryBlue,
                          fontFamily: ProfileTheme.fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Bottom Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ProfileTheme.btnLight,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUserProfileView(
                                  initialName: name,
                                  initialAge: age,
                                  initialEmail: email,
                                  initialPetName: petName,
                                ),
                              ),
                            );
                            if (result != null && result is Map) {
                              setState(() {
                                name = result['name'] ?? name;
                                age = result['age'] ?? age;
                                email = result['email'] ?? email;
                                petName = result['petName'] ?? petName;
                              });
                            }
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: ProfileTheme.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontFamily: ProfileTheme.fontFamily,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ProfileTheme.primaryBlue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: ProfileTheme.fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ProfileTheme.primaryBlue,
              fontSize: 13,
              fontFamily: ProfileTheme.fontFamily,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ProfileTheme.primaryBlue, width: 1.5),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontFamily: ProfileTheme.fontFamily,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 2. EDIT USER PROFILE VIEW
// ============================================================================
class EditUserProfileView extends StatefulWidget {
  final String initialName;
  final String initialAge;
  final String initialEmail;
  final String initialPetName;

  const EditUserProfileView({
    super.key,
    required this.initialName,
    required this.initialAge,
    required this.initialEmail,
    required this.initialPetName,
  });

  @override
  State<EditUserProfileView> createState() => _EditUserProfileViewState();
}

class _EditUserProfileViewState extends State<EditUserProfileView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController eduController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.initialEmail);
    passwordController = TextEditingController(text: '********');
    nameController = TextEditingController(text: widget.initialName);
    ageController = TextEditingController(text: widget.initialAge);
    eduController = TextEditingController(text: 'Undergraduate');
  }

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
                decoration: BoxDecoration(color: ProfileTheme.btnLight, borderRadius: BorderRadius.circular(16)),
                child: const Text('Upload', style: TextStyle(fontWeight: FontWeight.bold, color: ProfileTheme.primaryBlue, fontFamily: ProfileTheme.fontFamily)),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: ProfileTheme.primaryBlue), borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    result != null ? result.files.first.name : 'No file selected',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: ProfileTheme.fontFamily),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: ProfileTheme.btnLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancle', style: TextStyle(color: ProfileTheme.primaryBlue, fontFamily: ProfileTheme.fontFamily)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: ProfileTheme.btnLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Upload', style: TextStyle(color: ProfileTheme.primaryBlue, fontFamily: ProfileTheme.fontFamily)),
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
      backgroundColor: ProfileTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: ProfileTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(color: ProfileTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                    child: const Text('User Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: ProfileTheme.fontFamily)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH FORM EDIT USER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: ProfileTheme.primaryBlue, width: 2),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ProfileTheme.primaryBlue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _showUploadPictureDialog,
                      child: const Text('Choose Picture', style: TextStyle(color: ProfileTheme.primaryBlue, fontSize: 12, fontFamily: ProfileTheme.fontFamily)),
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
                        backgroundColor: ProfileTheme.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                      ),
                      onPressed: () async {
                        final petResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPetProfileView(initialPetName: widget.initialPetName),
                          ),
                        );
                        if (!mounted) return;
                        Navigator.pop(context, {
                          'name': nameController.text,
                          'age': ageController.text,
                          'email': emailController.text,
                          'petName': petResult ?? widget.initialPetName,
                        });
                      },
                      child: const Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: ProfileTheme.fontFamily)),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: ProfileTheme.primaryBlue, fontSize: 13, fontFamily: ProfileTheme.fontFamily)),
        ),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ProfileTheme.primaryBlue, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ProfileTheme.primaryBlue, width: 1.5)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3. EDIT PET PROFILE VIEW
// ============================================================================
class EditPetProfileView extends StatefulWidget {
  final String initialPetName;
  const EditPetProfileView({super.key, required this.initialPetName});

  @override
  State<EditPetProfileView> createState() => _EditPetProfileViewState();
}

class _EditPetProfileViewState extends State<EditPetProfileView> {
  late TextEditingController petNameController;

  @override
  void initState() {
    super.initState();
    petNameController = TextEditingController(text: widget.initialPetName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: ProfileTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(color: ProfileTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                    child: const Text('Pet Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: ProfileTheme.fontFamily)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH FORM EDIT PET
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: ProfileTheme.primaryBlue, width: 2),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/mipo_kuning.png',
                          width: 80,
                          errorBuilder: (context, error, stackTrace) =>
                              const Text('🐙', style: TextStyle(fontSize: 50)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, bottom: 4),
                          child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: ProfileTheme.primaryBlue, fontSize: 13, fontFamily: ProfileTheme.fontFamily)),
                        ),
                        TextField(
                          controller: petNameController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ProfileTheme.primaryBlue, width: 1.5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ProfileTheme.primaryBlue, width: 1.5)),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProfileTheme.btnLight,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
                      ),
                      onPressed: () => Navigator.pop(context, petNameController.text),
                      child: const Text('Save', style: TextStyle(color: ProfileTheme.primaryBlue, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: ProfileTheme.fontFamily)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}