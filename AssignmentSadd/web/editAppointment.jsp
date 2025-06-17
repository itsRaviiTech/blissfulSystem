<%@ page import="com.example.dao.AppointmentDao" %>
<%@ page import="com.example.model.Appointment" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Appointment appointment = AppointmentDao.getAppointmentById(id);
    if (appointment == null) {
%>
    <h2 style="text-align:center; margin-top:50px;">Appointment not found.</h2>
<%
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Appointment</title>
    <style>
        body {
            background-color: #f0f8ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 0;
        }
        .form-container {
            width: 450px;
            background-color: #1e90ff;
            margin: 40px auto;
            padding: 35px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(30, 144, 255, 0.3);
            color: white;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            letter-spacing: 2px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            font-size: 16px;
        }
        input[type="text"], input[type="date"], input[type="time"], select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
            color: #333;
        }
        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="time"]:focus,
        select:focus {
            outline: none;
            box-shadow: 0 0 6px 2px rgba(255, 255, 255, 0.7);
        }
        .addons-group {
            margin-bottom: 18px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .addons-group label {
            font-weight: 500;
            font-size: 15px;
            color: #e0e0e0;
            cursor: pointer;
        }
        .addons-group input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.2);
            cursor: pointer;
        }
        #priceDisplay {
            background-color: #63a4ff;
            border: none;
            font-weight: 700;
            font-size: 18px;
            text-align: center;
            padding: 10px;
            margin-bottom: 25px;
            border-radius: 8px;
            color: white;
            user-select: none;
        }
        .submit-btn {
            background: #0047ab;
            border: none;
            border-radius: 10px;
            color: white;
            font-weight: 700;
            font-size: 18px;
            padding: 12px 0;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .submit-btn:hover {
            background-color: #002e73;
        }
        .back-button {
            background-color: transparent;
            border: 2px solid white;
            color: white;
            font-weight: 600;
            width: 100%;
            padding: 10px 0;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .back-button:hover {
            background-color: white;
            color: #1e90ff;
            border-color: #1e90ff;
        }
    </style>

    <script>
        function calculatePrice() {
            const serviceSelect = document.querySelector('select[name="service"]');
            const selectedOption = serviceSelect.options[serviceSelect.selectedIndex];
            const basePrice = parseFloat(selectedOption.getAttribute('data-price')) || 0;

            const addons = document.querySelectorAll('input[name="addons"]:checked');
            let addonsPrice = 0;
            addons.forEach(addon => {
                addonsPrice += parseFloat(addon.getAttribute('data-price')) || 0;
            });

            const total = basePrice + addonsPrice;

            document.getElementById('price').value = total.toFixed(2);
            document.getElementById('priceDisplay').value = 'RM ' + total.toFixed(2);
            return true;
        }

        window.onload = function() {
            calculatePrice();
        };
    </script>
</head>
<body>

<div class="form-container">
    <h2>Edit Appointment</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div style="background-color: #ff4d4d; color: white; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
            <%= error %>
        </div>
    <% } %>

    <form action="EditAppointment" method="post" onsubmit="return calculatePrice();">
        <input type="hidden" name="id" value="<%= appointment.getId() %>">

        <label for="name">Your Name</label>
        <input type="text" name="name" id="name" value="<%= appointment.getName() %>" required>

        <label for="phone">Phone Number</label>
        <input type="text" name="phone" id="phone" value="<%= appointment.getPhone() != null ? appointment.getPhone() : "" %>" required>

        <label for="date">Date</label>
        <input type="date" name="date" id="date" value="<%= appointment.getDate() %>" min="<%= LocalDate.now() %>" required>

        <label for="time">Time</label>
        <input type="time" name="time" id="time" value="<%= appointment.getTime() %>" required>

        <label for="service">Service</label>
        <select name="service" id="service" required onchange="calculatePrice()">
            <option value="" data-price="0" <%= appointment.getService() == null || appointment.getService().isEmpty() ? "selected" : "" %>>-- Select a Service --</option>
            <option value="Haircut" data-price="25" <%= "Haircut".equals(appointment.getService()) ? "selected" : "" %>>Haircut (RM 25)</option>
            <option value="Shaving" data-price="15" <%= "Shaving".equals(appointment.getService()) ? "selected" : "" %>>Shaving (RM 15)</option>
            <option value="Hair Coloring" data-price="80" <%= "Hair Coloring".equals(appointment.getService()) ? "selected" : "" %>>Hair Coloring (RM 80)</option>
            <option value="Beard Trim" data-price="20" <%= "Beard Trim".equals(appointment.getService()) ? "selected" : "" %>>Beard Trim (RM 20)</option>
        </select>

        <label for="barber">Choose Barber</label>
        <select name="barber" id="barber" required>
            <option value="">-- Select a Barber --</option>
            <option value="John" <%= "John".equals(appointment.getBarber()) ? "selected" : "" %>>John</option>
            <option value="Mike" <%= "Mike".equals(appointment.getBarber()) ? "selected" : "" %>>Mike</option>
            <option value="Alex" <%= "Alex".equals(appointment.getBarber()) ? "selected" : "" %>>Alex</option>
        </select>

        <label>Add-ons</label>
        <div class="addons-group">
            <label><input type="checkbox" name="addons" value="Massage" data-price="40" <%= appointment.getAddons().contains("Massage") ? "checked" : "" %> onchange="calculatePrice()"> Massage (RM 40)</label>
            <label><input type="checkbox" name="addons" value="Facial" data-price="50" <%= appointment.getAddons().contains("Facial") ? "checked" : "" %> onchange="calculatePrice()"> Facial (RM 50)</label>
            <label><input type="checkbox" name="addons" value="Scalp Treatment" data-price="35" <%= appointment.getAddons().contains("Scalp Treatment") ? "checked" : "" %> onchange="calculatePrice()"> Scalp Treatment (RM 35)</label>
        </div>

        <label>Total Price</label>
        <input type="text" id="priceDisplay" readonly>

        <input type="hidden" name="price" id="price" value="<%= appointment.getPrice() %>">

        <button type="submit" class="submit-btn">Update Appointment</button>
    </form>

    <form action="viewAppointments" method="get">
        <button type="submit" class="back-button">Back to Appointments</button>
    </form>
</div>

</body>
</html>
