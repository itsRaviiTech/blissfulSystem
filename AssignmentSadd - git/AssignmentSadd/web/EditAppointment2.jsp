<%-- 
    Document   : EditAppointment2
    Created on : 18 Jun 2025, 3:08:39 am
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  if (request.getAttribute("appt") == null) {
    response.sendRedirect("appointment");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Appointment</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body class="appointment-page">
  <div class="dashboard-container">
    <h2>Edit Appointment</h2>

    <form action="appointment" method="post">
      <input type="hidden" name="act"  value="edit"/>
      <input type="hidden" name="id"   value="${appt.id}"/>

      <label for="service">Service</label>
      <input id="service" name="service"
             value="${appt.service}" required/>

      <label for="add_ons">Add-Ons</label>
      <input id="add_ons" name="add_ons"
             value="${appt.addons}"/>

      <label for="appt_date">Date</label>
      <input type="date" id="appt_date" name="appt_date"
             required value="${appt.apptDate}"/>

      <label for="appt_time">Time</label>
      <input type="time" id="appt_time" name="appt_time"
             step="1800" required value="${appt.apptTime}"/>

      <label for="staff_id">Barber</label>
      <select id="staff_id" name="staff_id" required>
        <c:forEach var="s" items="${staffList}">
          <option value="${s.staffId}"
            <c:if test="${s.name eq appt.staffName}">
              selected="selected"
            </c:if>>
            ${s.name}
          </option>
        </c:forEach>
      </select>

      <label for="total_price">Price (RM)</label>
      <input type="number" step="0.01" id="total_price"
             name="total_price"
             value="${appt.price}" required/>

      <button class="edit-btn" type="submit">Save Changes</button>
    </form>
  </div>
</body>
</html>
