<%-- 
    Document   : staff
    Created on : 18 May 2025, 10:09:11 pm
    Author     : ravib
--%>

<%@page import="com.example.model.Staff"%>
<%@ page import="com.example.dao.StaffDAO, com.example.dao.StaffDAOImpl, com.example.model.Staff" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Staff Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background: url('https://images.unsplash.com/photo-1608739821620-4090a087b3ef?auto=format&fit=crop&w=1650&q=80') no-repeat center center fixed;
                background-size: cover;
                backdrop-filter: blur(3px);
                font-family: 'Segoe UI', sans-serif;
            }
            

            .container {
                background-color: rgba(255, 255, 255, 0.96);
                padding: 30px;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
            }

            .btn-success, .btn-primary, .btn-warning, .btn-danger {
                border-radius: 8px;
            }

            .btn-success {
                background-color: #2e7d32;
                border: none;
            }

            .btn-success:hover {
                background-color: #1b5e20;
            }

            .btn-primary {
                background-color: #1976d2;
                border: none;
            }

            .btn-primary:hover {
                background-color: #0d47a1;
            }

            .table thead th {
                background-color: #1976d2;
                color: white;
            }

            .table tbody tr:hover {
                background-color: #e3f2fd;
            }

            .form-label {
                font-weight: 500;
            }

            input.form-control, select.form-select {
                border-radius: 8px;
            }

            .alert {
                border-radius: 10px;
            }

            #addStaffForm {
                background-color: #f9f9f9;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            footer {
                box-shadow: 0 -2px 6px rgba(0, 0, 0, 0.1);
            }
        </style>

    </head>
    <body class="d-flex flex-column min-vh-100">

        <!-- HEADER -->
        <header class="bg-primary text-black p-3 mb-4">
            <div class="container">
                <h1 class="h3">Staff Management</h1>
                <nav class="navbar navbar-expand-lg navbar-dark p-0">
                    <div class="container-fluid p-0">
                        <a class="navbar-brand text-black" href="#">Blissful Barber</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                    </div>
                </nav>
            </div>
        </header>

        <!-- MAIN CONTENT -->
        <main class="container flex-grow-1">
            <h2 class="mb-4">Staff List</h2>

            <%
                java.util.List<Staff> staffList = (java.util.List<Staff>) application.getAttribute("staffList");

                if (staffList == null) {
                    // Initialize with default DAO data on first load
                    com.example.dao.StaffDAO tempDAO = new StaffDAOImpl();
                    staffList = tempDAO.getAllStaff();
                    application.setAttribute("staffList", staffList);
                }
            %>


            <div class="table-responsive mb-5">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Expertise</th>
                            <th>Available</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Staff s : staffList) {
                        %>
                        <tr>
                            <td><%= s.getId()%></td>
                            <td><%= s.getName()%></td>
                            <td><%= s.getUsername()%></td>
                            <td><%= s.getExpertise()%></td>
                            <td><%= s.isAvailable() ? "Yes" : "No"%></td>
                            <td><%= s.getDescription()%></td>
                            <td>
                                <a href="StaffServlet?action=edit&id=<%= s.getId()%>" class="btn btn-sm btn-warning">Edit</a>
                                <a href="StaffServlet?action=delete&id=<%= s.getId()%>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this staff?');">Delete</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                com.example.model.Staff editingStaff = (com.example.model.Staff) request.getAttribute("editStaff");
                boolean isEditing = (editingStaff != null);
            %>
            <%-- FLASH MESSAGE --%>
            <%
                String flashMessage = (String) request.getAttribute("flashMessage");
                if (flashMessage == null) {
                    flashMessage = (String) session.getAttribute("flashMessage");
                    if (flashMessage != null) {
                        session.removeAttribute("flashMessage");
                    }
                }
            %>
            <% if (flashMessage != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= flashMessage%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }%>

            <button class="btn btn-success mb-4" type="button" onclick="toggleAddStaffForm()">+ Add Staff</button>

            <div id="addStaffForm" style="display: <%= isEditing ? "block" : "none"%>;">
                <h2><%= isEditing ? "Edit Staff" : "Add Staff"%></h2>
                <form method="post" action="StaffServlet" class="row g-3 needs-validation" novalidate>
                    <input type="hidden" name="action" value="<%= isEditing ? "edit" : "add"%>" />
                    <!-- Name -->
                    <div class="col-md-4">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required
                               value="<%= isEditing ? editingStaff.getName() : ""%>" placeholder="--Enter staff name--"/>
                        <div class="invalid-feedback">Please provide a name.</div>
                    </div>
                    <!-- username [remove?] -->
                    <div class="col-md-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required
                               value="<%= isEditing ? editingStaff.getUsername() : ""%>" placeholder="--Enter staff username--"/>
                        <div class="invalid-feedback">Please provide a username.</div>
                    </div>
                    <!-- Expertise -->
                    <div class="col-md-3">
                        <label for="expertise" class="form-label">Expertise</label>
                        <input type="text" class="form-control" id="expertise" name="expertise" required
                               value="<%= isEditing ? editingStaff.getExpertise() : ""%>" placeholder="--Enter Expertise--"/>
                    </div>
                    <!-- Availability -->
                    <div class="col-md-3">
                        <label for="availability" class="form-label">Availability</label>
                        <select class="form-select" id="availability" name="availability" required placeholder="--Select Availability--">
                            <option value="" disabled <%= !isEditing ? "selected" : ""%>>Choose...</option>
                            <option value="true" <%= isEditing && editingStaff.isAvailable() ? "selected" : ""%>>Available</option>
                            <option value="false" <%= isEditing && !editingStaff.isAvailable() ? "selected" : ""%>>Unavailable</option>
                        </select>
                        <div class="invalid-feedback">Please select availability.</div>
                    </div>
                    <!-- Text Description -->
                    <div class="col-md-9">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description"
                               value="<%= isEditing ? editingStaff.getDescription() : ""%>" placeholder="--Enter Description--"/>
                    </div>

                    <div class="col-12">
                        <button type="submit" class="btn btn-primary">
                            <%= isEditing ? "Update Staff" : "Add Staff"%>
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <!-- FOOTER -->
        <footer class="bg-dark text-white text-center py-3 mt-auto">
            <div class="container">
                <small>&copy; 2025 Your Company. All rights reserved.</small>
            </div>
        </footer>

        <!-- Bootstrap JS Bundle with Popper -->
        <!-- Bootstrap Bundle with Popper (for dismissible alerts and more) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-IhE4yd99L93yIP1pZsUuDYkFrwQHYJMQ2TNDxtY2Iq1XWimxyFUVrKHqFUV6P1a1" crossorigin="anonymous"></script>


        <!-- Optional: Bootstrap validation script -->
        <script>
                // Bootstrap validation example
                (() => {
                    'use strict';
                    const forms = document.querySelectorAll('.needs-validation');
                    Array.from(forms).forEach(form => {
                        form.addEventListener('submit', event => {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                })();

                function toggleAddStaffForm() {
                    const formDiv = document.getElementById('addStaffForm');
                    const isVisible = formDiv.style.display === 'block';
                    formDiv.style.display = isVisible ? 'none' : 'block';
                    if (!isVisible) {
                        // Scroll to form when shown
                        formDiv.scrollIntoView({behavior: 'smooth'});
                    }
                }
        </script>
    </body>
</html>
