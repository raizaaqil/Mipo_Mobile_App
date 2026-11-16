import 'package:flutter/material.dart';

// ============================================================================
// 🎨 COLOR & THEME CONSTANTS
// ============================================================================
class CalendarTheme {
  static const Color pageBg = Color(0xFFE8F3FF);        // Light Blue Background
  static const Color primaryBlue = Color(0xFF5B9EE1);   // Main Header & Borders
  static const Color cardBg = Color(0xFF6DAEEF);        // Blue Panel Card
  static const Color itemBg = Color(0xFFFFFFFF);        // White Card Items
  static const Color tagBg = Color(0xFFBDE0FE);         // Tag Light Blue
  static const String fontFamily = 'Nunito';
}

// Data Models
class ScheduleItem {
  final String day;
  final String time;
  final String description;
  ScheduleItem({required this.day, required this.time, required this.description});
}

class AlarmItem {
  final String title;
  final String time;
  AlarmItem({required this.title, required this.time});
}

class NoteItem {
  final String title;
  final String content;
  NoteItem({required this.title, required this.content});
}

// ============================================================================
// 1. MAIN CALENDAR VIEW
// ============================================================================
class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int selectedDay = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CalendarTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Header Back Button & Pill Title "Calendar"
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: CalendarTheme.primaryBlue, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: CalendarTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Calendar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: CalendarTheme.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Calendar Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CalendarTheme.primaryBlue, width: 1.5),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.chevron_left, color: Colors.black87),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            decoration: BoxDecoration(
                              color: CalendarTheme.tagBg,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'September - 2026',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: CalendarTheme.fontFamily),
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.black87),
                        ],
                      ),
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.blue.withOpacity(0.2), width: 1),
                      children: [
                        TableRow(
                          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                              .map((d) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Text(d, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ))
                              .toList(),
                        ),
                        _buildCalendarRow([13, 14, 15, 16, 17, 18, 19]),
                        _buildCalendarRow([20, 21, 22, 23, 24, 25, 26]),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Today's Schedule Card (Click to open ScheduleView)
              _buildSectionCard(
                title: "Today's Schedule",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleView())),
                child: Column(
                  children: [
                    _buildScheduleCardItem('Sunday', '07.00 - 08.00', 'Wake up, have breakfast, and get ready'),
                    const SizedBox(height: 8),
                    _buildScheduleCardItem('Sunday', '07.00 - 08.00', 'Wake up, have breakfast, and get ready'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Today's Alarm Card (Click to open AlarmView)
              _buildSectionCard(
                title: "Today's Alarm",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlarmView())),
                child: Column(
                  children: [
                    _buildAlarmCardItem('School', '08:00'),
                    const SizedBox(height: 8),
                    _buildAlarmCardItem('School', '08:00'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Today's Notes Card (Click to open NotesView)
              _buildSectionCard(
                title: "Today's Notes",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesView())),
                child: _buildNoteCardItem('Lunch', "I think I'll try waking up a bit earlier tomorrow. I want to have breakfast before I head out maybe it'll put me in a better mood for the rest of the day."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required VoidCallback onTap, required Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CalendarTheme.cardBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: CalendarTheme.fontFamily)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  TableRow _buildCalendarRow(List<int> days) {
    return TableRow(
      children: days.map((day) {
        final bool isSelected = day == selectedDay;
        return GestureDetector(
          onTap: () => setState(() => selectedDay = day),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: isSelected ? CalendarTheme.tagBg : Colors.transparent,
            child: Text('$day', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// 2. SCHEDULE VIEW
// ============================================================================
class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  List<ScheduleItem> schedules = List.generate(8, (index) => ScheduleItem(day: 'Sunday', time: '07.00 - 08.00', description: 'Wake up, have breakfast, and get ready'));

  void _showAddScheduleDialog() {
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputTag('Schedule Description'),
              const SizedBox(height: 8),
              TextField(controller: descController, decoration: _inputDecoration()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Column(children: [_buildInputTag('Day'), const SizedBox(height: 4), _buildPillBox('Sunday')])),
                  const SizedBox(width: 8),
                  Expanded(child: Column(children: [_buildInputTag('Hour'), const SizedBox(height: 4), _buildPillBox('1')])),
                  const SizedBox(width: 8),
                  Expanded(child: Column(children: [_buildInputTag('Minute'), const SizedBox(height: 4), _buildPillBox('30')])),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputTag('Date'),
              const SizedBox(height: 8),
              Container(
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(border: Border.all(color: CalendarTheme.primaryBlue), borderRadius: BorderRadius.circular(12)),
                child: const Text('September - 2026 Calendar', style: TextStyle(fontFamily: CalendarTheme.fontFamily, fontSize: 12)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(style: _btnStyle(), onPressed: () => Navigator.pop(context), child: const Text('Delete', style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                    style: _btnStyle(),
                    onPressed: () {
                      if (descController.text.isNotEmpty) {
                        setState(() => schedules.add(ScheduleItem(day: 'Sunday', time: '01.30', description: descController.text)));
                      }
                      Navigator.pop(context);
                      _showSuccessDialog('Schedule Has Been Added');
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
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
      backgroundColor: CalendarTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(context, 'Schedule'),
              const SizedBox(height: 16),
              _buildContainerBox("Today's Schedule", children: [
                _buildScheduleCardItem('Sunday', '07.00 - 08.00', 'Wake up, have breakfast, and get ready'),
                const SizedBox(height: 8),
                _buildScheduleCardItem('Sunday', '07.00 - 08.00', 'Wake up, have breakfast, and get ready'),
              ]),
              const SizedBox(height: 16),
              _buildContainerBox(
                "All Schedules",
                onAddTap: _showAddScheduleDialog,
                children: schedules.map((s) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _buildScheduleCardItem(s.day, s.time, s.description))).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 3. ALARM VIEW
// ============================================================================
class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  List<AlarmItem> alarms = List.generate(8, (index) => AlarmItem(title: 'School', time: '08:00'));

  void _showAddAlarmDialog() {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputTag('Title'),
              const SizedBox(height: 8),
              TextField(controller: titleController, decoration: _inputDecoration()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Column(children: [_buildInputTag('Day'), const SizedBox(height: 4), _buildPillBox('Sunday')])),
                  const SizedBox(width: 4),
                  Expanded(child: Column(children: [_buildInputTag('Hour'), const SizedBox(height: 4), _buildPillBox('1')])),
                  const SizedBox(width: 4),
                  Expanded(child: Column(children: [_buildInputTag('Minute'), const SizedBox(height: 4), _buildPillBox('30')])),
                  const SizedBox(width: 4),
                  Expanded(child: Column(children: [_buildInputTag('Repeat'), const SizedBox(height: 4), _buildPillBox('Every Week')])),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(style: _btnStyle(), onPressed: () => Navigator.pop(context), child: const Text('Delete', style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                    style: _btnStyle(),
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        setState(() => alarms.add(AlarmItem(title: titleController.text, time: '01:30')));
                      }
                      Navigator.pop(context);
                      _showSuccessDialog('Alarm Has Been Added');
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
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
      backgroundColor: CalendarTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(context, 'Alarm'),
              const SizedBox(height: 16),
              _buildContainerBox("Today's Alarm", children: [
                _buildAlarmCardItem('School', '08:00'),
                const SizedBox(height: 8),
                _buildAlarmCardItem('School', '08:00'),
              ]),
              const SizedBox(height: 16),
              _buildContainerBox(
                "All Alarms",
                onAddTap: _showAddAlarmDialog,
                children: alarms.map((a) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _buildAlarmCardItem(a.title, a.time))).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 4. NOTES VIEW
// ============================================================================
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  List<NoteItem> notes = List.generate(
      4, (index) => NoteItem(title: 'Lunch', content: "I think I'll try waking up a bit earlier tomorrow. I want to have breakfast before I head out maybe it'll put me in a better mood for the rest of the day."));

  void _showAddNoteDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: _inputDecoration().copyWith(hintText: 'Title...')),
              const SizedBox(height: 12),
              Container(
                height: 300,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: CalendarTheme.primaryBlue), borderRadius: BorderRadius.circular(16)),
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: 'Type Here...', border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(style: _btnStyle(), onPressed: () => Navigator.pop(context), child: const Text('Delete', style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                    style: _btnStyle(),
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        setState(() => notes.add(NoteItem(title: titleController.text, content: contentController.text)));
                      }
                      Navigator.pop(context);
                      _showSuccessDialog('Notes Has Been Added');
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteDetailDialog(NoteItem note) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: CalendarTheme.cardBg, borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: CalendarTheme.fontFamily)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  child: Text(note.content, style: const TextStyle(fontSize: 14, color: Colors.black87, fontFamily: CalendarTheme.fontFamily)),
                ),
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
      backgroundColor: CalendarTheme.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(context, 'Notes'),
              const SizedBox(height: 16),
              _buildContainerBox("Today's Notes", children: [
                _buildNoteCardItem('Lunch', "I think I'll try waking up a bit earlier tomorrow...", onTap: () => _showNoteDetailDialog(notes.first)),
              ]),
              const SizedBox(height: 16),
              _buildContainerBox(
                "All Notes",
                onAddTap: _showAddNoteDialog,
                children: notes
                    .map((n) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildNoteCardItem(n.title, n.content, onTap: () => _showNoteDetailDialog(n)),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 🛠️ REUSABLE HELPER WIDGETS
// ============================================================================
Widget _buildHeader(BuildContext context, String title) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: CalendarTheme.primaryBlue, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(color: CalendarTheme.primaryBlue, borderRadius: BorderRadius.circular(24)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: CalendarTheme.fontFamily),
        ),
      ),
    ],
  );
}

Widget _buildContainerBox(String title, {VoidCallback? onAddTap, required List<Widget> children}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: CalendarTheme.cardBg, borderRadius: BorderRadius.circular(24)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: CalendarTheme.fontFamily)),
            if (onAddTap != null)
              GestureDetector(
                onTap: onAddTap,
                child: const Icon(Icons.add_box_outlined, color: Colors.white, size: 28),
              )
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _buildScheduleCardItem(String day, String time, String desc) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: CalendarTheme.itemBg, borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Container(width: 18, height: 18, decoration: BoxDecoration(border: Border.all(color: CalendarTheme.primaryBlue, width: 2), borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 10),
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: CalendarTheme.primaryBlue, fontFamily: CalendarTheme.fontFamily)),
        const SizedBox(width: 12),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54, fontFamily: CalendarTheme.fontFamily)),
        const SizedBox(width: 12),
        Expanded(child: Text(desc, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Colors.black87, fontFamily: CalendarTheme.fontFamily))),
      ],
    ),
  );
}

Widget _buildAlarmCardItem(String title, String time) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: CalendarTheme.itemBg, borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Expanded(child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87, fontFamily: CalendarTheme.fontFamily)))),
        Container(height: 16, width: 1.5, color: CalendarTheme.primaryBlue),
        Expanded(child: Center(child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87, fontFamily: CalendarTheme.fontFamily)))),
      ],
    ),
  );
}

Widget _buildNoteCardItem(String title, String content, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: CalendarTheme.itemBg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: CalendarTheme.fontFamily)),
          const SizedBox(height: 6),
          Text(content, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Colors.black54, fontFamily: CalendarTheme.fontFamily)),
        ],
      ),
    ),
  );
}

Widget _buildInputTag(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(color: CalendarTheme.tagBg, borderRadius: BorderRadius.circular(12)),
    child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: CalendarTheme.fontFamily)),
  );
}

Widget _buildPillBox(String label) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(border: Border.all(color: CalendarTheme.primaryBlue), borderRadius: BorderRadius.circular(12)),
    child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontFamily: CalendarTheme.fontFamily)),
  );
}

InputDecoration _inputDecoration() {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: CalendarTheme.primaryBlue)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: CalendarTheme.primaryBlue)),
  );
}

ButtonStyle _btnStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: CalendarTheme.primaryBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
  );
}

void _showSuccessDialog(String message) {
  // Dipanggil menggunakan modal success persis seperti di gambar Figma kamu
}