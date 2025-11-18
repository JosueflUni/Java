package Proyecto3;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CargarContactoServlet")
public class CargarContactoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ContactoDAO contactoDAO;

    public void init() {
        contactoDAO = new ContactoDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            request.getSession().setAttribute("error", "ID de contacto no especificado para la carga.");
            response.sendRedirect("listar");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            
            // 1. Buscar el contacto en la base de datos
            Contacto contactoExistente = contactoDAO.buscarPorId(id);
            
            // 2. Si se encuentra, preparar la vista (form.jsp)
            if (contactoExistente != null) {
                // Poner el objeto contacto en el request
                request.setAttribute("contacto", contactoExistente);
                // Reenviar al formulario unificado (form.jsp)
                request.getRequestDispatcher("form.jsp").forward(request, response); 
            } else {
                request.getSession().setAttribute("error", "El contacto con ID " + id + " no fue encontrado.");
                response.sendRedirect("listar");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID de contacto inválido.");
            response.sendRedirect("listar");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error al intentar cargar el contacto: " + e.getMessage());
            response.sendRedirect("listar");
        }
    }
}