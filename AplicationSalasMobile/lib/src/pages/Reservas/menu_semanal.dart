import 'package:salas_mobile/src/pages/Reservas/circle_dayweek.dart';
import 'package:salas_mobile/src/pages/Reservas/reservas_page.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSemanal extends StatefulWidget {
  const MenuSemanal({super.key});

  @override
  State<MenuSemanal> createState() => _MenuSemanalState();
}

class _MenuSemanalState extends State<MenuSemanal> with SingleTickerProviderStateMixin {
  late TabController _nestedTabController;
  late SalaProvider salaProvider;
  late int active = DateTime.now().weekday - 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    salaProvider = Provider.of<SalaProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 7, vsync: this, initialIndex: DateTime.now().weekday - 1);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).appBarTheme.backgroundColor
          : Theme.of(context).appBarTheme.backgroundColor,
      appBar: TabBar(
        controller: _nestedTabController,
        indicatorColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade300
            : Colors.grey.shade500,
        labelColor: Colors.white,
        unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white60
            : Colors.white38,
        isScrollable: true,
        indicator: DotIndicator(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0xfff9faf7),
            radius: 5
        ),
        indicatorPadding: const EdgeInsets.only(bottom: 4),
        tabs: const <Widget>[
          Tab(text: "SEG"),
          Tab(text: "TER"),
          Tab(text: "QUA"),
          Tab(text: "QUI"),
          Tab(text: "SEX"),
          Tab(
            child: Text("SAB"),
          ),
          Tab(text: "DOM"),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Theme.of(context).colorScheme.primary,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )
            ),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                ReservasPage(salaProvider: salaProvider, filtroDia: 'seg',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'ter',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'qua',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'qui',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'sex',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'sab',),
                ReservasPage(salaProvider: salaProvider, filtroDia: 'dom',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends Decoration {
  const DotIndicator({
    this.color = Colors.white,
    this.radius = 4.0,
  });
  final Color color;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(
      color: color,
      radius: radius,
      onChange: onChanged,
    );
  }
}

class _DotPainter extends BoxPainter {
  _DotPainter({
    required this.color,
    required this.radius,
    VoidCallback? onChange,
  })  : _paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill,
        super(onChange);

  final Paint _paint;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    canvas.drawCircle(
      Offset(rect.bottomCenter.dx, rect.bottomCenter.dy - radius),
      radius,
      _paint,
    );
  }
}