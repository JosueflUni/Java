<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Contactos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .hero-section {
            padding: 80px 0;
            color: white;
            text-align: center;
        }
        .hero-title {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.9;
        }
        .card-custom {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        .card-custom:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        .btn-custom {
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .footer {
            background: rgba(0,0,0,0.3);
            color: white;
            padding: 30px 0;
            margin-top: 80px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="fas fa-address-book text-primary"></i> Gestión de Contactos
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="crear.jsp"><i class="fas fa-plus"></i> Crear</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="modificar.jsp"><i class="fas fa-edit"></i> Modificar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="eliminar.jsp"><i class="fas fa-trash"></i> Eliminar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="listar.jsp"><i class="fas fa-list"></i> Listar</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1 class="hero-title">📱 Sistema de Gestión de Contactos</h1>
            <p class="hero-subtitle">Administra tus contactos de forma fácil y eficiente</p>
        </div>
    </div>

    <!-- Cards Section -->
    <div class="container pb-5">
        <div class="row g-4">
            <!-- Crear Contacto -->
            <div class="col-md-6 col-lg-3">
                <div class="card card-custom text-center p-4">
                    <div class="card-body">
                        <div class="card-icon text-success">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <h5 class="card-title fw-bold">Crear Contacto</h5>
                        <p class="card-text text-muted">Agrega nuevos contactos a tu agenda</p>
                        <a href="crear.jsp" class="btn btn-success btn-custom">
                            <i class="fas fa-plus"></i> Crear
                        </a>
                    </div>
                </div>
            </div>

            <!-- Modificar Contacto -->
            <div class="col-md-6 col-lg-3">
                <div class="card card-custom text-center p-4">
                    <div class="card-body">
                        <div class="card-icon text-primary">
                            <i class="fas fa-user-edit"></i>
                        </div>
                        <h5 class="card-title fw-bold">Modificar Contacto</h5>
                        <p class="card-text text-muted">Actualiza la información de tus contactos</p>
                        <a href="modificar.jsp" class="btn btn-primary btn-custom">
                            <i class="fas fa-edit"></i> Modificar
                        </a>
                    </div>
                </div>
            </div>

            <!-- Eliminar Contacto -->
            <div class="col-md-6 col-lg-3">
                <div class="card card-custom text-center p-4">
                    <div class="card-body">
                        <div class="card-icon text-danger">
                            <i class="fas fa-user-times"></i>
                        </div>
                        <h5 class="card-title fw-bold">Eliminar Contacto</h5>
                        <p class="card-text text-muted">Elimina contactos de tu agenda</p>
                        <a href="eliminar.jsp" class="btn btn-danger btn-custom">
                            <i class="fas fa-trash"></i> Eliminar
                        </a>
                    </div>
                </div>
            </div>

            <!-- Listar Contactos -->
            <div class="col-md-6 col-lg-3">
                <div class="card card-custom text-center p-4">
                    <div class="card-body">
                        <div class="card-icon text-info">
                            <i class="fas fa-list-ul"></i>
                        </div>
                        <h5 class="card-title fw-bold">Listar Contactos</h5>
                        <p class="card-text text-muted">Visualiza todos tus contactos</p>
                        <a href="listar.jsp" class="btn btn-info btn-custom text-white">
                            <i class="fas fa-list"></i> Ver Lista
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <p class="mb-0">&copy; 2025 Sistema de Gestión de Contactos | Desarrollado con Java & JSP</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>