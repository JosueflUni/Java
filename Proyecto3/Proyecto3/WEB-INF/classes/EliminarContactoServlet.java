import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EliminarContactoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ContactoDAO contactoDAO;

    public void init() {
        contactoDAO = new ContactoDAO();
    }

    /**
     * CRITICAL FIX: Este método se deja vacío o se usa para redirigir,
     * pero la eliminación no se procesa aquí.
     * El original en listar.jsp llamaba a doGet, lo cual es inseguro.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // OPTIMIZACIÓN: Redirección a la lista para evitar la eliminación directa por URL (GET)
        response.sendRedirect("listar");
    }

    /**
     * FIX: Se implementa doPost para manejar la operación de ELIMINACIÓN de forma segura.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String error = null;
        String mensaje = null;
        
        if (idStr == null || idStr.trim().isEmpty()) {
            error = "ID de contacto no especificado para la eliminación.";
        } else {
            try {
                int id = Integer.parseInt(idStr);
                
                // 1. Eliminar en la base de datos
                boolean exito = contactoDAO.eliminar(id);
                
                if (exito) {
                    mensaje = "¡Contacto ID " + id + " eliminado con éxito!";
                } else {
                    error = "Error: No se pudo eliminar el contacto ID " + id + ". Posiblemente no existía.";
                }
                
            } catch (NumberFormatException e) {
                error = "ID de contacto inválido: " + idStr;
            } catch (Exception e) {
                error = "Error de sistema al eliminar contacto: " + e.getMessage();
            }
        }
        
        // 2. Redirigir a ListarContactoServlet con el mensaje o error (Patrón PRG)
        if (error != null) {
            request.getSession().setAttribute("error", error);
        } else {
            request.getSession().setAttribute("mensaje", mensaje);
        }
        
        response.sendRedirect("listar");
    }
}