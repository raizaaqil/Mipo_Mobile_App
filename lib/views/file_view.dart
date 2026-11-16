import 'package:flutter/material.dart';

// ============================================================================
// 🎨 TEMPAT KUSTUMISASI WARNA & FONT
// ============================================================================
class FileTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Background Biru Muda
  static const Color searchBg = Color(0xFFFFFFFF);      // Background Search Bar
  static const Color calendarHeader = Color(0xFFBDE0FE);// Header Kalender
  static const Color activeTabBg = Color(0xFF90CAF9);   // Tab Aktif (Biru)
  static const Color inactiveTabBg = Color(0xFFFFFFFF); // Tab Non-aktif
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Warna Border & Primary
  static const Color gridItemBg = Color(0xFFA2D2FF);    // Item Box Biru
  static const String fontFamily = 'Nunito';
}

class FileView extends StatefulWidget {
  const FileView({super.key});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  String activeTab = 'Galery'; // 'Galery' atau 'Docs'
  int selectedDay = 16;
  final TextEditingController notesController = TextEditingController();

  // Dummy Data Foto/Dokumen
  final List<String> galleryItems = List.generate(8, (index) => 'Photo ${index + 1}');
  final List<String> docItems = List.generate(8, (index) => 'Doc ${index + 1}.pdf');

  // Popup Preview Detail Item
  void _showItemPreview(String itemTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: const Color(0xFFBDE0FE),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  activeTab == 'Galery' ? Icons.image_rounded : Icons.insert_drive_file_rounded,
                  size: 80,
                  color: FileTheme.primaryBlue,
                ),
                const SizedBox(height: 16),
                Text(
                  itemTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: FileTheme.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FileTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar: Back Button & Search Bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: FileTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: FileTheme.searchBg,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: FileTheme.primaryBlue, width: 1.5),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: FileTheme.primaryBlue, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.black45,
                              fontFamily: FileTheme.fontFamily,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 2. Calendar Card Widget
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: FileTheme.primaryBlue, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Calendar Header (September - 2026)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.chevron_left, color: Colors.black87),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            decoration: BoxDecoration(
                              color: FileTheme.calendarHeader,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'September - 2026',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: FileTheme.fontFamily,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.black87),
                        ],
                      ),
                    ),

                    // Calendar Grid Days
                    Table(
                      border: TableBorder.all(
                        color: Colors.blue.withOpacity(0.2),
                        width: 1,
                      ),
                      children: [
                        // Days Header (S M T W T F S)
                        TableRow(
                          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                              .map((day) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: FileTheme.fontFamily,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        // Calendar Row Sample (13 - 19)
                        _buildCalendarRow([13, 14, 15, 16, 17, 18, 19]),
                        // Calendar Row Sample (20 - 26)
                        _buildCalendarRow([20, 21, 22, 23, 24, 25, 26]),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3. Tab Buttons: Galery & Docs
              Row(
                children: [
                  _buildTabButton('Galery'),
                  const SizedBox(width: 8),
                  _buildTabButton('Docs'),
                ],
              ),

              // 4. Main Panel: Grid Items (Galery / Docs)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: activeTab == 'Galery' ? galleryItems.length : docItems.length,
                  itemBuilder: (context, index) {
                    final title = activeTab == 'Galery' ? galleryItems[index] : docItems[index];
                    return GestureDetector(
                      onTap: () => _showItemPreview(title),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FileTheme.gridItemBg,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(
                            activeTab == 'Galery' ? Icons.image : Icons.picture_as_pdf,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // 5. Notes Card Area
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FileTheme.pageBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: FileTheme.primaryBlue.withOpacity(0.5)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  controller: notesController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Notes...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black45,
                      fontFamily: FileTheme.fontFamily,
                      fontSize: 15,
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

  // Helper Widget Tab Toggle Button
  Widget _buildTabButton(String label) {
    final bool isActive = activeTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? FileTheme.activeTabBg : FileTheme.inactiveTabBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black87,
            fontFamily: FileTheme.fontFamily,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Helper Widget Row Tanggal Kalender
  TableRow _buildCalendarRow(List<int> days) {
    return TableRow(
      children: days.map((day) {
        final bool isSelected = day == selectedDay;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDay = day;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: isSelected ? FileTheme.activeTabBg.withOpacity(0.3) : Colors.transparent,
            child: Text(
              '$day',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: FileTheme.fontFamily,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}