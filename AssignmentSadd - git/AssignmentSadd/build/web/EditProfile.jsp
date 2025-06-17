<%-- 
    Document   : EditProfile
    Created on : 16 Jun 2025, 6:04:51 pm
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("Login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Profile</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <!-- same bg image as login -->
  <div class="bg-image"></div>

  <form action="profile" method="post" class="container">
    <img src="images/logo.png" alt="Logo" class="logo">

    <label for="name">Name</label>
    <input id="name" name="name"
           value="${sessionScope.user.name}" required/>

    <label for="phone">Phone</label>
    <input id="phone" name="phone"
           value="${sessionScope.user.phone}" required/>

    <label for="gender">Gender</label>
    <select id="gender" name="gender">
      <option ${sessionScope.user.gender=='Male'?'selected':''}>Male</option>
      <option ${sessionScope.user.gender=='Female'?'selected':''}>Female</option>
    </select>

    <label for="password">New Password</label>
    <input id="password" type="password" name="password"/>

    <button class="btn" type="submit">Save</button>
  </form>
</body>
</html>


