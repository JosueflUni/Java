<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Contacto contacto = (Contacto) request.getAttribute("contacto");
    boolean contactoEncontrado = (contacto != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Contacto - Sistema de Gestión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .form-container {
            max-width: 700px;
            width: 100%;
            margin: 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-title {
            color: #dc3545;
            font-weight: 700;
            margin-bottom: 10px;
            text-align: center;
            font-size: 2rem;
        }
        
        .form-subtitle {
            color: #6c757d;
            text-align: center;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }
        
        .btn-back {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border: none;
            padding: 12px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.2);
        }
        
        .search-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
        }
        
        .search-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 15px;
        }
        
        .warning-box {
            background: linear-gradient(135deg, #fff3cd 0%, #ffe69c 100%);
            border-left: 5px solid #ffc107;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }
        
        .warning-box h5 {
            color: #856404;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .warning-box p {
            color: #856404;
            margin-bottom: 0;
            font-size: 0.95rem;
        }
        
        .contact-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 15px;
            border: 2px solid #dee2e6;
        }
        
        .contact-info {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .contact-info:last-child {
            border-bottom: none;
        }
        
        .contact-info i {
            font-size: 1.2rem;
            color: #dc3545;
            width: 40px;
        }
        
        .contact-info .label {
            font-weight: 600;
            color: #495057;
            width: 100px;
        }
        
        .contact-info .value {
            color: #212529;
            font-size: 1.05rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        
        .form-label i {
            color: #dc3545;
            margin-right: 5px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }
        
        .form-control:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .btn-buscar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-buscar:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-eliminar {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            border-radius: 10px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }
        
        .btn-eliminar:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
        }
        
        .btn-eliminar:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
            padding: 15px 20px;
            font-weight: 500;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
        }
        
        .icon-circle {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 2rem;
        }
        
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 30px 0;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 2px solid #e9ecef;
        }
        
        .divider span {
            padding: 0 15px;
            color: #6c757d;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .search-section,
            .contact-card {
                padding: 20px 15px;
            }
            
            .contact-info {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .contact-info .label {
                margin-top: 5px;
            }
        }
    </style>
</head>
<body>
    <a href="index.jsp" class="btn btn-light btn-back">
        <i class="fas fa-arrow-left"></i> Volver al inicio
    </a>

    <div class="container">
        <div class="form-container">
            <div class="icon-circle">
                <i class="fas fa-user-times"></i>
            </div>
            
            <h1 class="form-title">Eliminar Contacto</h1>
            <p class="form-subtitle">Busque y elimine un contacto de forma permanente</p>

            <!-- Mensajes -->
            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>¡Éxito!</strong> <%= request.getAttribute("mensaje") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <strong>Error:</strong> <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Sección de búsqueda -->
            <div class="search-section">
                <h5 class="search-title">
                    <i class="fas fa-search"></i> Paso 1: Buscar Contacto
                </h5>
                <form method="post" action="eliminar" id="formBuscar">
                    <input type="hidden" name="action" value="buscar">
                    <div class="row align-items-end">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <label for="buscarId" class="form-label">
                                <i class="fas fa-hashtag"></i> ID del Contacto
                            </label>
                            <input type="number" 
                                   class="form-control" 
                                   id="buscarId" 
                                   name="id" 
                                   placeholder="Ingrese el ID"
                                   value="<%= contacto != null ? contacto.getId() : "" %>"
                                   min="1"
                                   required>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-buscar w-100" type="submit">
                                <i class="fas fa-search me-2"></i>Buscar
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <% if (contactoEncontrado) { %>
                <div class="divider">
                    <span><i class="fas fa-arrow-down"></i></span>
                </div>

                <!-- Advertencia -->
                <div class="warning-box">
                    <h5>
                        <i class="fas fa-exclamation-triangle me-2"></i>¡Advertencia!
                    </h5>
                    <p>
                        Está a punto de eliminar este contacto de forma permanente. 
                        Esta acción <strong>NO se puede deshacer</strong>. 
                        Por favor, verifique la información antes de continuar.
                    </p>
                </div>

                <!-- Información del contacto -->
                <h5 class="search-title mb-3">
                    <i class="fas fa-info-circle"></i> Paso 2: Verificar Datos
                </h5>
                
                <div class="contact-card mb-4">
                    <div class="contact-info">
                        <i class="fas fa-hashtag"></i>
                        <span class="label">ID:</span>
                        <span class="value"><strong><%= contacto.getId() %></strong></span>
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-user"></i>
                        <span class="label">Nombre:</span>
                        <span class="value"><%= contacto.getNombre() %></span>
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-user"></i>
                        <span class="label">Apellido:</span>
                        <span class="value"><%= contacto.getApellido() %></span>
                    </div>
                    <div class="contact-info">
                        <i class="fas fa-phone"></i>
                        <span class="label">Teléfono:</span>
                        <span class="value"><%= contacto.getTelefono() %></span>
                    </div>
                </div>

                <!-- Formulario de eliminación -->
                <form method="post" action="eliminar" id="formEliminar" onsubmit="return confirmarEliminacion()">
                    <input type="hidden" name="action" value="eliminar">
                    <input type="hidden" name="id" value="<%= contacto.getId() %>">
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-eliminar">
                            <i class="fas fa-trash-alt me-2"></i>Eliminar Contacto Permanentemente
                        </button>
                    </div>
                </form>
            <% } else { %>
                <div class="text-center mt-4">
                    <div class="text-muted mb-3">
                        <i class="fas fa-search" style="font-size: 3rem; opacity: 0.3;"></i>
                    </div>
                    <p class="text-muted">
                        <i class="fas fa-info-circle"></i> 
                        Ingrese un ID y haga clic en "Buscar" para encontrar el contacto que desea eliminar
                    </p>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmarEliminacion() {
            const confirmacion = confirm(
                '⚠️ CONFIRMACIÓN DE ELIMINACIÓN\n\n' +
                '¿Está absolutamente seguro de que desea eliminar este contacto?\n\n' +
                '⚠️ Esta acción es PERMANENTE y NO se puede deshacer.\n\n' +
                'Presione "Aceptar" para eliminar o "Cancelar" para regresar.'
            );
            
            if (confirmacion) {
                return confirm(
                    '⚠️ ÚLTIMA CONFIRMACIÓN\n\n' +
                    '¿Realmente desea continuar con la eliminación?\n\n' +
                    'Presione "Aceptar" para confirmar.'
                );
            }
            
            return false;
        }
        
        // Auto-cerrar alertas de éxito
        setTimeout(function() {
            const successAlerts = document.querySelectorAll('.alert-success');
            successAlerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Validación de formularios
        (function() {
            'use strict';
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(event) {
                    if (form.id !== 'formEliminar' && !form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>