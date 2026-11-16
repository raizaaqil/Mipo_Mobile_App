import 'package:flutter/material.dart';

class AboutTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Background
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Primary Blue Header & Title
  static const Color btnLight = Color(0xFFCBE5FF);      // Light Blue Button
  static const String fontFamily = 'Nunito';
}

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final TextEditingController feedbackController = TextEditingController();

  // Dialog Notifikasi Feedback Send
  void _showFeedbackSendDialog() {
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
                'Feedback Send',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: AboutTheme.fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AboutTheme.btnLight,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                ),
                onPressed: () {
                  feedbackController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: AboutTheme.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontFamily: AboutTheme.fontFamily,
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
      backgroundColor: AboutTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Header Back Button & Pill Title "About Application"
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AboutTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: AboutTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'About Application',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AboutTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH PERTAMA (ABOUT APPLICATION)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
                    // Logo MiPo
                    Image.asset(
                      'assets/images/logo_mipo.png',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'MiPo',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AboutTheme.primaryBlue,
                          fontFamily: AboutTheme.fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Deskripsi Aplikasi
                    const Text(
                      'MiPO is an interactive productivity platform designed to help students manage their schedules, track daily tasks, and monitor their study progress in a fun way. Accompanied by an adaptive virtual mascot, MiPO makes time management routines feel lighter, more structured, and far from tedious.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                        fontFamily: AboutTheme.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH KARTU PUTIH KEDUA (FEEDBACK)
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
                    // Feedback Pill Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                      decoration: BoxDecoration(
                        color: AboutTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: AboutTheme.fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Text Field Area "Type Here..."
                    Container(
                      height: 180,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AboutTheme.primaryBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: feedbackController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Type Here...',
                          hintStyle: TextStyle(color: Colors.black45, fontFamily: AboutTheme.fontFamily),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tombol Send Feedback
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AboutTheme.btnLight,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                      ),
                      onPressed: () {
                        if (feedbackController.text.isNotEmpty) {
                          _showFeedbackSendDialog();
                        }
                      },
                      child: const Text(
                        'Send Feedback',
                        style: TextStyle(
                          fontSize: 14,
                          color: AboutTheme.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: AboutTheme.fontFamily,
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
    );
  }
}