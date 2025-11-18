<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Proyecto3.Contacto" %> <%-- CORRECCIÓN AÑADIDA --%>
<%
    List<Contacto> contactos = (List<Contacto>) request.getAttribute("contactos");
    boolean tieneContactos = (contactos != null && !contactos.isEmpty());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    </head>
<body>
    <a href="index.jsp" class="btn btn-light btn-back">
        <i class="fas fa-arrow-left"></i> Volver al inicio
    </a>

    <div class="container-fluid">
        <div class="table-container">
            <div class="header-section">
                <div>
                    <h1 class="table-title">
                        <i class="fas fa-address-book"></i> Lista de Contactos
                    </h1>
                </div>
                <div class="d-flex gap-2">
                    <div class="search-box">
                        <input type="text" 
                               id="searchInput" 
                               placeholder="Buscar contacto..." 
                               onkeyup="filtrarContactos()">
                        <i class="fas fa-search"></i>
                    </div>
                    <button onclick="location.reload()" class="btn btn-refresh">
                        <i class="fas fa-sync-alt me-2"></i>Actualizar
                    </button>
                    <a href="form.jsp" class="btn btn-success">
                        <i class="fas fa-plus me-2"></i>Nuevo
                    </a>
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <strong>Error:</strong> <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <% 
                // Mensaje de éxito después de una operación (se usa el mismo atributo "mensaje")
                if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>¡Éxito!</strong> <%= request.getAttribute("mensaje") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <% if (tieneContactos) { %>
                <div class="table-responsive">
                    <table class="table table-hover" id="tablaContactos">
                        <tbody>
                            <% for (Contacto contacto : contactos) { %>
                                <tr>
                                    <td><span class="badge-id"><%= contacto.getId() %></span></td>
                                    <td><strong><%= contacto.getNombre() %></strong></td>
                                    <td><%= contacto.getApellido() %></td>
                                    <td>
                                        <i class="fas fa-phone-alt text-muted me-2"></i>
                                        <%= contacto.getTelefono() %>
                                    </td>
                                    <td class="text-center">
                                        <a href="CargarContactoServlet?id=<%= contacto.getId() %>" 
                                           class="btn btn-action btn-edit"
                                           title="Modificar contacto">
                                            <i class="fas fa-edit"></i> Editar
                                        </a>
                                        <a href="EliminarContactoServlet?id=<%= contacto.getId() %>" 
                                           class="btn btn-action btn-delete"
                                           title="Eliminar contacto"
                                           onclick="return confirmarEliminacion('<%= contacto.getNombre() %> <%= contacto.getApellido() %>', <%= contacto.getId() %>);">
                                            <i class="fas fa-trash"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    Total de contactos registrados: <strong><%= contactos.size() %></strong>
                </div>
            <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-address-book"></i>
                    <h3>No hay contactos registrados</h3>
                    <p class="text-muted">
                        Aún no has agregado ningún contacto a tu agenda.<br>
                        ¡Comienza ahora y organiza tus contactos!
                    </p>
                    <a href="form.jsp" class="btn btn-create">
                        <i class="fas fa-plus me-2"></i>Crear Primer Contacto
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función de búsqueda en tiempo real
        function filtrarContactos() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('tablaContactos');
            const rows = table.getElementsByTagName('tr');
            
            let visibleCount = 0;
            
            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                let found = false;
                
                for (let j = 0; j < cells.length - 1; j++) {
                    const cellText = cells[j].textContent || cells[j].innerText;
                    if (cellText.toLowerCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
                
                if (found) {
                    rows[i].style.display = '';
                    visibleCount++;
                } else {
                    rows[i].style.display = 'none';
                }
            }
            
            // Mostrar mensaje si no hay resultados
            if (visibleCount === 0 && filter !== '') {
                if (!document.getElementById('noResults')) {
                    const tbody = table.getElementsByTagName('tbody')[0];
                    const row = tbody.insertRow(0);
                    row.id = 'noResults';
                    const cell = row.insertCell(0);
                    cell.colSpan = 5;
                    cell.className = 'text-center text-muted py-4';
                    cell.innerHTML = '<i class="fas fa-search"></i> No se encontraron contactos que coincidan con la búsqueda';
                }
            } else {
                const noResultsRow = document.getElementById('noResults');
                if (noResultsRow) {
                    noResultsRow.remove();
                }
            }
        }

        // Función de confirmación de eliminación (MODIFICACIÓN)
        function confirmarEliminacion(nombre, id) {
            return confirm(
                '⚠️ CONFIRMACIÓN DE ELIMINACIÓN\n\n' +
                '¿Está seguro de que desea eliminar el contacto:\n' +
                'ID: ' + id + ' - Nombre: ' + nombre + '\n\n' +
                '⚠️ Esta acción es PERMANENTE y NO se puede deshacer.'
            );
        }
        
        // Limpiar búsqueda al cargar
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('searchInput').value = '';
        });
    </script>
</body>
</html>