package Proyecto3;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ModificarContactoServlet")
public class ModificarContactoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ContactoDAO contactoDAO;

    public void init() {
        contactoDAO = new ContactoDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Obtener parámetros del formulario (incluyendo el ID oculto)
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        
        String error = null;
        
        try {
            int id = Integer.parseInt(idStr);

            // Simple validación de campos
            if (nombre == null || nombre.trim().isEmpty() || apellido == null || apellido.trim().isEmpty() || telefono == null || telefono.trim().isEmpty()) {
                error = "Todos los campos son obligatorios.";
            } else {
                // 2. Crear el objeto Contacto con ID
                Contacto contactoActualizado = new Contacto(id, nombre, apellido, telefono);
                
                // 3. Actualizar en la base de datos
                boolean exito = contactoDAO.modificar(contactoActualizado);
                
                if (exito) {
                    // 4. Redirigir con mensaje de éxito (Patrón PRG)
                    request.getSession().setAttribute("mensaje", "¡Contacto ID " + id + " modificado con éxito!");
                    response.sendRedirect("listar");
                    return;
                } else {
                    error = "Error al intentar actualizar el contacto ID " + id + ".";
                }
            }
            
        } catch (NumberFormatException e) {
            error = "ID de contacto inválido: " + idStr;
        } catch (Exception e) {
            error = "Error de sistema al modificar contacto: " + e.getMessage();
        }
        
        // Si hay error, almacenar el error y redirigir a la vista de carga original
        request.getSession().setAttribute("error", error);
        // La redirección usa la ruta del Servlet de carga para volver al formulario
        response.sendRedirect("CargarContactoServlet?id=" + idStr); 
    }
}