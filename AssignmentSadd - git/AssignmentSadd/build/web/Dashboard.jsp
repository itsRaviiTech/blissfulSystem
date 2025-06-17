<%-- 
    Document   : Dashboard
    Created on : 16 Jun 2025, 6:04:41â¯pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page session="true" import="java.util.List, com.example.dao.*, com.example.model.Appointment, com.example.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
  }
  List<Appointment> appts = AppointmentDao.findByUser(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-page">

  <!-- Sidebar & overlay -->
  <div id="sidebar">
    <a href="Dashboard.jsp"   class="nav-btn">Home</a>
    <a href="Appointment.jsp" class="nav-btn">Appointments</a>
    <a href="EditProfile.jsp" class="nav-btn">Edit Profile</a>
    <a href="LoginServlet?act=logout" class="nav-btn">Logout</a>
  </div>
  <div id="overlay"></div>

  <!-- Main content -->
  <div class="dashboard-container">
    <!-- Top nav -->
    <div class="header">
      <span id="menuBtn" class="nav-icon" title="Menu">☰</span>
      <div class="nav-icons">
        <span class="nav-icon" title="Notifications">🔔</span>
        <a href="EditProfile.jsp"><span class="nav-icon" title="Profile">👤</span></a>
      </div>
    </div>

    <!-- Greeting -->
    <div class="greeting">
      Hello, <c:out value="${user.name}"/>
    </div>

    <!-- Appointment slideshow -->
    <c:if test="${empty appts}">
      <p>No upcoming appointments.</p>
    </c:if>
    <c:if test="${!empty appts}">
      <div class="carousel-container">
        <div class="carousel">
          <% for(int i=0; i<appts.size(); i++){
               Appointment a = appts.get(i);
          %>
          <div class="appointment-card<%= (i==0 ? " active" : "") %>">
            <div class="card-header">Appointment #<%= a.getId() %></div>
            <div class="card-body">
              <div class="appt-number"><%= (i+1) %></div>
              <div class="appt-datetime">
                <div class="appt-time"><%= a.getApptTime() %></div>
                <div class="appt-date"><%= a.getApptDate() %></div>
              </div>
            </div>
            <div class="staff">With <%= a.getStaffName() %></div>
            <div class="services">
              <span class="svc"><%= a.getService() %></span>
              <% if (a.getAddons() != null && !a.getAddons().isEmpty()) { %>
                <span class="svc">Add-Ons: <%= a.getAddons() %></span>
              <% } %>
            </div>
          </div>
          <% } %>
        </div>
      </div>
    </c:if>

    <!-- Static service icons & footer -->
    <div class="service-list">
      <div class="service-icon">
        <img src="images/barber-icon.jpg" alt="Barbers"><span>Barbers</span>
      </div>
      <div class="service-icon">
        <img src="images/hairstyle-icon.jpg" alt="Hairstyles"><span>Hairstyles</span>
      </div>
      <div class="service-icon">
        <img src="images/shave-icon.jpg" alt="Shaves"><span>Shaves</span>
      </div>
      <div class="service-icon">
        <img src="images/treatment-icon.jpg" alt="Treatments"><span>Treatments</span>
      </div>
    </div>
    <div class="footer-logo">
      <img src="images/logo.png" alt="Logo">
    </div>
  </div>

  <script>
    // Sidebar toggle
    const menuBtn = document.getElementById('menuBtn'),
          sidebar = document.getElementById('sidebar'),
          overlay = document.getElementById('overlay');
    menuBtn.onclick = () => {
      sidebar.classList.toggle('open');
      overlay.classList.toggle('show');
    };
    overlay.onclick = () => {
      sidebar.classList.remove('open');
      overlay.classList.remove('show');
    };

    // Auto‐advance slideshow every 5s
    (function(){
      const cards = document.querySelectorAll('.appointment-card');
      let idx = 0;
      setInterval(()=>{
        cards[idx].classList.remove('active');
        idx = (idx + 1) % cards.length;
        cards[idx].classList.add('active');
      }, 5000);
    })();
  </script>
</body>
</html>
