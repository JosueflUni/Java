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
    <title>Modificar Contacto - Sistema de Gestión</title>
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
            color: #667eea;
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
        
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        
        .form-label i {
            color: #667eea;
            margin-right: 5px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .form-control:disabled {
            background-color: #f8f9fa;
            cursor: not-allowed;
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
        
        .btn-modificar {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            border-radius: 10px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }
        
        .btn-modificar:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
        }
        
        .btn-modificar:disabled {
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
        
        .alert-warning {
            background: linear-gradient(135deg, #fff3cd 0%, #ffe69c 100%);
            color: #856404;
        }
        
        .icon-circle {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
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
        
        .required {
            color: #dc3545;
            margin-left: 3px;
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .search-section {
                padding: 20px 15px;
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
                <i class="fas fa-user-edit"></i>
            </div>
            
            <h1 class="form-title">Modificar Contacto</h1>
            <p class="form-subtitle">Busque el contacto por ID y actualice su información</p>

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
                <form method="post" action="modificar" id="formBuscar">
                    <input type="hidden" name="action" value="buscar">
                    <div class="row align-items-end">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <label for="buscarId" class="form-label">
                                <i class="fas fa-hashtag"></i> ID del Contacto<span class="required">*</span>
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

            <div class="divider">
                <span><i class="fas fa-arrow-down"></i></span>
            </div>

            <!-- Formulario de modificación -->
            <div class="<%= !contactoEncontrado ? "opacity-50" : "" %>">
                <h5 class="search-title mb-3">
                    <i class="fas fa-edit"></i> Paso 2: Modificar Datos
                </h5>
                
                <form method="post" action="modificar" id="formModificar">
                    <input type="hidden" name="action" value="modificar">
                    <input type="hidden" name="id" value="<%= contacto != null ? contacto.getId() : "" %>">

                    <div class="mb-3">
                        <label for="nombre" class="form-label">
                            <i class="fas fa-user"></i> Nombre<span class="required">*</span>
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="nombre" 
                               name="nombre" 
                               placeholder="Nombre del contacto"
                               value="<%= contacto != null ? contacto.getNombre() : "" %>"
                               maxlength="100"
                               <%= !contactoEncontrado ? "disabled" : "" %>
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="apellido" class="form-label">
                            <i class="fas fa-user"></i> Apellido<span class="required">*</span>
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="apellido" 
                               name="apellido" 
                               placeholder="Apellido del contacto"
                               value="<%= contacto != null ? contacto.getApellido() : "" %>"
                               maxlength="100"
                               <%= !contactoEncontrado ? "disabled" : "" %>
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
                               placeholder="Teléfono del contacto"
                               value="<%= contacto != null ? contacto.getTelefono() : "" %>"
                               maxlength="20"
                               <%= !contactoEncontrado ? "disabled" : "" %>
                               required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" 
                                class="btn btn-modificar"
                                <%= !contactoEncontrado ? "disabled" : "" %>>
                            <i class="fas fa-save me-2"></i>Guardar Cambios
                        </button>
                    </div>
                </form>
            </div>

            <% if (!contactoEncontrado) { %>
                <div class="text-center mt-3">
                    <small class="text-muted">
                        <i class="fas fa-info-circle"></i> 
                        Busque un contacto para habilitar el formulario de modificación
                    </small>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
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
                    if (!form.checkValidity()) {
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