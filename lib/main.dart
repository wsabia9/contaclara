import 'package:flutter/material.dart';

void main() {
  runApp(const ContaClaraApp());
}

class ContaClaraApp extends StatelessWidget {
  const ContaClaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContaClara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TransacoesScreen(),
    const GraficosScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGasto(context),
        backgroundColor: const Color(0xFFC9A84C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Color(0xFF0D0D0D)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0F0F0F),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, 'Início', 0),
            _navItem(Icons.list_outlined, 'Gastos', 1),
            const SizedBox(width: 48),
            _navItem(Icons.bar_chart_outlined, 'Gráficos', 2),
            _navItem(Icons.person_outline, 'Perfil', 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final active = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? const Color(0xFFC9A84C) : const Color(0xFF444444), size: 22),
            Text(label, style: TextStyle(
              color: active ? const Color(0xFFC9A84C) : const Color(0xFF444444),
              fontSize: 9, letterSpacing: 1,
            )),
          ],
        ),
      ),
    );
  }

  void _showAddGasto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (_) => const AdicionarGastoSheet(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Boa tarde', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 11, letterSpacing: 2)),
                    const Text('João Silva', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 26, fontWeight: FontWeight.w300)),
                  ]),
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC9A84C), width: 1.5),
                      color: const Color(0xFF1A1A1A),
                    ),
                    child: const Center(child: Text('J', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 18))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF2A2A2A)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('MARÇO 2026', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 10, letterSpacing: 2)),
                  const Text('Total gasto no mês', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 10, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  RichText(text: const TextSpan(children: [
                    TextSpan(text: 'R\$ ', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 24)),
                    TextSpan(text: '3.240', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 48, fontWeight: FontWeight.w300)),
                    TextSpan(text: ',50', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 28)),
                  ])),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2A2A2A)),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    _metaItem('Orçamento', 'R\$ 5.000', const Color(0xFFF5F5F5)),
                    _metaItem('Disponível', 'R\$ 1.759', const Color(0xFF52C97A)),
                    _metaItem('Usado', '64,8%', const Color(0xFFF5F5F5)),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('CATEGORIAS', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 10, letterSpacing: 3)),
                const Text('Ver todas', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 10)),
              ]),
              const SizedBox(height: 12),
              _categoryItem('🍔', 'Alimentação', 'R\$ 890', 0.89, const Color(0xFFC9A84C)),
              const SizedBox(height: 8),
              _categoryItem('🚗', 'Transporte', 'R\$ 620', 1.0, const Color(0xFFE05252)),
              const SizedBox(height: 8),
              _categoryItem('🎮', 'Lazer', 'R\$ 340', 0.42, const Color(0xFFA8A8A8)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('ÚLTIMAS TRANSAÇÕES', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 10, letterSpacing: 3)),
                const Text('Ver todas', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 10)),
              ]),
              const SizedBox(height: 12),
              _txItem('🛒', 'Mercado Extra', 'Hoje, 14:32', '- R\$ 187,40', false),
              const SizedBox(height: 8),
              _txItem('⛽', 'Posto Shell', 'Hoje, 10:15', '- R\$ 210,00', false),
              const SizedBox(height: 8),
              _txItem('💰', 'Salário', '24 mar', '+ R\$ 5.000,00', true),
              const SizedBox(height: 8),
              _txItem('🍕', 'iFood', '23 mar', '- R\$ 62,90', false),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metaItem(String label, String value, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Color(0xFF555555), fontSize: 9, letterSpacing: 1)),
      Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400)),
    ]);
  }

  Widget _categoryItem(String emoji, String name, String amount, double progress, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF222222))),
      child: Column(children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(child: Text(name, style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 13))),
          Text(amount, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400)),
        ]),
        const SizedBox(height: 10),
        ClipRRect(borderRadius: BorderRadius.circular(2), child: LinearProgressIndicator(
          value: progress > 1 ? 1 : progress,
          backgroundColor: const Color(0xFF2A2A2A),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 3,
        )),
      ]),
    );
  }

  Widget _txItem(String emoji, String name, String date, String amount, bool income) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF222222))),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 13)),
          Text(date, style: const TextStyle(color: Color(0xFF555555), fontSize: 10)),
        ])),
        Text(amount, style: TextStyle(color: income ? const Color(0xFF52C97A) : const Color(0xFFE05252), fontSize: 14, fontWeight: FontWeight.w400)),
      ]),
    );
  }
}

