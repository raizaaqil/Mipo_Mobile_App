import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// ============================================================================
// 🎨 TEMPAT KUSTUMISASI WARNA & FONT
// ============================================================================
class ProgressTheme {
  static const Color pageBg = Color(0xFFE8F1FA);        // Background halaman
  static const Color panelBg = Color(0xFF5B9EE1);       // Panel Biru Utama
  static const Color activeTabBg = Color(0xFF8BBDF2);    // Tab Aktif (Biru Muda)
  static const Color cardBg = Color(0xFFFFFFFF);         // Card Tugas Putih
  static const Color primaryText = Color(0xFF2C3E50);     // Warna teks utama
  static const Color buttonBg = Color(0xFF90CAF9);       // Warna tombol aksi
  static const String fontFamily = 'Nunito';
}

// Model Task
class ProgressTask {
  final String id;
  String title;
  String description;
  String status; // 'To Do', 'In Progress', atau 'Done'

  ProgressTask({
    required this.id,
    required this.title,
    required this.description,
    this.status = 'To Do',
  });
}

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  String selectedTab = 'To Do';

  // Sample Data Tugas
  List<ProgressTask> taskList = [
    ProgressTask(
      id: '1',
      title: 'Working on a lab report',
      description: 'Working on the Multimedia Production practicum report; organizing the results of the practicum and completing the sections of the report.',
      status: 'To Do',
    ),
    ProgressTask(
      id: '2',
      title: 'Creating 3D animation',
      description: 'Working on a 3D animation lab report; creating a character using edge modeling.',
      status: 'To Do',
    ),
    ProgressTask(
      id: '3',
      title: 'Create a website',
      description: 'Working on web design and programming, specifically building websites using Visual Studio Code.',
      status: 'In Progress',
    ),
    ProgressTask(
      id: '4',
      title: 'Running a business',
      description: 'Engaging in a group entrepreneurial venture, operating the business, and preparing a report on the business results.',
      status: 'Done',
    ),
  ];

  // Hapus tugas
  void _deleteTask(String id) {
    setState(() {
      taskList.removeWhere((t) => t.id == id);
    });
  }

  // Dialog Tambah Tugas Baru (Add New)
  void _showAddNewDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Title
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: ProgressTheme.activeTabBg.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Title', style: TextStyle(fontFamily: ProgressTheme.fontFamily, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: ProgressTheme.panelBg)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: ProgressTheme.panelBg)),
                  ),
                ),

                const SizedBox(height: 16),

                // Input Description
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: ProgressTheme.activeTabBg.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Description', style: TextStyle(fontFamily: ProgressTheme.fontFamily, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: ProgressTheme.panelBg)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: ProgressTheme.panelBg)),
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProgressTheme.buttonBg,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Delete', style: TextStyle(color: Colors.white, fontFamily: ProgressTheme.fontFamily)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProgressTheme.buttonBg,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          setState(() {
                            taskList.add(ProgressTask(
                              id: DateTime.now().toString(),
                              title: titleController.text,
                              description: descController.text,
                              status: selectedTab,
                            ));
                          });
                        }
                        Navigator.pop(context);
                        _showAddedNotificationDialog();
                      },
                      child: const Text('Save', style: TextStyle(color: Colors.white, fontFamily: ProgressTheme.fontFamily)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog Notifikasi tugas berhasil ditambahkan
  void _showAddedNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Progress Has Been Added',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: ProgressTheme.fontFamily),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProgressTheme.buttonBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Save', style: TextStyle(color: Colors.white, fontFamily: ProgressTheme.fontFamily)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog Upload File
  void _showUploadFileDialog() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: ProgressTheme.activeTabBg.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text('Upload', style: TextStyle(fontFamily: ProgressTheme.fontFamily, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ProgressTheme.panelBg),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        result.files.first.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: ProgressTheme.fontFamily),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProgressTheme.buttonBg,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancle', style: TextStyle(color: Colors.white, fontFamily: ProgressTheme.fontFamily)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProgressTheme.buttonBg,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Upload', style: TextStyle(color: Colors.white, fontFamily: ProgressTheme.fontFamily)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter tugas berdasarkan tab aktif
    final filteredTasks = taskList.where((t) => t.status == selectedTab).toList();

    return Scaffold(
      backgroundColor: ProgressTheme.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: ProgressTheme.panelBg, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  // Pill Title "Progress"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: ProgressTheme.panelBg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: ProgressTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Tab Bar & Add New
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTab('To Do'),
                  _buildTab('In Progress'),
                  _buildTab('Done'),
                  const Spacer(),
                  // Tombol Add New
                  GestureDetector(
                    onTap: _showAddNewDialog,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add_box_outlined, color: ProgressTheme.primaryText, size: 28),
                        Text(
                          'Add New',
                          style: TextStyle(fontSize: 11, color: ProgressTheme.primaryText, fontFamily: ProgressTheme.fontFamily),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Panel Biru Utama
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: ProgressTheme.panelBg,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ProgressTheme.cardBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kiri: Icon Upload File / Check Icon
                          GestureDetector(
                            onTap: _showUploadFileDialog,
                            child: Icon(
                              selectedTab == 'To Do' ? Icons.upload_sharp : Icons.fact_check_outlined,
                              color: ProgressTheme.primaryText,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Tengah: Title & Description
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ProgressTheme.primaryText,
                                    fontFamily: ProgressTheme.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  task.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ProgressTheme.primaryText.withOpacity(0.8),
                                    fontFamily: ProgressTheme.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Kanan: Icon Trash (Hapus)
                          GestureDetector(
                            onTap: () => _deleteTask(task.id),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: ProgressTheme.primaryText,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget Pembuat Tab Pilihan
  Widget _buildTab(String label) {
    final bool isActive = selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? ProgressTheme.panelBg : ProgressTheme.activeTabBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : ProgressTheme.primaryText,
            fontFamily: ProgressTheme.fontFamily,
          ),
        ),
      ),
    );
  }
}