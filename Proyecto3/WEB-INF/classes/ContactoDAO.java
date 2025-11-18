package Proyecto3;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para la tabla Contacto
 * Maneja todas las operaciones CRUD con la base de datos MySQL
 */
public class ContactoDAO {
    
    // ========== CONFIGURACIÓN DE CONEXIÓN ==========
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/serv";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    // ========== CONSULTAS SQL ==========
    private static final String INSERT_CONTACTO = 
        "INSERT INTO contacto (nom, app, tel) VALUES (?, ?, ?)";
    
    private static final String SELECT_CONTACTO_BY_ID = 
        "SELECT id, nom, app, tel FROM contacto WHERE id = ?";
    
    private static final String SELECT_ALL_CONTACTOS = 
        "SELECT id, nom, app, tel FROM contacto ORDER BY id ASC";
    
    private static final String UPDATE_CONTACTO = 
        "UPDATE contacto SET nom = ?, app = ?, tel = ? WHERE id = ?";
    
    private static final String DELETE_CONTACTO = 
        "DELETE FROM contacto WHERE id = ?";
    
    private static final String COUNT_CONTACTOS = 
        "SELECT COUNT(*) as total FROM contacto";
    
    /**
     * Obtener conexión a la base de datos MySQL
     * @return Connection objeto de conexión
     * @throws SQLException si hay error de conexión
     */
    private Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error: No se encontró el driver de MySQL. " +
                "Asegúrate de tener mysql-connector-java en el classpath.", e);
        } catch (SQLException e) {
            throw new SQLException("Error de conexión a la base de datos. " +
                "Verifica que MySQL esté ejecutándose y las credenciales sean correctas.", e);
        }
    }
    
    /**
     * Crear un nuevo contacto en la base de datos
     * @param contacto Objeto Contacto con los datos a insertar
     * @return true si se creó exitosamente, false en caso contrario
     * @throws SQLException si hay error en la operación
     */
    public boolean crear(Contacto contacto) throws SQLException {
        if (contacto == null) {
            throw new IllegalArgumentException("El contacto no puede ser nulo");
        }
        
        if (contacto.getNombre() == null || contacto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        
        if (contacto.getApellido() == null || contacto.getApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido no puede estar vacío");
        }
        
        if (contacto.getTelefono() == null || contacto.getTelefono().trim().isEmpty()) {
            throw new IllegalArgumentException("El teléfono no puede estar vacío");
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(INSERT_CONTACTO);
            
            stmt.setString(1, contacto.getNombre().trim());
            stmt.setString(2, contacto.getApellido().trim());
            stmt.setString(3, contacto.getTelefono().trim());
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } finally {
            cerrarRecursos(conn, stmt, null);
        }
    }
    
    /**
     * Buscar un contacto por su ID
     * @param id ID del contacto a buscar
     * @return Objeto Contacto si existe, null si no se encuentra
     * @throws SQLException si hay error en la consulta
     */
    public Contacto buscarPorId(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("El ID debe ser un número positivo");
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Contacto contacto = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SELECT_CONTACTO_BY_ID);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                contacto = new Contacto();
                contacto.setId(rs.getInt("id"));
                contacto.setNombre(rs.getString("nom"));
                contacto.setApellido(rs.getString("app"));
                contacto.setTelefono(rs.getString("tel"));
            }
            
        } finally {
            cerrarRecursos(conn, stmt, rs);
        }
        
        return contacto;
    }
    
    /**
     * Listar todos los contactos de la base de datos
     * @return Lista de contactos (vacía si no hay registros)
     * @throws SQLException si hay error en la consulta
     */
    public List<Contacto> listarTodos() throws SQLException {
        List<Contacto> contactos = new ArrayList<>();
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(SELECT_ALL_CONTACTOS);
            
            while (rs.next()) {
                Contacto contacto = new Contacto();
                contacto.setId(rs.getInt("id"));
                contacto.setNombre(rs.getString("nom"));
                contacto.setApellido(rs.getString("app"));
                contacto.setTelefono(rs.getString("tel"));
                contactos.add(contacto);
            }
            
        } finally {
            cerrarRecursos(conn, stmt, rs);
        }
        
        return contactos;
    }
    
    /**
     * Modificar un contacto existente
     * @param contacto Objeto Contacto con los datos actualizados (debe incluir ID)
     * @return true si se modificó exitosamente, false si no se encontró el registro
     * @throws SQLException si hay error en la operación
     */
    public boolean modificar(Contacto contacto) throws SQLException {
        if (contacto == null) {
            throw new IllegalArgumentException("El contacto no puede ser nulo");
        }
        
        if (contacto.getId() <= 0) {
            throw new IllegalArgumentException("El ID del contacto debe ser válido");
        }
        
        if (contacto.getNombre() == null || contacto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        
        if (contacto.getApellido() == null || contacto.getApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido no puede estar vacío");
        }
        
        if (contacto.getTelefono() == null || contacto.getTelefono().trim().isEmpty()) {
            throw new IllegalArgumentException("El teléfono no puede estar vacío");
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(UPDATE_CONTACTO);
            
            stmt.setString(1, contacto.getNombre().trim());
            stmt.setString(2, contacto.getApellido().trim());
            stmt.setString(3, contacto.getTelefono().trim());
            stmt.setInt(4, contacto.getId());
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } finally {
            cerrarRecursos(conn, stmt, null);
        }
    }
    
    /**
     * Eliminar un contacto de la base de datos
     * @param id ID del contacto a eliminar
     * @return true si se eliminó exitosamente, false si no se encontró el registro
     * @throws SQLException si hay error en la operación
     */
    public boolean eliminar(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("El ID debe ser un número positivo");
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(DELETE_CONTACTO);
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } finally {
            cerrarRecursos(conn, stmt, null);
        }
    }
    
    /**
     * Contar el total de contactos en la base de datos
     * @return Número total de contactos
     * @throws SQLException si hay error en la consulta
     */
    public int contarContactos() throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int total = 0;
        
        try {
            conn = getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(COUNT_CONTACTOS);
            
            if (rs.next()) {
                total = rs.getInt("total");
            }
            
        } finally {
            cerrarRecursos(conn, stmt, rs);
        }
        
        return total;
    }
    
    /**
     * Verificar si existe un contacto con el ID especificado
     * @param id ID del contacto
     * @return true si existe, false en caso contrario
     * @throws SQLException si hay error en la consulta
     */
    public boolean existe(int id) throws SQLException {
        return buscarPorId(id) != null;
    }
    
    /**
     * Cerrar recursos de base de datos de forma segura
     * @param conn Conexión a cerrar
     * @param stmt Statement a cerrar
     * @param rs ResultSet a cerrar
     */
    private void cerrarRecursos(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar ResultSet: " + e.getMessage());
        }
        
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar Statement: " + e.getMessage());
        }
        
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar Connection: " + e.getMessage());
        }
    }
    
    /**
     * Probar la conexión a la base de datos
     * @return true si la conexión es exitosa
     */
    public boolean probarConexion() {
        Connection conn = null;
        try {
            conn = getConnection();
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Error al probar conexión: " + e.getMessage());
            return false;
        } finally {
            cerrarRecursos(conn, null, null);
        }
    }
}