class TransacoesScreen extends StatelessWidget {
  const TransacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Transações', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 30, fontWeight: FontWeight.w300)),
            const SizedBox(height: 16),
            Container(
              height: 46,
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF2A2A2A))),
              child: const Row(children: [
                SizedBox(width: 14),
                Icon(Icons.search, color: Color(0xFF555555), size: 18),
                SizedBox(width: 8),
                Text('Buscar transação...', style: TextStyle(color: Color(0xFF444444), fontSize: 13)),
              ]),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF2A2A2A))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _summaryItem('Entradas', 'R\$ 5.000', const Color(0xFF52C97A)),
                Container(width: 1, height: 30, color: const Color(0xFF2A2A2A)),
                _summaryItem('Saídas', 'R\$ 3.240', const Color(0xFFE05252)),
                Container(width: 1, height: 30, color: const Color(0xFF2A2A2A)),
                _summaryItem('Saldo', 'R\$ 1.760', const Color(0xFFF5F5F5)),
              ]),
            ),
            const SizedBox(height: 20),
            _dateGroup('Hoje — 25 de março', [
              ['🛒', 'Mercado Extra', '14:32', 'Alimentação', '- R\$ 187,40', false],
              ['⛽', 'Posto Shell', '10:15', 'Transporte', '- R\$ 210,00', false],
            ]),
            const SizedBox(height: 16),
            _dateGroup('Ontem — 24 de março', [
              ['💰', 'Salário', '09:00', 'Receita', '+ R\$ 5.000,00', true],
              ['🎬', 'Netflix', '08:00', 'Lazer', '- R\$ 44,90', false],
            ]),
            const SizedBox(height: 16),
            _dateGroup('23 de março', [
              ['🍕', 'iFood', '20:14', 'Alimentação', '- R\$ 62,90', false],
              ['🚌', 'Uber', '18:40', 'Transporte', '- R\$ 28,50', false],
              ['💊', 'Farmácia', '12:05', 'Saúde', '- R\$ 95,00', false],
            ]),
            const SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(children: [
      Text(label, style: const TextStyle(color: Color(0xFF555555), fontSize: 9, letterSpacing: 1)),
      Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400)),
    ]);
  }

  Widget _dateGroup(String date, List<List<dynamic>> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(date, style: const TextStyle(color: Color(0xFF555555), fontSize: 9, letterSpacing: 2)),
      const SizedBox(height: 8),
      ...items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF222222))),
          child: Row(children: [
            Text(item[0], style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item[1], style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 13)),
              Row(children: [
                Text(item[2], style: const TextStyle(color: Color(0xFF555555), fontSize: 10)),
                const Text(' · ', style: TextStyle(color: Color(0xFF333333), fontSize: 10)),
                Text(item[3], style: const TextStyle(color: Color(0xFFC9A84C), fontSize: 9, letterSpacing: 1)),
              ]),
            ])),
            Text(item[4], style: TextStyle(color: item[5] ? const Color(0xFF52C97A) : const Color(0xFFE05252), fontSize: 13, fontWeight: FontWeight.w400)),
          ]),
        ),
      )),
    ]);
  }
}

