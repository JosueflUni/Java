<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Contacto - Sistema de Gestión</title>
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
            max-width: 600px;
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
        
        .btn-crear {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            border-radius: 10px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-crear:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        
        .btn-crear:active {
            transform: translateY(0);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 2rem;
        }
        
        .required {
            color: #dc3545;
            margin-left: 3px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .btn-back {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Botón de regreso -->
    <a href="index.jsp" class="btn btn-light btn-back">
        <i class="fas fa-arrow-left"></i> Volver al inicio
    </a>

    <div class="container">
        <div class="form-container">
            <!-- Icono principal -->
            <div class="icon-circle">
                <i class="fas fa-user-plus"></i>
            </div>
            
            <!-- Título -->
            <h1 class="form-title">Crear Nuevo Contacto</h1>
            <p class="form-subtitle">Complete el formulario para agregar un contacto a su agenda</p>

            <!-- Mensajes de alerta -->
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

            <!-- Formulario -->
            <form method="post" action="crear" id="formCrear" novalidate>
                <!-- Campo Nombre -->
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
                           required
                           autofocus>
                    <div class="invalid-feedback">
                        Por favor ingrese el nombre
                    </div>
                </div>

                <!-- Campo Apellido -->
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
                           required>
                    <div class="invalid-feedback">
                        Por favor ingrese el apellido
                    </div>
                </div>

                <!-- Campo Teléfono -->
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
                           required>
                    <div class="invalid-feedback">
                        Por favor ingrese el teléfono
                    </div>
                </div>

                <!-- Botón de envío -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-crear">
                        <i class="fas fa-save me-2"></i>Crear Contacto
                    </button>
                </div>
            </form>

            <!-- Nota informativa -->
            <div class="text-center mt-4">
                <small class="text-muted">
                    <i class="fas fa-info-circle"></i> 
                    Todos los campos marcados con <span class="required">*</span> son obligatorios
                </small>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validación del formulario con Bootstrap
        (function() {
            'use strict';
            
            const form = document.getElementById('formCrear');
            
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        })();
        
        // Limpiar formulario después de éxito
        <% if (request.getAttribute("mensaje") != null) { %>
            document.getElementById('formCrear').reset();
            document.getElementById('formCrear').classList.remove('was-validated');
        <% } %>
        
        // Auto-cerrar alertas después de 5 segundos
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Formatear teléfono mientras se escribe (opcional)
        document.getElementById('telefono').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 0) {
                if (value.length <= 3) {
                    e.target.value = value;
                } else if (value.length <= 10) {
                    e.target.value = value.slice(0, 3) + '-' + value.slice(3);
                } else {
                    e.target.value = value.slice(0, 3) + '-' + value.slice(3, 10);
                }
            }
        });
    </script>
</body>
</html>