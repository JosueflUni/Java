import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 * Data Access Object para la tabla Contacto
 * Maneja todas las operaciones CRUD con la base de datos MySQL
 */
public class ContactoDAO {
    
    // ========== CONFIGURACIÓN DE CONEXIÓN (MANTENIDO, PERO SE RECOMIENDA USAR JNDI/DataSource) ==========
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
            // Se propaga la excepción como SQLException para que el cliente la maneje
            throw new SQLException("Error: No se encontró el driver de MySQL. " +
                "Asegúrate de tener mysql-connector-java en el classpath.", e);
        } catch (SQLException e) {
            // Re-lanzar un error más descriptivo sobre la conexión.
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
        
        // Se mantiene la validación de argumentos.
        if (contacto.getNombre() == null || contacto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        
        if (contacto.getApellido() == null || contacto.getApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido no puede estar vacío");
        }
        
        if (contacto.getTelefono() == null || contacto.getTelefono().trim().isEmpty()) {
            throw new IllegalArgumentException("El teléfono no puede estar vacío");
        }
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_CONTACTO)) {
            
            stmt.setString(1, contacto.getNombre().trim());
            stmt.setString(2, contacto.getApellido().trim());
            stmt.setString(3, contacto.getTelefono().trim());
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } // Cierre automático de recursos.
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
        
        Contacto contacto = null;
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CONTACTO_BY_ID)) {
            
            stmt.setInt(1, id);
            
            try(ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    contacto = new Contacto();
                    contacto.setId(rs.getInt("id"));
                    contacto.setNombre(rs.getString("nom"));
                    contacto.setApellido(rs.getString("app"));
                    contacto.setTelefono(rs.getString("tel"));
                }
            }
            
        } // Cierre automático de recursos.
        
        return contacto;
    }
    
    /**
     * Listar todos los contactos de la base de datos
     * @return Lista de contactos (vacía si no hay registros)
     * @throws SQLException si hay error en la consulta
     */
    public List<Contacto> listarTodos() throws SQLException {
        List<Contacto> contactos = new ArrayList<>();
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_CONTACTOS)) {
            
            while (rs.next()) {
                Contacto contacto = new Contacto();
                contacto.setId(rs.getInt("id"));
                contacto.setNombre(rs.getString("nom"));
                contacto.setApellido(rs.getString("app"));
                contacto.setTelefono(rs.getString("tel"));
                contactos.add(contacto);
            }
            
        } // Cierre automático de recursos.
        
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
        
        // Se mantiene la validación de argumentos.
        if (contacto.getNombre() == null || contacto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        
        if (contacto.getApellido() == null || contacto.getApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido no puede estar vacío");
        }
        
        if (contacto.getTelefono() == null || contacto.getTelefono().trim().isEmpty()) {
            throw new IllegalArgumentException("El teléfono no puede estar vacío");
        }
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_CONTACTO)) {
            
            stmt.setString(1, contacto.getNombre().trim());
            stmt.setString(2, contacto.getApellido().trim());
            stmt.setString(3, contacto.getTelefono().trim());
            stmt.setInt(4, contacto.getId());
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } // Cierre automático de recursos.
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
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_CONTACTO)) {
            
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
            
        } // Cierre automático de recursos.
    }
    
    /**
     * Contar el total de contactos en la base de datos
     * @return Número total de contactos
     * @throws SQLException si hay error en la consulta
     */
    public int contarContactos() throws SQLException {
        int total = 0;
        
        // OPTIMIZACIÓN: Uso de try-with-resources
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(COUNT_CONTACTOS)) {
            
            if (rs.next()) {
                total = rs.getInt("total");
            }
            
        } // Cierre automático de recursos.
        
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
     * @deprecated El cierre de recursos ahora es automático con try-with-resources.
     * Mantenido para evitar errores si aún se llama en algún lugar.
     */
    private void cerrarRecursos(Connection conn, Statement stmt, ResultSet rs) {
        // Lógica de cierre anterior (marcada como obsoleta/innecesaria en código refactorizado)
    }
    
    /**
     * Probar la conexión a la base de datos
     * @return true si la conexión es exitosa
     */
    public boolean probarConexion() {
        try (Connection conn = getConnection()) { // Uso de try-with-resources aquí también
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Error al probar conexión: " + e.getMessage());
            return false;
        }
    }
}