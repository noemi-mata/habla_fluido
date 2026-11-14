import 'package:flutter_test/flutter_test.dart';
import 'package:habla_fluido/dominio/excepciones.dart';
import 'package:habla_fluido/dominio/nivel.dart';
import 'package:habla_fluido/dominio/reglas.dart';

void main() {
  group('NivelCefr', () {
    test('etiqueta en mayúsculas', () {
      expect(NivelCefr.b1.etiqueta, 'B1');
    });
    test('siguiente nivel y el último no tiene siguiente', () {
      expect(NivelCefr.a1.siguiente, NivelCefr.a2);
      expect(NivelCefr.b2.siguiente, NivelCefr.c1);
      expect(NivelCefr.c1.siguiente, isNull);
    });
  });

  group('Habilidad', () {
    test('son 5 y tienen nombre en español', () {
      expect(Habilidad.values.length, 5);
      expect(Habilidad.escucha.nombre, 'Oído');
      expect(Habilidad.pronunciacion.nombre, 'Pronunciación');
    });
  });

  group('Reglas', () {
    test('perillas pedagógicas principales', () {
      expect(Reglas.minutosPorSesion, 20);
      expect(Reglas.umbralAprobado, 0.8);
      expect(Reglas.maxCorreccionesPorTurno, 2);
    });
  });

  group('mensajeSeguro', () {
    test('los errores propios muestran su mensaje', () {
      expect(mensajeSeguro(const TutorNoDisponibleException()),
          'El tutor no está disponible ahora. Intenta en un momento.');
      expect(mensajeSeguro(const DatosInvalidosException('Falta texto')), 'Falta texto');
    });
    test('los errores inesperados NO revelan detalles', () {
      expect(mensajeSeguro(Exception('ruta /secreta sk-123')),
          'Ocurrió un error inesperado. Intenta de nuevo.');
    });
  });
}