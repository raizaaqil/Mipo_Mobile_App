
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_colors.dart';

class SmartAiView extends StatefulWidget {
  final VoidCallback? onHomeTap;

  const SmartAiView({
    super.key,
    this.onHomeTap,
  });

  @override
  State<SmartAiView> createState() => _SmartAiViewState();
}

class _SmartAiViewState extends State<SmartAiView> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _historySearchController =
      TextEditingController();

  bool _isFocused = false;
  bool _isSidebarOpen = false;

  String _activeChat = 'Atur Waktu Ngerjain Tugas Desain';

  final List<String> _pinnedChats = [
    'Atur Waktu Ngerjain Tugas Desain',
    'Bagi Tugas Berdasarkan Deadline',
    'Jadwal Revisi Sebelum Presentasi',
  ];

  final List<String> _chatHistory = [
    'Atur Waktu Ngerjain Tugas Desain',
    'Bagi Tugas Berdasarkan Deadline',
    'Jadwal Revisi Sebelum Presentasi',
    'Atur Jadwal Seminggu Penuh',
    'Jadwal Kuliah dan Organisasi',
  ];

  @override
  void initState() {
    super.initState();

    _searchFocusNode.addListener(() {
      if (!mounted) return;
      setState(() {
        _isFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _historySearchController.dispose();
    super.dispose();
  }

  void _startNewChat() {
    setState(() {
      _activeChat = '';
      _isSidebarOpen = false;
    });
  }

  void _openChat(String chat) {
    setState(() {
      _activeChat = chat;
      _isSidebarOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseBg,
      body: SafeArea(
        child: Stack(
          children: [
            // HALAMAN SMART AI
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        hoverColor: AppColors.sekunder.withOpacity(0.15),
                        onTap: () {
                          setState(() {
                            _isSidebarOpen = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.menu,
                            size: 30,
                            color: AppColors.sekunder,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),

            // OVERLAY GELAP
            if (_isSidebarOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSidebarOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.38),
                  ),
                ),
              ),

            // SIDEBAR
            AnimatedPositioned(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              top: 0,
              bottom: 0,
              left: _isSidebarOpen ? 0 : -340,
              width: 320,
              child: _buildSidebar(),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // KONTEN UTAMA SMART AI
  // =========================================================

  Widget _buildMainContent() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(36),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Apa Kegiatanmu\nHari Ini?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Huninn',
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 36),

              // INPUT SMART AI
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.sekunder,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: AppColors.sekunder,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              focusNode: _searchFocusNode,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Huninn',
                                color: AppColors.textDark,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontFamily: 'Huninn',
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (_isFocused) ...[
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        // Fungsi upload bisa ditambahkan nanti.
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.sekunder,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.upload_file,
                          size: 20,
                          color: AppColors.sekunder,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),

        // BADGE SMART AI
        Positioned(
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.sekunder,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.sekunder.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'Smart AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Anak-Bijak',
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // SIDEBAR SMART AI
  // =========================================================

  Widget _buildSidebar() {
    final query = _historySearchController.text.toLowerCase();

    final filteredPinned = _pinnedChats
        .where((chat) => chat.toLowerCase().contains(query))
        .toList();

    final filteredHistory = _chatHistory
        .where((chat) => chat.toLowerCase().contains(query))
        .toList();

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC8E5FF),
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(42),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 24,
              offset: Offset(8, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HOME DAN TOMBOL TUTUP
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _sidebarIcon(
                      asset: 'assets/icons/home_icon.svg',
                      fallback: Icons.home_outlined,
                     onTap: () {
                        Navigator.of(context).pop();
                      },
                      circular: true,
                    ),
                    _sidebarIcon(
                      asset: 'assets/icons/out.svg',
                      fallback: Icons.arrow_back_ios_new,
                      onTap: () {
                        setState(() {
                          _isSidebarOpen = false;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // SEARCH RIWAYAT
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.sekunder,
                      width: 3,
                    ),
                  ),
                  child: TextField(
                    controller: _historySearchController,
                    onChanged: (_) {
                      setState(() {});
                    },
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontFamily: 'Huninn',
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: AppColors.textDark,
                        fontFamily: 'Huninn',
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textDark,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // NEW CHAT
                _sidebarAction(
                  asset: 'assets/icons/new_chat.svg',
                  label: 'New Chat',
                  fallback: Icons.edit_outlined,
                  onTap: _startNewChat,
                  
                ),

                const SizedBox(height: 24),

                // PINNED
                const Text(
                  'Pinned',
                  style: TextStyle(
                    color: AppColors.tersier,
                    fontSize: 16,
                    fontFamily: 'Huninn',
                  ),
                ),

                const SizedBox(height: 8),

                ...filteredPinned.map(
                  (chat) => _chatTile(chat),
                ),

                const SizedBox(height: 20),

                // HISTORY
                const Text(
                  'History',
                  style: TextStyle(
                    color: AppColors.tersier,
                    fontSize: 16,
                    fontFamily: 'Huninn',
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: filteredHistory
                        .map((chat) => _chatTile(chat))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // IKON SIDEBAR
  // =========================================================

  Widget _sidebarIcon({
    required String asset,
    required IconData fallback,
    required VoidCallback onTap,
    bool circular = false,
  }) {
    return Material(
      color: circular ? const Color(0xFFFFF9E9) : Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        hoverColor: const Color(0xFFFFF9E9),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            asset,
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              AppColors.textDark,
              BlendMode.srcIn,
            ),
            placeholderBuilder: (_) => Icon(
              fallback,
              size: 32,
              color: AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TOMBOL NEW CHAT
  // =========================================================

  Widget _sidebarAction({
    required String asset,
    required String label,
    required IconData fallback,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        hoverColor: const Color(0xFFFFF9E9),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                asset,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  AppColors.textDark,
                  BlendMode.srcIn,
                ),
                placeholderBuilder: (_) => Icon(
                  fallback,
                  size: 28,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.tersier,
                  fontSize: 16,
                  fontFamily: 'Huninn',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ITEM PINNED DAN HISTORY
  // =========================================================

  Widget _chatTile(String chat) {
    final bool isActive = chat == _activeChat;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          _openChat(chat);
        },
        hoverColor: const Color(0xFFFFF9E9),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFFFFF9E9)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            chat,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 13,
              fontFamily: 'Huninn',
            ),
          ),
        ),
      ),
    );
  }
}