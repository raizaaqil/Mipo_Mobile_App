import 'package:flutter/material.dart';
import 'login_view.dart';
import 'landing_view.dart'; // Navigasi ke Welcome/Landing Page

class SettingTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Background
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Main Title Pill & Primary Blue
  static const Color iconBg = Color(0xFFD8ECFF);        // Circle Icon Bg
  static const Color btnLight = Color(0xFFCBE5FF);      // Light Blue Button
  static const String fontFamily = 'Nunito';
}

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  // State Setting Options
  bool turnOnNotification = true;
  bool hideNotification = false;
  bool isBrightDisplay = true;
  bool isIndonesian = false;
  bool isEnglish = true;

  // 1. DIALOG NOTIFICATION
  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPillHeader('Notification'),
                const SizedBox(height: 20),
                _buildSwitchRow(
                  icon: Icons.notifications_none_rounded,
                  title: 'Turn On Notification',
                  value: turnOnNotification,
                  onChanged: (val) => setDialogState(() => turnOnNotification = val),
                ),
                const SizedBox(height: 12),
                _buildSwitchRow(
                  icon: Icons.notifications_off_outlined,
                  title: 'Hide Notification',
                  value: hideNotification,
                  onChanged: (val) => setDialogState(() => hideNotification = val),
                ),
                const SizedBox(height: 24),
                _buildDialogActions(onSave: () => setState(() {})),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 2. DIALOG DISPLAY
  void _showDisplayDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPillHeader('Display'),
                const SizedBox(height: 24),
                _buildSwitchRow(
                  icon: Icons.desktop_windows_outlined,
                  title: isBrightDisplay ? 'Bright Display' : 'Dark Display',
                  value: isBrightDisplay,
                  onChanged: (val) => setDialogState(() => isBrightDisplay = val),
                ),
                const SizedBox(height: 28),
                _buildDialogActions(onSave: () => setState(() {})),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3. DIALOG PRIVACY / CHANGE PASSWORD
  void _showPrivacyDialog() {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPillHeader('Privacy'),
              const SizedBox(height: 20),
              _buildDialogInputField('Old Password', oldPassController),
              const SizedBox(height: 10),
              _buildDialogInputField('New Password', newPassController),
              const SizedBox(height: 10),
              _buildDialogInputField('Insert Password', confirmPassController),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: _btnStyle(SettingTheme.btnLight),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancle', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                  ElevatedButton(
                    style: _btnStyle(SettingTheme.btnLight),
                    onPressed: () {
                      Navigator.pop(context);
                      _showPasswordSavedDialog();
                    },
                    child: const Text('Save', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // POPUP PASSWORD SAVED
  void _showPasswordSavedDialog() {
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
                'Password Change',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: SettingTheme.fontFamily),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: _btnStyle(SettingTheme.btnLight),
                onPressed: () => Navigator.pop(context),
                child: const Text('Save', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. DIALOG LANGUAGE
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPillHeader('Language'),
                const SizedBox(height: 20),
                _buildSwitchRow(
                  icon: Icons.g_translate_rounded,
                  title: 'Bahasa Indonesia',
                  value: isIndonesian,
                  onChanged: (val) => setDialogState(() {
                    isIndonesian = val;
                    isEnglish = !val;
                  }),
                ),
                const SizedBox(height: 12),
                _buildSwitchRow(
                  icon: Icons.g_translate_rounded,
                  title: 'English',
                  value: isEnglish,
                  onChanged: (val) => setDialogState(() {
                    isEnglish = val;
                    isIndonesian = !val;
                  }),
                ),
                const SizedBox(height: 24),
                _buildDialogActions(onSave: () => setState(() {})),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 5. DIALOG LOGOUT
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Do you really want to Log Out\nfrom your account?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: SettingTheme.fontFamily),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: _btnStyle(SettingTheme.btnLight),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancle', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                  ElevatedButton(
                    style: _btnStyle(SettingTheme.btnLight),
                    onPressed: () {
                      Navigator.pop(context);
                      // Pindah ke Halaman Login & Hapus semua riwayat tumpukan halaman sebelumnya
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginView()),
                        (route) => false,
                      );
                    },
                    child: const Text('Yes', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                ],
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
      backgroundColor: SettingTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: SettingTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(color: SettingTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                    child: const Text('Setting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: SettingTheme.fontFamily)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // White Panel Box Settings
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                ),
                child: Column(
                  children: [
                    _buildSettingTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Account',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSettingView()));
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notification',
                      onTap: _showNotificationDialog,
                    ),
                    const SizedBox(height: 20),
                    _buildSettingTile(
                      icon: Icons.desktop_windows_outlined,
                      title: 'Display',
                      onTap: _showDisplayDialog,
                    ),
                    const SizedBox(height: 20),
                    _buildSettingTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Privacy',
                      onTap: _showPrivacyDialog,
                    ),
                    const SizedBox(height: 20),
                    _buildSettingTile(
                      icon: Icons.g_translate_rounded,
                      title: 'Language',
                      onTap: _showLanguageDialog,
                    ),
                    const SizedBox(height: 20),
                    _buildSettingTile(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      onTap: _showLogoutDialog,
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

  // WIDGET HELPER DIALOG
  Widget _buildPillHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      decoration: BoxDecoration(color: SettingTheme.primaryBlue, borderRadius: BorderRadius.circular(20)),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: SettingTheme.fontFamily)),
    );
  }

  Widget _buildSwitchRow({required IconData icon, required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(color: SettingTheme.iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: SettingTheme.primaryBlue, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: SettingTheme.fontFamily))),
        Switch(
          value: value,
          activeColor: SettingTheme.primaryBlue,
          activeTrackColor: SettingTheme.btnLight,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDialogActions({required VoidCallback onSave}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: _btnStyle(SettingTheme.btnLight),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancle', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
        ),
        ElevatedButton(
          style: _btnStyle(SettingTheme.btnLight),
          onPressed: () {
            onSave();
            Navigator.pop(context);
          },
          child: const Text('Save', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
        ),
      ],
    );
  }

  Widget _buildDialogInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: SettingTheme.primaryBlue, fontSize: 12, fontFamily: SettingTheme.fontFamily)),
        ),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: SettingTheme.primaryBlue, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: SettingTheme.primaryBlue, width: 1.5)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(color: SettingTheme.iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: SettingTheme.primaryBlue, size: 28),
          ),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: SettingTheme.fontFamily)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: SettingTheme.primaryBlue, size: 24),
        ],
      ),
    );
  }

  ButtonStyle _btnStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}

