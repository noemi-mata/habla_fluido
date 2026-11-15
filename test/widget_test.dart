import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habla_fluido/datos/almacen_avance.dart';
import 'package:habla_fluido/datos/voz_simulada.dart';
import 'package:habla_fluido/dependencias.dart';
import 'package:habla_fluido/presentacion/pantallas/pantalla_inicio.dart';

void main() {
  testWidgets('la pantalla de inicio muestra nivel y plan de hoy', (tester) async {
    final deps = Dependencias.crear(voz: VozSimulada(), almacen: AlmacenAvanceMemoria());
    await tester.pumpWidget(MaterialApp(home: PantallaInicio(deps: deps)));
    expect(find.textContaining('Nivel A1'), findsOneWidget);
    expect(find.textContaining('Plan de hoy (20 min)'), findsOneWidget);
  });
}