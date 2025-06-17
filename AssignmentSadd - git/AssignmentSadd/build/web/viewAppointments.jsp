<%@ page import="java.util.List"%>
<%@ page import="com.example.model.Appointment"%>
<%@ page import="com.example.dao.AppointmentDao"%>
<%@ page import="java.time.LocalTime, java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap5.min.js"></script>
    <style>
        body {
            background-color: #f4f6f8;
        }
        .status-text {
            cursor: pointer;
            color: #007bff;
            font-weight: 600;
        }
        .btn-group-custom {
            margin-top: 30px;
            text-align: center;
        }
    </style>
    <script>
        function toggleStatusDropdown(id) {
            document.getElementById('statusText_' + id).style.display = 'none';
            var selectElem = document.getElementById('statusSelect_' + id);
            selectElem.style.display = 'inline-block';
            selectElem.focus();
        }
        $(document).ready(function () {
            $('#appointmentTable').DataTable();
        });
    </script>
</head>
<body>
    
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', sans-serif;
            background: url('assets/salon.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            color: var(--text-color);
        }
        </style>

<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">Appointment Management</h2>

    <table class="table table-bordered table-striped" id="appointmentTable">
        <thead class="table-primary text-center">
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Date</th>
            <th>Start</th>
            <th>End</th>
            <th>Service</th>
            <th>Barber</th>
            <th>Add-ons</th>
            <th>Price (RM)</th>
            <th>Status</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Appointment> list = AppointmentDao.getAllAppointments();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            int count = 1;
            if (list != null && !list.isEmpty()) {
                for (Appointment a : list) {
                    String start = a.getTime();
                    String end;
                    try {
                        LocalTime startTime = LocalTime.parse(start, formatter);
                        int addons = (a.getAddons() != null && !a.getAddons().isEmpty()) ?
                                a.getAddons().split(",").length : 0;
                        int totalMinutes = 30 + (addons * 30);
                        LocalTime endTime = startTime.plusMinutes(totalMinutes);
                        end = endTime.format(formatter);
                    } catch (Exception e) {
                        end = "Invalid";
                    }

                    String status = a.getStatus();
                    if (status == null || status.trim().isEmpty()) status = "Pending";
        %>
        <tr class="text-center">
            <td><%= count++ %></td>
            <td><%= a.getName() %></td>
            <td><%= a.getPhone() %></td>
            <td><%= a.getDate() %></td>
            <td><%= start %></td>
            <td><%= end %></td>
            <td><%= a.getService() %></td>
            <td><%= a.getStaffid()%></td>
            <td><%= a.getAddons() %></td>
            <td><%= a.getPrice() %></td>
            <td>
                <form method="post" action="viewAppointments">
                    <input type="hidden" name="id" value="<%= a.getId() %>">
                    <span id="statusText_<%= a.getId() %>" class="status-text"
                          onclick="toggleStatusDropdown(<%= a.getId() %>)"><%= status %></span>
                    <select name="status" id="statusSelect_<%= a.getId() %>" class="form-select form-select-sm d-inline-block"
                            style="display:none; width:auto;" onchange="this.form.submit()">
                        <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                        <option value="Complete" <%= "Complete".equals(status) ? "selected" : "" %>>Complete</option>
                        <option value="Cancelled" <%= "Cancelled".equals(status) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </form>
            </td>
            <td><a class="btn btn-sm btn-warning" href="editAppointment.jsp?id=<%= a.getId() %>">Edit</a></td>
            <td>
                <a class="btn btn-sm btn-danger"
                   href="DeleteAppointment?id=<%= a.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this appointment?');">
                    Delete
                </a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="13" class="text-center">No appointments found.</td></tr>
        <% } %>
        </tbody>
    </table>

    <div class="btn-group-custom">
        <a href="index.html" class="btn btn-secondary">Back</a>
        <a href="financialStats" class="btn btn-info">View Financial Statistics</a>
        <a href="customerReport" class="btn btn-success">Customer Report</a>
        <a href="BookAppointment.jsp" class="btn btn-primary">Add New Appointment</a>
        <a href="provideOffer" class="btn btn-warning">View Special Offer Customers</a>
    </div>
</div>

</body>
</html>