// ============================================================================
// ACCOUNT SETTING VIEW
// ============================================================================
class AccountSettingView extends StatefulWidget {
  const AccountSettingView({super.key});

  @override
  State<AccountSettingView> createState() => _AccountSettingViewState();
}

class _AccountSettingViewState extends State<AccountSettingView> {
  final TextEditingController nameController = TextEditingController(text: 'Aliya');
  final TextEditingController ageController = TextEditingController(text: '20');
  final TextEditingController emailController = TextEditingController(text: 'aliya@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '********');
  final TextEditingController eduController = TextEditingController(text: 'Undergraduate');

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Do you really want to delete\nyour account?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: SettingTheme.fontFamily),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: SettingTheme.btnLight, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancle', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: SettingTheme.btnLight, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LandingView()),
                        (route) => false,
                      );
                    },
                    child: const Text('Yes', style: TextStyle(color: SettingTheme.primaryBlue, fontWeight: FontWeight.bold, fontFamily: SettingTheme.fontFamily)),
                  ),
                ],
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
      backgroundColor: SettingTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: SettingTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(color: SettingTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
                    child: const Text('Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: SettingTheme.fontFamily)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                ),
                child: Column(
                  children: [
                    _buildInputField('Name', nameController),
                    const SizedBox(height: 14),
                    _buildInputField('Age', ageController),
                    const SizedBox(height: 14),
                    _buildInputField('Email', emailController),
                    const SizedBox(height: 14),
                    _buildInputField('Password', passwordController, isObscure: true),
                    const SizedBox(height: 14),
                    _buildInputField('Education Level', eduController),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showDeleteAccountDialog,
                        child: const Text('Delete Account', style: TextStyle(color: SettingTheme.primaryBlue, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: SettingTheme.fontFamily)),
                      ),
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
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: SettingTheme.primaryBlue, fontSize: 13, fontFamily: SettingTheme.fontFamily)),
        ),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: SettingTheme.primaryBlue, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: SettingTheme.primaryBlue, width: 1.5)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}