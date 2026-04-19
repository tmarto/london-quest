import 'package:flutter/material.dart';
import '../data/trip_data.dart';
import '../models/attraction.dart';
import '../services/score_service.dart';

class EditScheduleScreen extends StatefulWidget {
  const EditScheduleScreen({super.key});

  @override
  State<EditScheduleScreen> createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, List<String>> _schedule = {};
  bool _loading = true;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tripDays.length, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final s = await ScoreService.getSchedule();
    // Deep copy so we can mutate freely
    setState(() {
      _schedule = s.map((k, v) => MapEntry(k, List<String>.from(v)));
      _loading = false;
    });
  }

  Future<void> _save() async {
    await ScoreService.saveSchedule(_schedule);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Horário guardado! ✅'),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context, true); // true = changed
  }

  Future<void> _reset() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a2e),
        title: const Text('Repor horário original?',
            style: TextStyle(color: Colors.white)),
        content: const Text('Todas as alterações serão perdidas.',
            style: TextStyle(color: Colors.white60)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Repor',
                style: TextStyle(color: Color(0xFFDC143C))),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await ScoreService.resetSchedule();
    await _load();
    setState(() => _dirty = false);
  }

  void _moveAttraction(String id, int fromDay, int toDay) {
    setState(() {
      _schedule[fromDay]?.remove(id);
      _schedule[toDay] = [...(_schedule[toDay] ?? []), id];
      _dirty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 8, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('✏️ Editar Horário',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 11)),
                          Text('Organizar atrações por dia',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh,
                          color: Colors.white38, size: 16),
                      label: const Text('Repor',
                          style: TextStyle(
                              color: Colors.white38, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              // Tab bar
              Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: const Color(0xFFDC143C).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  labelStyle: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold),
                  tabs: tripDays
                      .map((d) => Tab(text: '${d.emoji} Dia ${d.number}'))
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              // Tab content
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFFDC143C)))
                    : TabBarView(
                        controller: _tabController,
                        children: tripDays.map((day) {
                          final ids = _schedule[day.number] ?? [];
                          final attractions = ids
                              .map((id) => attractionById[id])
                              .whereType<Attraction>()
                              .toList();
                          return _DayTab(
                            day: day,
                            attractions: attractions,
                            allDays: tripDays
                                .map((d) => d.number)
                                .where((n) => n != day.number)
                                .toList(),
                            onReorder: (oldIdx, newIdx) {
                              setState(() {
                                if (newIdx > oldIdx) newIdx--;
                                final list = List<String>.from(ids);
                                final item = list.removeAt(oldIdx);
                                list.insert(newIdx, item);
                                _schedule[day.number] = list;
                                _dirty = true;
                              });
                            },
                            onMove: (id, toDay) =>
                                _moveAttraction(id, day.number, toDay),
                          );
                        }).toList(),
                      ),
              ),
              // Save button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _dirty ? _save : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      disabledBackgroundColor: Colors.white12,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      _dirty ? 'Guardar Alterações ✅' : 'Sem alterações',
                      style: TextStyle(
                        color: _dirty ? Colors.white : Colors.white38,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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
}

class _DayTab extends StatelessWidget {
  final dynamic day;
  final List<Attraction> attractions;
  final List<int> allDays;
  final void Function(int oldIdx, int newIdx) onReorder;
  final void Function(String id, int toDay) onMove;

  const _DayTab({
    required this.day,
    required this.attractions,
    required this.allDays,
    required this.onReorder,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    if (attractions.isEmpty) {
      return const Center(
        child: Text('Sem atrações neste dia.\nMove atrações de outros dias.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 14)),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      onReorder: onReorder,
      proxyDecorator: (child, index, animation) => Material(
        color: Colors.transparent,
        child: child,
      ),
      itemCount: attractions.length,
      itemBuilder: (ctx, i) {
        final a = attractions[i];
        return Container(
          key: ValueKey(a.id),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              // Drag handle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.drag_handle, color: Colors.white24),
              ),
              // Emoji
              Container(
                width: 48,
                height: 52,
                decoration: BoxDecoration(
                  color: a.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(a.emoji,
                      style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              // Name
              Expanded(
                child: Text(
                  a.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Move to day popup
              PopupMenuButton<int>(
                icon: const Icon(Icons.swap_horiz,
                    color: Colors.white38, size: 20),
                color: const Color(0xFF1a1a2e),
                tooltip: 'Mover para outro dia',
                itemBuilder: (ctx) => allDays
                    .map((n) => PopupMenuItem(
                          value: n,
                          child: Text(
                            'Mover para Dia $n',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ))
                    .toList(),
                onSelected: (toDay) => onMove(a.id, toDay),
              ),
            ],
          ),
        );
      },
    );
  }
}
