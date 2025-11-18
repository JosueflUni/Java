package Proyecto3;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CrearContactoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ContactoDAO contactoDAO;

    public void init() {
        contactoDAO = new ContactoDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Asegurar que se procesen los caracteres UTF-8 (acentos, ñ)
        request.setCharacterEncoding("UTF-8");
        
        // 1. Obtener parámetros del formulario (form.jsp)
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");

        // Simple validación
        if (nombre == null || nombre.trim().isEmpty() || apellido == null || apellido.trim().isEmpty() || telefono == null || telefono.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("form.jsp").forward(request, response);
            return;
        }
        
        // 2. Crear el objeto Contacto
        Contacto nuevoContacto = new Contacto(nombre, apellido, telefono);
        
        String mensaje = null;
        String error = null;
        
        try {
            // 3. Insertar en la base de datos
            boolean exito = contactoDAO.crear(nuevoContacto);
            
            if (exito) {
                mensaje = "¡Contacto creado con éxito! (" + nombre + " " + apellido + ")";
            } else {
                error = "Error al intentar crear el contacto en la base de datos.";
            }
            
        } catch (Exception e) {
            error = "Error de sistema al crear contacto: " + e.getMessage();
        }
        
        // 4. Patrón Post/Redirect/Get (Redirigir a ListarContactoServlet)
        if (error != null) {
            request.getSession().setAttribute("error", error);
            // Reenviar a la misma página del formulario para ver el error
            response.sendRedirect("form.jsp"); 
        } else {
            // Se usa el scope de session para pasar mensajes después de un redirect
            request.getSession().setAttribute("mensaje", mensaje); 
            // Redirigir al Servlet de listar
            response.sendRedirect("listar"); 
        }
    }
}