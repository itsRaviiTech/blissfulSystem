<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f7f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .confirmation-box {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
        }
        h1 {
            color: #28a745;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 20px;
            border-radius: 5px;
        }
        a:hover {
            background-color: #218838;
        }
        .view-appointments {
            background-color: #007bff;
        }
        .view-appointments:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="confirmation-box">
    <h1>Appointment Booked Successfully!</h1>
    <p>Thank you for your booking. You will receive a confirmation shortly.</p>
    <% Boolean offer = (Boolean) request.getAttribute("isEligibleForOffer"); %>
    <% if (offer != null && offer) { %>
    
        Congratulations! You’re eligible for a Special Offer!
    
    <% } %>
    <a href="viewCustomer" class="view-appointments">View All Appointments</a>
    <a href="index.html">Back to Home</a>
</div>

</body>
</html>
