<%--
    Document   : Appointment
    Created on : 16 Jun 2025, 6:05:00â¯pm
    Author     : User
--%>

<%@page import="com.example.model.User"%>
<%@page import="com.example.model.Appointment"%>
<%@page import="com.example.dao.AppointmentDao"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ensure logged in -->
<c:if test="${empty sessionScope.user}">
  <c:redirect url="Login.jsp"/>
</c:if>

<!-- ensure servlet populated appts -->
<c:if test="${empty appts}">
  <c:redirect url="appointment"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Your Appointments</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body class="appointment-page">
  <div class="dashboard-container">

    <!-- TABS -->
    <div class="tabs">
      <div class="tab" onclick="location.href='dashboard'">Home</div>
      <div class="tab active">Appointments</div>
    </div>

    <!-- LIST -->
    <div class="appointments-list">
      <c:choose>
        <c:when test="${empty appts}">
          <p>No appointments yet.</p>
        </c:when>
        <c:otherwise>
          <c:forEach var="a" items="${appts}" varStatus="st">
            <div class="appointment-block">

              <div class="app-block-header">
                <div class="app-info">
                  <!-- ordinal number -->
                  <div class="appt-number">${st.index + 1}</div>
                  <div class="appt-datetime">
                    <div class="appt-time">${a.apptTime}</div>
                    <div class="appt-date">${a.apptDate}</div>
                  </div>
                </div>
                <div class="staff">${a.staffName}</div>
              </div>

              <div class="service-row">
                <span>${a.service}</span>
                <span class="service-fee">RM ${a.price}</span>
              </div>
              <c:if test="${not empty a.addons}">
                <div class="service-row">
                  <span>Add-Ons: ${a.addons}</span>
                  <span class="service-fee">—</span>
                </div>
              </c:if>

              <!-- now an anchor so we jump to servlet?act=edit -->
              <a class="edit-btn"
                 href="appointment?act=edit&id=${a.id}">
                Edit
              </a>

            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- ADD NEW -->
    <a class="edit-btn" href="appointment?act=new">
      + Add New Appointment
    </a>

  </div>
</body>
</html>
