import 'package:flutter/material.dart';

class HelpTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Background
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Primary Blue Title & Buttons
  static const Color btnLight = Color(0xFFBDE0FE);      // Light Blue Pill Button
  static const String fontFamily = 'Nunito';
}

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final TextEditingController searchController = TextEditingController();

  final List<String> faqList = [
    'How do I change my profile and account information?',
    'Page failed to load or a feature is experiencing an error',
    'How to download or save project data/files',
    'How do I create or add a new project?',
  ];

  // 1. DIALOG INPUT CHAT SUPPORT / SEND EMAIL
  void _showFormDialog({required String title, required String successMsg}) {
    final messageController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                decoration: BoxDecoration(
                  color: HelpTheme.btnLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HelpTheme.primaryBlue,
                    fontFamily: HelpTheme.fontFamily,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Large Message Input Area
              Container(
                height: 320,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: HelpTheme.primaryBlue, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Type Here...',
                    hintStyle: TextStyle(color: Colors.black45, fontFamily: HelpTheme.fontFamily),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action Buttons: Cancle & Send
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HelpTheme.btnLight,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancle',
                      style: TextStyle(
                        color: HelpTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontFamily: HelpTheme.fontFamily,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HelpTheme.btnLight,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Tutup Dialog Form
                      _showSuccessDialog(successMsg); // Tampilkan Dialog Sukses
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: HelpTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontFamily: HelpTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 2. DIALOG NOTIFIKASI SUKSES (Chat Send / Email Send)
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: HelpTheme.fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HelpTheme.btnLight,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: HelpTheme.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontFamily: HelpTheme.fontFamily,
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
      backgroundColor: HelpTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Header Back Button & Pill Title "Help & Support"
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: HelpTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context), // Kembali ke Home View Side Bar Navigation
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: HelpTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: HelpTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ⚪ WADAH PANEL PUTIH UTAMA
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
                    // Search Bar "Ask Anything"
                    Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: HelpTheme.primaryBlue, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: HelpTheme.primaryBlue, size: 22),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: 'Ask Anything',
                                hintStyle: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: HelpTheme.fontFamily),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // List Pertanyaan FAQ
                    Column(
                      children: faqList.map((question) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Text(
                            question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: HelpTheme.fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // Tombol Chat Support
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HelpTheme.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                      ),
                      onPressed: () {
                        _showFormDialog(
                          title: 'Chat Support',
                          successMsg: 'Chat Send',
                        );
                      },
                      child: const Text(
                        'Chat Support',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: HelpTheme.fontFamily,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Tombol Send Email
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HelpTheme.btnLight,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
                      ),
                      onPressed: () {
                        _showFormDialog(
                          title: 'Send Email',
                          successMsg: 'Email Send',
                        );
                      },
                      child: const Text(
                        'Send Email',
                        style: TextStyle(
                          fontSize: 16,
                          color: HelpTheme.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: HelpTheme.fontFamily,
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