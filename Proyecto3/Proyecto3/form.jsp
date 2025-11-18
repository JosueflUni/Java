<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Proyecto3.Contacto" %>
<%
    // Recuperar el contacto del request. Si es nulo, estamos en modo CREAR.
    Contacto contacto = (Contacto) request.getAttribute("contacto");
    boolean esModificar = (contacto != null && contacto.getId() > 0);
    
    // Títulos y Acciones
    String pageTitle = esModificar ? "Modificar Contacto" : "Crear Nuevo Contacto";
    String formTitle = esModificar ? "Editar Contacto Existente" : "Crear Nuevo Contacto";
    String formSubtitle = esModificar ? "Actualice los datos del contacto ID: " + contacto.getId() : "Complete el formulario para agregar un contacto";
    String formAction = esModificar ? "ModificarContactoServlet" : "CrearContactoServlet";
    String buttonText = esModificar ? "Guardar Cambios" : "Crear Contacto";
    String buttonIcon = esModificar ? "fa-save" : "fa-plus";
    String buttonClass = esModificar ? "btn-primary" : "btn-success";
    String iconCircleClass = esModificar ? "bg-primary" : "bg-success";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %> - Sistema de Gestión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Estilos CSS (Se toma la base de crear.jsp y modificar.jsp) */
        * { font-family: 'Poppins', sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px 0; display: flex; align-items: center; justify-content: center; }
        .form-container { max-width: 600px; width: 100%; margin: 20px; background: white; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); padding: 40px; }
        .form-title { color: #667eea; font-weight: 700; margin-bottom: 10px; text-align: center; font-size: 2rem; }
        .form-subtitle { color: #6c757d; text-align: center; margin-bottom: 30px; font-size: 0.95rem; }
        .btn-back { position: fixed; top: 20px; left: 20px; z-index: 1000; box-shadow: 0 4px 12px rgba(0,0,0,0.15); border: none; padding: 12px 20px; font-weight: 500; transition: all 0.3s ease; }
        .btn-back:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(0,0,0,0.2); }
        .form-label { font-weight: 600; color: #495057; margin-bottom: 8px; font-size: 0.9rem; }
        .form-label i { color: #667eea; margin-right: 5px; }
        .form-control { border: 2px solid #e9ecef; border-radius: 10px; padding: 12px 15px; font-size: 0.95rem; transition: all 0.3s ease; }
        .form-control:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25); }
        .btn-custom { border: none; border-radius: 10px; padding: 15px; font-size: 1.1rem; font-weight: 600; color: white; transition: all 0.3s ease; }
        .btn-success { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3); }
        .btn-primary { background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3); }
        .btn-custom:hover { transform: translateY(-2px); }
        .icon-circle { width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; color: white; font-size: 2rem; }
        .bg-success { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); }
        .bg-primary { background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); }
        .required { color: #dc3545; margin-left: 3px; }
    </style>
</head>
<body>
    <a href="listar" class="btn btn-light btn-back">
        <i class="fas fa-arrow-left"></i> Volver a la lista
    </a>

    <div class="container">
        <div class="form-container">
            <div class="icon-circle <%= iconCircleClass %>">
                <i class="fas <%= esModificar ? "fa-user-edit" : "fa-user-plus" %>"></i>
            </div>
            
            <h1 class="form-title"><%= formTitle %></h1>
            <p class="form-subtitle"><%= formSubtitle %></p>

            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>¡Éxito!</strong> <%= request.getAttribute("mensaje") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <strong>Error:</strong> <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <form method="post" action="<%= formAction %>" id="formContacto" novalidate>
                <% if (esModificar) { %>
                    <input type="hidden" name="id" value="<%= contacto.getId() %>">
                <% } %>
                
                <div class="mb-3">
                    <label for="nombre" class="form-label">
                        <i class="fas fa-user"></i> Nombre<span class="required">*</span>
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="nombre" 
                           name="nombre" 
                           placeholder="Ej: Juan"
                           maxlength="100"
                           value="<%= esModificar ? contacto.getNombre() : "" %>"
                           required
                           autofocus>
                </div>

                <div class="mb-3">
                    <label for="apellido" class="form-label">
                        <i class="fas fa-user"></i> Apellido<span class="required">*</span>
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="apellido" 
                           name="apellido" 
                           placeholder="Ej: Pérez"
                           maxlength="100"
                           value="<%= esModificar ? contacto.getApellido() : "" %>"
                           required>
                </div>

                <div class="mb-4">
                    <label for="telefono" class="form-label">
                        <i class="fas fa-phone"></i> Teléfono<span class="required">*</span>
                    </label>
                    <input type="tel" 
                           class="form-control" 
                           id="telefono" 
                           name="telefono" 
                           placeholder="Ej: 222-1234567"
                           maxlength="20"
                           value="<%= esModificar ? contacto.getTelefono() : "" %>"
                           required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-custom <%= buttonClass %>">
                        <i class="fas <%= buttonIcon %> me-2"></i><%= buttonText %>
                    </button>
                </div>
            </form>

            <div class="text-center mt-4">
                <small class="text-muted">
                    <i class="fas fa-info-circle"></i> 
                    Todos los campos marcados con <span class="required">*</span> son obligatorios
                </small>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validación del formulario con Bootstrap (similar a crear.jsp)
        (function() {
            'use strict';
            const form = document.getElementById('formContacto');
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        })();
        
        // Auto-cerrar alertas después de 5 segundos
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>