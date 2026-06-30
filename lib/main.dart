import 'package:flutter/material.dart';

void main() => runApp(const NcpMechanicalProApp());

const ncpBlue = Color(0xFF0057B8);
const darkBlue = Color(0xFF073B7A);

class NcpMechanicalProApp extends StatelessWidget {
  const NcpMechanicalProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NCP Mechanical Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ncpBlue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: ncpBlue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: ncpBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class VariationItem {
  VariationItem({
    required this.number,
    required this.job,
    required this.description,
    required this.location,
    required this.date,
    required this.paid,
    required this.qty,
    required this.rate,
  });

  final String number;
  final String job;
  final String description;
  final String location;
  final DateTime date;
  final bool paid;
  final double qty;
  final double rate;

  double get total => qty * rate;
}

final List<VariationItem> variations = [];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalValue = variations.fold<double>(0, (sum, item) => sum + item.total);
    final paidValue = variations.where((v) => v.paid).fold<double>(0, (sum, item) => sum + item.total);
    final unpaidValue = totalValue - paidValue;

    return Scaffold(
      appBar: AppBar(title: const Text('NCP Mechanical Pro')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _LogoHeader(),
            const SizedBox(height: 16),
            _ProjectCard(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(title: 'Open Variations', value: '${variations.where((v) => !v.paid).length}', icon: Icons.pending_actions),
                _StatCard(title: 'Total Value', value: '£${totalValue.toStringAsFixed(2)}', icon: Icons.payments),
                _StatCard(title: 'Paid', value: '£${paidValue.toStringAsFixed(2)}', icon: Icons.check_circle),
                _StatCard(title: 'Outstanding', value: '£${unpaidValue.toStringAsFixed(2)}', icon: Icons.warning_amber),
              ],
            ),
            const SizedBox(height: 20),
            _ModuleButton(title: 'Daily Briefing', icon: Icons.assignment, onTap: () => _open(context, const PlaceholderScreen(title: 'Daily Briefing'))),
            _ModuleButton(title: 'Variation Register', icon: Icons.price_change, onTap: () => _open(context, const VariationRegisterScreen())),
            _ModuleButton(title: 'QA Tracker', icon: Icons.fact_check, onTap: () => _open(context, const PlaceholderScreen(title: 'QA Tracker'))),
            _ModuleButton(title: 'Labour Tracker', icon: Icons.groups, onTap: () => _open(context, const PlaceholderScreen(title: 'Labour Tracker'))),
            _ModuleButton(title: 'Reports', icon: Icons.picture_as_pdf, onTap: () => _open(context, const PlaceholderScreen(title: 'Reports'))),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}

class _LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Image.asset('assets/images/ncp_logo.jpg', height: 90, fit: BoxFit.contain),
          const SizedBox(height: 8),
          const Text('Construction Management App', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [ncpBlue, darkBlue]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Project', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text('Waddon Phase 2', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Formation Design & Build', style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Duppas Hill Road, Croydon, CR0', style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, required this.icon});
  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > 700 ? 170 : (MediaQuery.of(context).size.width - 44) / 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: ncpBlue),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ]),
      ),
    );
  }
}

class _ModuleButton extends StatelessWidget {
  const _ModuleButton({required this.title, required this.icon, required this.onTap});
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(backgroundColor: ncpBlue.withOpacity(.12), child: Icon(icon, color: ncpBlue)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class VariationRegisterScreen extends StatefulWidget {
  const VariationRegisterScreen({super.key});

  @override
  State<VariationRegisterScreen> createState() => _VariationRegisterScreenState();
}

class _VariationRegisterScreenState extends State<VariationRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Variation Register')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ncpBlue,
        foregroundColor: Colors.white,
        onPressed: () async {
          final added = await Navigator.push<bool>(context, MaterialPageRoute(builder: (_) => const NewVariationScreen()));
          if (added == true) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('New Variation'),
      ),
      body: variations.isEmpty
          ? const Center(child: Text('No variations yet. Press New Variation.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: variations.length,
              itemBuilder: (_, index) {
                final v = variations[index];
                return Card(
                  child: ListTile(
                    title: Text('${v.number}  ${v.job}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${v.location}\n${v.description}\nDate: ${_fmt(v.date)}'),
                    isThreeLine: true,
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('£${v.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(v.paid ? 'Paid' : 'Unpaid', style: TextStyle(color: v.paid ? Colors.green : Colors.orange)),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}

class NewVariationScreen extends StatefulWidget {
  const NewVariationScreen({super.key});

  @override
  State<NewVariationScreen> createState() => _NewVariationScreenState();
}

class _NewVariationScreenState extends State<NewVariationScreen> {
  final job = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();
  final qty = TextEditingController(text: '1');
  final rate = TextEditingController(text: '0');
  DateTime date = DateTime.now();
  bool paid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Variation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _text(job, 'Job'),
          _text(description, 'Variation Description', maxLines: 3),
          _text(location, 'Location'),
          Row(children: [
            Expanded(child: _text(qty, 'Quantity', keyboard: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: _text(rate, 'Unit Rate (£)', keyboard: TextInputType.number)),
          ]),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () async {
              final selected = await showDatePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2035),
                initialDate: date,
              );
              if (selected != null) setState(() => date = selected);
            },
            icon: const Icon(Icons.calendar_month),
            label: Text('Date: ${_fmt(date)}'),
          ),
          SwitchListTile(
            value: paid,
            onChanged: (v) => setState(() => paid = v),
            title: const Text('Paid'),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Save Variation'),
          ),
        ],
      ),
    );
  }

  Widget _text(TextEditingController controller, String label, {int maxLines = 1, TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
      ),
    );
  }

  void _save() {
    final next = variations.length + 1;
    variations.add(VariationItem(
      number: 'VR-${next.toString().padLeft(4, '0')}',
      job: job.text.trim().isEmpty ? 'Mechanical Works' : job.text.trim(),
      description: description.text.trim(),
      location: location.text.trim(),
      date: date,
      paid: paid,
      qty: double.tryParse(qty.text) ?? 0,
      rate: double.tryParse(rate.text) ?? 0,
    ));
    Navigator.pop(context, true);
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$title module will be built next.', textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
