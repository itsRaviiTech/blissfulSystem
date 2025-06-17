> K.:
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Appointment" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-image: url('images/barber.png'); /* Fix path if needed */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            backdrop-filter: blur(3px);
        }

        .card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            margin-top: 30px;
        }

        .search-input {
            width: 100%;
            max-width: 300px;
        }

        .btn-custom {
            background-color: #1976d2;
            color: white;
            border-radius: 8px;
        }

        .btn-custom:hover {
            background-color: #0d47a1;
        }

        th {
            background-color: #1976d2;
            color: white;
        }

        tr:hover {
            background-color: #e3f2fd;
        }
    </style>

    <script>
        $(document).ready(function(){
            $('#searchInput').on('keyup', function() {
                var value = $(this).val().toLowerCase();
                $('#appointmentTable tr').filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="text-center mt-4">
        <h2>Customer Appointments</h2>
        <p class="text-muted">View all your bookings at a glance</p>
    </div>

    <div class="card p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <input type="text" class="form-control search-input" id="searchInput" placeholder="Search appointments...">
            <div class="d-flex gap-2">
                <a href="BookAppointment.jsp" class="btn btn-custom">+ New Appointment</a>
                <a href="index.html" class="btn btn-secondary">Back</a>
                <a href="tel:+601110864724" class="btn btn-outline-dark">Contact Us</a>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Date</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Service</th>
                        <th>Barber</th>
                        <th>Add-ons</th>
                        <th>Price (RM)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="appointmentTable">
                    <%
                        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
                        List<String> endTimes = (List<String>) request.getAttribute("endTimes");

                        if (appointments == null || appointments.isEmpty()) {
                    %>
                        <tr><td colspan="9">No appointments found.</td></tr>
                    <%
                        } else {
                            for (int i = 0; i < appointments.size(); i++) {
                                Appointment a = appointments.get(i);
                    %>

> K.:
<tr>
                            <td><%= i + 1 %></td>
                            <td><%= a.getDate() %></td>
                            <td><%= a.getTime() %></td>
                            <td><%= endTimes != null && endTimes.size() > i ? endTimes.get(i) : "N/A" %></td>
                            <td><%= a.getService() %></td>
                            <td><%= a.getStaffName() %></td>
                            <td><%= a.getAddons() %></td>
                            <td><%= a.getPrice() %></td>
                            <td><%= a.getStatus() == null ? "N/A" : a.getStatus() %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
