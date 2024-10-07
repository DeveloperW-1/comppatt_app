import '../config/connection.config.dart';
import "../models/cliente.dart";

class ClienteController {
  final Database db = Database();

  // Crear un cliente
  Future<void> crearCliente(Cliente cliente) async {
    final conn = await db.getConnection();
    try {
      await conn.query(
        'INSERT INTO cliente (Nombre, Telefono, Correo_Electronico, RFC, CURP, Domicilio, Dias_Credito) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [
          cliente.nombre,
          cliente.telefono,
          cliente.correoElectronico,
          cliente.rfc,
          cliente.curp,
          cliente.domicilio,
          cliente.diasCredito
        ]
      );
      print('Cliente insertado con éxito.');
    } catch (e) {
      print('Error al insertar cliente: $e');
    } finally {
      await conn.close();
    }
  }

  // Leer todos los clientes
  Future<List<Cliente>> obtenerClientes() async {
    final conn = await db.getConnection();
    List<Cliente> clientes = [];

    try {
      var results = await conn.query('SELECT * FROM cliente');
      for (var row in results) {
        clientes.add(Cliente(
          nombre: row['Nombre'],
          telefono: row['Telefono'],
          correoElectronico: row['Correo_Electronico'],
          rfc: row['RFC'],
          curp: row['CURP'],
          domicilio: row['Domicilio'],
          diasCredito: row['Dias_Credito'],
        ));
      }
      print('Clientes obtenidos con éxito.');
      return clientes;
    } catch (e) {
      print('Error al obtener clientes: $e');
    } finally {
      await conn.close();
    }

    return clientes;
  }

  // Actualizar un cliente
  Future<void> actualizarCliente(String curp, Cliente cliente) async {
    final conn = await db.getConnection();
    try {
      await conn.query(
        'UPDATE cliente SET Nombre = ?, Telefono = ?, Correo_Electronico = ?, RFC = ?, Domicilio = ?, Dias_Credito = ? WHERE CURP = ?',
        [
          cliente.nombre,
          cliente.telefono,
          cliente.correoElectronico,
          cliente.rfc,
          cliente.domicilio,
          cliente.diasCredito,
          curp
        ]
      );
      print('Cliente actualizado con éxito.');
    } catch (e) {
      print('Error al actualizar cliente: $e');
    } finally {
      await conn.close();
    }
  }

  // Eliminar un cliente
  Future<void> eliminarCliente(String curp) async {
    final conn = await db.getConnection();
    try {
      await conn.query('DELETE FROM cliente WHERE CURP = ?', [curp]);
      print('Cliente eliminado con éxito.');
    } catch (e) {
      print('Error al eliminar cliente: $e');
    } finally {
      await conn.close();
    }
  }
}
