<%@page import="com.example.model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="com.example.dao.StaffDAOImpl"%>
<%@page import="com.example.dao.StaffDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book Appointment</title>
        <style>
            body {
                background-color: #f0f8ff; /* Light blue background */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
            }
            .form-container {
                width: 450px;
                background-color: #1e90ff; /* Dodger blue */
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
                background-color: #63a4ff; /* lighter blue */
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
                background: #0047ab; /* darker blue */
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
                const serviceSelect = document.getElementById('service');
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
            }

            window.onload = function () {
                calculatePrice();
            };
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
        <div class="form-container">
            <h2>Book Your Appointment</h2>
            <form action="BookAppointmentServlet" method="post" onsubmit="calculatePrice()">

                <label for="name">Your Name</label>
                <input type="text" name="name" id="name" placeholder="Enter your full name" required>

                <label for="phone">Phone Number</label>
                <input type="text" name="phone" id="phone" placeholder="7 to 15 digits" required>

                <label for="date">Select Date</label>
                <input type="date" name="date" id="date" min="<%= LocalDate.now()%>" required>

                <label for="time">Preferred Time</label>
                <input type="time" name="time" id="time" required>

                <label for="service">Choose Service</label>
                <select name="service" id="service" required onchange="calculatePrice()">
                    <option value="" data-price="0">-- Select a Service --</option>
                    <option value="Haircut" data-price="25">Haircut (RM 25)</option>
                    <option value="Shaving" data-price="15">Shaving (RM 15)</option>
                    <option value="Hair Coloring" data-price="80">Hair Coloring (RM 80)</option>
                    <option value="Beard Trim" data-price="20">Beard Trim (RM 20)</option>
                </select>

                <label for="barber">Choose Barber</label>
                <select name="barber" id="barber" required>
                    <option value="">-- Select a Barber --</option>
                    <%
                        StaffDAO staffDAO = new StaffDAOImpl();
                        List<Staff> barbers = staffDAO.getAvailableBarbers();

                        for (Staff barber : barbers) {
                    %>
                    <option value="<%= barber.getId()%>">
                        <%= barber.getName()%> (<%= barber.getExpertise()%>)
                    </option>
                    <%
                        }
                    %>
                </select>

                <label>Add-ons</label>
                <div class="addons-group">
                    <label><input type="checkbox" name="addons" value="Massage" data-price="40" onchange="calculatePrice()"> Massage (RM 40)</label>
                    <label><input type="checkbox" name="addons" value="Facial" data-price="50" onchange="calculatePrice()"> Facial (RM 50)</label>
                    <label><input type="checkbox" name="addons" value="Scalp Treatment" data-price="35" onchange="calculatePrice()"> Scalp Treatment (RM 35)</label>
                </div>

                <label>Total Price</label>
                <input type="text" id="priceDisplay" readonly>

                <!-- Hidden price field for form submission -->
                <input type="hidden" name="price" id="price">

                <button type="submit" class="submit-btn">Book Appointment</button>
            </form>

            <form action="index.html" method="get">
                <button type="submit" class="back-button">Back to Homepage</button>
            </form>
        </div>

    </body>
</html>
