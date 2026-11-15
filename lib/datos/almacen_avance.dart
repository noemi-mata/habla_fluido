import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dominio/almacen.dart';

/// Almacén en memoria: para pruebas (simula guardar como JSON de ida y vuelta).
class AlmacenAvanceMemoria implements AlmacenAvance {
  Map<String, Object?>? _datos;

  @override
  Future<Map<String, Object?>?> cargar() async => _datos;

  @override
  Future<void> guardar(Map<String, Object?> datos) async =>
      _datos = jsonDecode(jsonEncode(datos)) as Map<String, Object?>;
}

/// Almacén real del teléfono con shared_preferences.
class AlmacenAvancePrefs implements AlmacenAvance {
  static const _clave = 'avance_v1';

  @override
  Future<Map<String, Object?>?> cargar() async {
    final t = (await SharedPreferences.getInstance()).getString(_clave);
    if (t == null) return null;
    try {
      return (jsonDecode(t) as Map).cast<String, Object?>();
    } catch (_) {
      return null; // archivo dañado: empezamos limpio
    }
  }

  @override
  Future<void> guardar(Map<String, Object?> datos) async =>
      (await SharedPreferences.getInstance()).setString(_clave, jsonEncode(datos));
}