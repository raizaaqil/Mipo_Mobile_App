import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'package:mipo_aplikasi/views/profile_view.dart';
import 'smart_ai_view.dart';
import 'calendar_view.dart';
import 'package:mipo_aplikasi/views/virtual_pet.dart'; 
import 'package:mipo_aplikasi/views/progress_view.dart';
import 'package:mipo_aplikasi/views/file_view.dart';
import 'package:mipo_aplikasi/views/setting_view.dart';
import 'package:mipo_aplikasi/views/help_view.dart';
import 'package:mipo_aplikasi/views/about_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime _focusedDate = DateTime(2026, 9, 1);

  final List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  final List<bool> _taskChecked = [false, false, false, false];

  void _changeMonth(int increment) {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month + increment,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = MediaQuery.of(context).size.width * 0.62;

    return Scaffold(
      backgroundColor:  Color(0xFFCAE7FF),
      drawerScrimColor: Colors.black.withOpacity(0.35),
      drawer: Drawer(
        width: sidebarWidth,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD8ECFF),
            borderRadius: BorderRadius.horizontal( 
              right: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/out.png',
                        width: 28,
                        height: 28,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.chevron_left,
                            size: 36,
                            color: AppColors.sekunder,
                          );
                        },
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildSidebarItem(
                    iconPath: 'assets/acount.png',
                    fallbackIcon: Icons.account_circle_outlined,
                    title: 'Profile',
                    onTap: () {
                      Navigator.of(context).pop(); // Tutup sidebar drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                  ),

                _buildSidebarItem(
                    iconPath: 'assets/setting.png',
                    fallbackIcon: Icons.settings_outlined,
                    title: 'Setting',
                    onTap: () {
                      Navigator.of(context).pop(); // Tutup drawer terlebih dahulu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingView(),
                        ),
                      );
                    },
                  ),

                _buildSidebarItem(
                    iconPath: 'assets/help.png',
                    fallbackIcon: Icons.help_outline_rounded,
                    title: 'Help',
                    onTap: () {
                      Navigator.of(context).pop(); // Tutup drawer terlebih dahulu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpView(),
                        ),
                      );
                    },
                  ),

                _buildSidebarItem(
                    iconPath: 'assets/information.png',
                    fallbackIcon: Icons.info_outline_rounded,
                    title: 'About',
                    onTap: () {
                      Navigator.of(context).pop(); // Tutup drawer terlebih dahulu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutView(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Builder(
                    builder: (scaffoldContext) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.tersier,
                          size: 32,
                        ),
                        onPressed: () {
                          Scaffold.of(scaffoldContext).openDrawer();
                        },
                      );
                    },
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SmartAiView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.sekunder,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Ask Anything!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'Huninn',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // PET MIPO
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VirtualPetView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/images/mipo_kuning.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text(
                                    '🐙',
                                    style: TextStyle(fontSize: 60),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // DIALOG PET
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.sekunder,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Eh, tugas ini masih belum disentuh loh...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontFamily: 'Huninn',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // KALENDER
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalendarView(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      color: AppColors.textDark,
                                    ),
                                    onPressed: () => _changeMonth(-1),
                                  ),
                                  Text(
                                    '${_monthNames[_focusedDate.month - 1]} - ${_focusedDate.year}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                      fontFamily: 'Huninn',
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.chevron_right,
                                      color: AppColors.textDark,
                                    ),
                                    onPressed: () => _changeMonth(1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildDynamicCalendarTable(_focusedDate),
                          ],
                        ),
                      ),
                    ),

                    // PROGRESS DAN TUGAS
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.sekunder.withOpacity(0.35),
                              blurRadius: 12,
                              spreadRadius: 1,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.sekunder,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'Lihat Progressmu!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Anak-Bijak',
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // ROW PROGRESS & FILE FOTO
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      _buildProgressBar(
                                        Icons.directions_walk_rounded,
                                        0.6,
                                      ),
                                      const SizedBox(height: 10),
                                      _buildProgressBar(
                                        Icons.menu_book_rounded,
                                        0.4,
                                      ),
                                      const SizedBox(height: 10),
                                      _buildProgressBar(
                                        Icons.badge_outlined,
                                        0.5,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const FileView(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColors.sekunder.withOpacity(0.5),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.grey,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // DAFTAR TUGAS (DIKLIK UNTUK KE PROGRESS VIEW)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProgressView(),
                                  ),
                                );
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 16),
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      28,
                                      16,
                                      16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primer.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: List.generate(
                                        4,
                                        (index) => _buildTaskItem(index),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    left: 24,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.sekunder,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Text(
                                        'Tugasmu!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Anak-Bijak',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ITEM SIDEBAR
  Widget _buildSidebarItem({
    required String iconPath,
    required IconData fallbackIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          hoverColor: Colors.black.withOpacity(0.08),
          splashColor: Colors.black.withOpacity(0.12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        fallbackIcon,
                        size: 20,
                        color: AppColors.textDark,
                      );
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    fontFamily: 'Huninn',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // KALENDER DINAMIS
  Widget _buildDynamicCalendarTable(DateTime focusedDate) {
    final firstDayOfMonth = DateTime(
      focusedDate.year,
      focusedDate.month,
      1,
    );

    final weekdayOffset = firstDayOfMonth.weekday % 7;

    final startDate = firstDayOfMonth.subtract(
      Duration(days: weekdayOffset),
    );

    final daysInMonth = DateTime(
      focusedDate.year,
      focusedDate.month + 1,
      0,
    ).day;

    final totalWeeks = (daysInMonth + weekdayOffset + 6) ~/ 7;

    final List<TableRow> rows = [];

    rows.add(
      TableRow(
        decoration: const BoxDecoration(
          color: Color(0xFFE2F1FF),
        ),
        children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
            .map(
              (day) => Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.textDark,
                    fontFamily: 'Anak-Bijak',
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );

    DateTime currentDay = startDate;

    for (int i = 0; i < totalWeeks; i++) {
      final List<Widget> rowChildren = [];

      for (int j = 0; j < 7; j++) {
        final isCurrentMonth =
            currentDay.month == focusedDate.month &&
            currentDay.year == focusedDate.year;

        rowChildren.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${currentDay.day}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Anak-Bijak',
                color: isCurrentMonth
                    ? AppColors.textDark
                    : AppColors.textDark.withOpacity(0.3),
                fontWeight: isCurrentMonth
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );

        currentDay = currentDay.add(const Duration(days: 1));
      }

      rows.add(TableRow(children: rowChildren));
    }

    return Table(
      border: TableBorder.all(
        color: AppColors.sekunder.withOpacity(0.4),
        width: 1,
      ),
      children: rows,
    );
  }

  // PROGRESS BAR
  Widget _buildProgressBar(IconData icon, double value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.textDark,
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.textDark,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 22,
              backgroundColor: AppColors.baseBg,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.sekunder,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ITEM TUGAS
  Widget _buildTaskItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _taskChecked[index] = !_taskChecked[index];
                });
              },
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.baseBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.sekunder,
                    width: 1.5,
                  ),
                ),
                child: _taskChecked[index]
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: AppColors.sekunder,
                      )
                    : null,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                'Laprak',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'Huninn',
                  color: AppColors.textDark,
                ),
              ),
            ),

            const Text(
              '9/9/26',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),

            const SizedBox(width: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F1FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Tugas',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textDark,
                ),
              ),
            ),

            const SizedBox(width: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F1FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'To Do',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}