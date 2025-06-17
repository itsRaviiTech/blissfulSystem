<!-- <%-- 
    Document   : NewAppt
    Created on : 16 Jun 2025, 6:05:20â¯pm
    Author     : User
--%> -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page session="true" import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // redirect if not logged in
  if (session.getAttribute("user") == null) {
    response.sendRedirect("Login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Book Appointment</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body class="appointment-page">

  <div class="dashboard-container">
    <h2>Book New Appointment</h2>

    <form action="AppointmentServlet" method="post">
      <label for="service">Service</label>
      <input type="text" id="service" name="service" required/>

      <label for="add_ons">Add‐Ons</label>
      <input type="text" id="add_ons" name="add_ons"/>

      <label for="appt_date">Date</label>
      <input
        type="date"
        id="appt_date"
        name="appt_date"
        required
        min="<%= LocalDate.now() %>"
      />

      <label for="appt_time">Time</label>
      <input
        type="time"
        id="appt_time"
        name="appt_time"
        step="1800"
        required
      />

      <label for="staff_id">Staff</label>
      <select id="staff_id" name="staff_id" required>
        <c:forEach var="s" items="${requestScope.staffList}">
          <option value="${s.staffId}">${s.name}</option>
        </c:forEach>
      </select>

      <label for="total_price">Total Price (RM)</label>
      <input
        type="number"
        id="total_price"
        name="total_price"
        step="0.01"
        required
      />

      <input
        type="hidden"
        name="phone_number"
        value="${sessionScope.user.phone}"
      />

      <button class="edit-btn" type="submit">Confirm Booking</button>
    </form>
  </div>

  <script>
    // enforce min date in all browsers
    (function(){
      const dateInput = document.getElementById('appt_date');
      const today = new Date().toISOString().split('T')[0];
      dateInput.min = today;
    })();
  </script>
</body>
</html>