class GraficosScreen extends StatelessWidget {
  const GraficosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Relatórios', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 30, fontWeight: FontWeight.w300)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF2A2A2A))),
                child: const Row(children: [
                  Text('Mar 2026', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 11, letterSpacing: 1)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, color: Color(0xFFC9A84C), size: 16),
                ]),
              ),
            ]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF2A2A2A))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('GASTOS POR CATEGORIA', style: TextStyle(color: Color(0xFF555555), fontSize: 10, letterSpacing: 3)),
                const SizedBox(height: 16),
                _categoryBar('🍔', 'Alimentação', 'R\$ 890', 0.89, const Color(0xFFC9A84C), '27%'),
                const SizedBox(height: 12),
                _categoryBar('🚗', 'Transporte', 'R\$ 620', 1.0, const Color(0xFFE05252), '19%'),
                const SizedBox(height: 12),
                _categoryBar('🎮', 'Lazer', 'R\$ 340', 0.42, const Color(0xFFA8A8A8), '10%'),
                const SizedBox(height: 12),
                _categoryBar('🏥', 'Saúde', 'R\$ 270', 0.34, const Color(0xFF5295E0), '8%'),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF2A2A2A))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('ÚLTIMOS 6 MESES', style: TextStyle(color: Color(0xFF555555), fontSize: 10, letterSpacing: 3)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    _bar('Out', 0.38, false),
                    _bar('Nov', 0.55, false),
                    _bar('Dez', 0.72, false),
                    _bar('Jan', 0.48, false),
                    _bar('Fev', 0.60, false),
                    _bar('Mar', 0.80, true),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: const Color(0xFF1A1500), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFC9A84C).withOpacity(0.3))),
              child: const Row(children: [
                Text('💡', style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Atenção — Transporte', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 12, fontWeight: FontWeight.w400)),
                  SizedBox(height: 4),
                  Text('Você gastou 24% a mais em transporte comparado ao mês passado.', style: TextStyle(color: Color(0xFFA8A8A8), fontSize: 11, height: 1.5)),
                ])),
              ]),
            ),
            const SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }

  Widget _categoryBar(String emoji, String name, String amount, double progress, Color color, String pct) {
    return Column(children: [
      Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(child: Text(name, style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 12))),
        Text(pct, style: const TextStyle(color: Color(0xFF555555), fontSize: 10)),
        const SizedBox(width: 8),
        Text(amount, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w400)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(borderRadius: BorderRadius.circular(2), child: LinearProgressIndicator(
        value: progress > 1 ? 1 : progress,
        backgroundColor: const Color(0xFF2A2A2A),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: 3,
      )),
    ]);
  }

  Widget _bar(String month, double height, bool active) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      if (active) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('3.240', style: const TextStyle(color: Color(0xFFC9A84C), fontSize: 8))),
      Container(width: 32, height: 100 * height, decoration: BoxDecoration(color: active ? const Color(0xFFC9A84C) : const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(6))),
      const SizedBox(height: 6),
      Text(month, style: const TextStyle(color: Color(0xFF444444), fontSize: 9)),
    ]);
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const SizedBox(height: 20),
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFC9A84C), width: 2), color: const Color(0xFF1A1A1A)),
              child: const Center(child: Text('J', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 32))),
            ),
            const SizedBox(height: 12),
            const Text('João Silva', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 24, fontWeight: FontWeight.w300)),
            const Text('joao@email.com', style: TextStyle(color: Color(0xFF555555), fontSize: 11)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF2A2A2A))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('PLANO ATUAL', style: TextStyle(color: Color(0xFF555555), fontSize: 10, letterSpacing: 2)),
                const SizedBox(height: 4),
                const Text('Gratuito', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 24, fontWeight: FontWeight.w300)),
                const SizedBox(height: 16),
                _feature('Até 20 lançamentos por mês', true),
                _feature('3 categorias básicas', true),
                _feature('Gráficos e relatórios', false),
                _feature('Alertas de limite', false),
                _feature('Lançamentos ilimitados', false),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity, height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC9A84C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    child: const Text('✦ UPGRADE — R\$ 9,90/MÊS', style: TextStyle(color: Color(0xFF0D0D0D), fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 2)),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF222222))),
              child: Column(children: [
                _menuItem(Icons.person_outline, 'Editar perfil', 'Nome, e-mail e foto'),
                const Divider(color: Color(0xFF1F1F1F), height: 1),
                _menuItem(Icons.notifications_outlined, 'Notificações', 'Alertas e avisos'),
                const Divider(color: Color(0xFF1F1F1F), height: 1),
                _menuItem(Icons.lock_outline, 'Segurança', 'Senha e Face ID'),
              ]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, height: 48,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFE05252), width: 0.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.logout, color: Color(0xFFE05252), size: 16),
                  SizedBox(width: 8),
                  Text('SAIR DA CONTA', style: TextStyle(color: Color(0xFFE05252), fontSize: 11, letterSpacing: 2)),
                ]),
              ),
            ),
            const SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }

  Widget _feature(String label, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(active ? Icons.check_circle_outline : Icons.lock_outline, color: active ? const Color(0xFFC9A84C) : const Color(0xFF333333), size: 16),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: active ? const Color(0xFFF5F5F5) : const Color(0xFF333333), fontSize: 12, decoration: active ? null : TextDecoration.lineThrough)),
      ]),
    );
  }

  Widget _menuItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFA8A8A8), size: 20),
      title: Text(title, style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 13, fontWeight: FontWeight.w300)),
      subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF555555), fontSize: 10)),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF333333), size: 18),
    );
  }
}

