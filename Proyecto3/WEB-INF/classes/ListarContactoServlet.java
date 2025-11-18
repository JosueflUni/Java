package Proyecto3;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarContactoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ContactoDAO contactoDAO;

    public void init() {
        contactoDAO = new ContactoDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Obtener la lista de contactos del DAO
            List<Contacto> listaContactos = contactoDAO.listarTodos();
            
            // 2. Colocar la lista en el request para que la JSP la use
            request.setAttribute("contactos", listaContactos);
            
            // 3. Reenviar (forward) a la JSP
            // Nota: Mantenemos cualquier atributo "mensaje" o "error" que venga del redireccionamiento de otro Servlet (Crear/Modificar/Eliminar)
            request.getRequestDispatcher("listar.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar la lista de contactos: " + e.getMessage());
            request.getRequestDispatcher("listar.jsp").forward(request, response);
        }
    }
}