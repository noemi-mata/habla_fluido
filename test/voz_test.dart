import 'package:flutter_test/flutter_test.dart';
import 'package:habla_fluido/datos/voz_simulada.dart';
import 'package:habla_fluido/dominio/voz.dart';

void main() {
  group('VozSimulada', () {
    test('cumple el contrato Voz', () {
      expect(VozSimulada(), isA<Voz>());
    });
    test('guarda lo que dijo y a qué velocidad', () async {
      final v = VozSimulada();
      await v.hablar('Nice to meet you.');
      await v.hablar('The ship is big.', velocidad: 0.6);
      expect(v.dichos, ['Nice to meet you.', 'The ship is big.']);
      expect(v.velocidades, [1.0, 0.6]);
    });
    test('escucha en orden lo programado y luego devuelve null (silencio)', () async {
      final v = VozSimulada(['hello'])..programar('good morning');
      expect(await v.escuchar(), 'hello');
      expect(await v.escuchar(), 'good morning');
      expect(await v.escuchar(), isNull);
      expect(v.escuchas, 3);
    });
  });
}