class AdicionarGastoSheet extends StatefulWidget {
  const AdicionarGastoSheet({super.key});

  @override
  State<AdicionarGastoSheet> createState() => _AdicionarGastoSheetState();
}

class _AdicionarGastoSheetState extends State<AdicionarGastoSheet> {
  int _selectedCat = 0;
  int _selectedPay = 0;
  bool _isDespesa = true;

  final cats = ['🍔', '🚗', '🎮', '🏥', '🏠', '👕', '📚', '➕'];
  final catNames = ['Alimentação', 'Transporte', 'Lazer', 'Saúde', 'Casa', 'Roupas', 'Educação', 'Outros'];
  final pays = ['Débito', 'Crédito', 'Pix'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          const Text('Novo lançamento', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 24, fontWeight: FontWeight.w300)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2A2A2A))),
            padding: const EdgeInsets.all(4),
            child: Row(children: [
              _typeBtn('Despesa', _isDespesa, () => setState(() => _isDespesa = true), const Color(0xFFE05252)),
              _typeBtn('Receita', !_isDespesa, () => setState(() => _isDespesa = false), const Color(0xFF52C97A)),
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF2A2A2A))),
            child: Column(children: [
              const Text('VALOR', style: TextStyle(color: Color(0xFF555555), fontSize: 10, letterSpacing: 3)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                const Text('R\$ ', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 24)),
                const Text('0,00', style: TextStyle(color: Color(0xFFF5F5F5), fontSize: 48, fontWeight: FontWeight.w300)),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          _label('Descrição'),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Color(0xFFF5F5F5), fontSize: 13),
            decoration: _inputDec('Ex: Mercado Extra'),
          ),
          const SizedBox(height: 16),
          _label('Categoria'),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1),
            itemCount: cats.length,
            itemBuilder: (_, i) {
              final selected = _selectedCat == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedCat = i),
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? const Color(0xFFC9A84C) : const Color(0xFF222222))),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(cats[i], style: const TextStyle(fontSize: 22)),
                    Text(catNames[i], style: TextStyle(color: selected ? const Color(0xFFC9A84C) : const Color(0xFF555555), fontSize: 8), textAlign: TextAlign.center),
                  ]),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _label('Pagamento'),
          const SizedBox(height: 8),
          Row(children: pays.asMap().entries.map((e) {
            final selected = _selectedPay == e.key;
            return Expanded(child: GestureDetector(
              onTap: () => setState(() => _selectedPay = e.key),
              child: Container(
                margin: EdgeInsets.only(right: e.key < pays.length - 1 ? 8 : 0),
                height: 44,
                decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? const Color(0xFFC9A84C) : const Color(0xFF222222))),
                child: Center(child: Text(e.value, style: TextStyle(color: selected ? const Color(0xFFC9A84C) : const Color(0xFF555555), fontSize: 11, letterSpacing: 1))),
              ),
            ));
          }).toList()),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC9A84C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text('SALVAR LANÇAMENTO', style: TextStyle(color: Color(0xFF0D0D0D), fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 2)),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _typeBtn(String label, bool active, VoidCallback onTap, Color color) {
    return Expanded(child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(color: active ? color.withOpacity(0.15) : Colors.transparent, borderRadius: BorderRadius.circular(9), border: active ? Border.all(color: color.withOpacity(0.3)) : null),
        child: Center(child: Text(label, style: TextStyle(color: active ? color : const Color(0xFF444444), fontSize: 11, letterSpacing: 2))),
      ),
    ));
  }

  Widget _label(String text) {
    return Text(text.toUpperCase(), style: const TextStyle(color: Color(0xFF555555), fontSize: 10, letterSpacing: 2));
  }

  InputDecoration _inputDec(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF333333)),
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2A2A2A))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2A2A2A))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC9A84C))),
    );
  }
}
```
