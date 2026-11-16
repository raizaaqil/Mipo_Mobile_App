import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';

// ============================================================================
// 🎨 TEMPAT KUSTUMISASI WARNA & FONT
// ============================================================================
class PetTheme {
  // Warna Utama
  static const Color mainBackground = Color(0xFFFFFFFF); // Background utama
  static const Color darkBlueBg = Color(0xFF334A6A); // Background kamera & preview
  static const Color cardBg = Color(0xFFD6E9FF); // Card Tugas
  static const Color bubbleBorder = Color(0xFF5B9EE1); // Border bubble chat
  static const Color primaryButton = Color(0xFF90CAF9); // Warna tombol Upload/Save
  
  // Font Family (Bisa diganti misal 'Nunito', 'Poppins', dll)
  static const String fontFamily = 'Nunito'; 
}

// Model data Tugas
class TaskItem {
  final String id;
  final String title;
  final String description;
  bool isCompleted;

  TaskItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class VirtualPetView extends StatefulWidget {
  const VirtualPetView({super.key});

  @override
  State<VirtualPetView> createState() => _VirtualPetViewState();
}

class _VirtualPetViewState extends State<VirtualPetView> {
  // Sample daftar tugas
  List<TaskItem> tasks = [
    TaskItem(
      id: '1',
      title: 'Creating 3D animation',
      description: 'Working on a 3D animation lab report; creating a character using edge modeling.',
    ),
    TaskItem(
      id: '2',
      title: 'Create a website',
      description: 'Working on web design and programming, specifically building websites using Visual Studio Code.',
    ),
    TaskItem(
      id: '3',
      title: 'Running a business',
      description: 'Engaging in a group entrepreneurial venture, operating the business, and preparing a report on the business results.',
    ),
  ];

  // Hapus task dari list
  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((item) => item.id == id);
    });
  }

  // Pick file dari perangkat
  Future<void> _pickFile(TaskItem task) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _showTaskCompletedDialog(task);
    }
  }

  // Dialog Task Completed
  void _showTaskCompletedDialog(TaskItem task) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Task Completed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: PetTheme.fontFamily,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PetTheme.primaryButton,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteTask(task.id); // Hapus task setelah diklik Save
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: PetTheme.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Buka Halaman Kamera
  void _openCamera(TaskItem task) async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    if (!mounted) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: cameras.first),
      ),
    );

    // Jika foto diambil & dikonfirmasi upload
    if (result == true) {
      _showTaskCompletedDialog(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetTheme.mainBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // 1. Header dengan Tombol Out / Back
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset(
                    'assets/out.png', // Menggunakan icon out dari asset
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.arrow_back_ios_new,
                      color: PetTheme.bubbleBorder,
                      size: 28,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 2. Gambar Virtual Pet
              Center(
                child: Image.asset(
                  'assets/images/mipo_kuning.png',
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.pets,
                    size: 140,
                    color: Colors.amber,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 3. Bubble Chat Ngingetin User
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PetTheme.bubbleBorder, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: const Text(
                  "Hey, this assignment hasn't even been touched yet...",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: PetTheme.fontFamily,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 4. Daftar List Tugas
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: PetTheme.cardBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Section (Checkbox & Camera)
                        Column(
                          children: [
                            // Checkbox (Buka File)
                            GestureDetector(
                              onTap: () => _pickFile(task),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: PetTheme.darkBlueBg,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Kamera Icon (Buka Kamera Device)
                            GestureDetector(
                              onTap: () => _openCamera(task),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: PetTheme.darkBlueBg,
                                size: 26,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 14),

                        // Middle Section (Title & Description)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: PetTheme.darkBlueBg,
                                  fontFamily: PetTheme.fontFamily,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                task.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PetTheme.darkBlueBg.withOpacity(0.8),
                                  fontFamily: PetTheme.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Right Section (Trash Icon)
                        GestureDetector(
                          onTap: () => _deleteTask(task.id),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: PetTheme.darkBlueBg,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 📸 FITUR KAMERA (ASPECT RATIO 3:4 & DARK BLUE BACKGROUND)
// ============================================================================
class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;
      // Pindah ke Halaman Preview Foto
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(imagePath: image.path),
        ),
      );

      if (result == true) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint("Error camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetTheme.darkBlueBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header Kamera
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                    onPressed: _toggleFlash,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                // Frame Rasio 3:4 Kamera
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_controller);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Tombol Shutter Tangkap Gambar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: PetTheme.darkBlueBg,
                    size: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 🖼️ PREVIEW RESULT SCREEN (CANCLE & UPLOAD)
// ============================================================================
class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetTheme.darkBlueBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Cancle -> Kembali ke Kamera
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PetTheme.primaryButton,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      'Cancle', // Sesuai typo di acuan Figma "Cancle"
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: PetTheme.fontFamily,
                      ),
                    ),
                  ),

                  // Tombol Upload -> Kembali & Tampilkan Task Completed
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PetTheme.primaryButton,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: PetTheme.fontFamily,
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