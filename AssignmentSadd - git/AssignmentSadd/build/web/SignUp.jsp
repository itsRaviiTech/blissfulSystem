<%-- 
    Document   : SignUp
    Created on : 16 Jun 2025, 6:04:16 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
  <title>Sign Up</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <!-- full-bleed background -->
  <div class="bg-image"></div>
  
  <!-- form wrapped in your grey container -->
  <form action="signup" method="post" class="container">
    <img src="images/logo.png" alt="Logo" class="logo">
    
    <label for="name">Name</label>
    <input id="name" name="name" required/>

    <label for="username">Username</label>
    <input id="username" name="username" required/>

    <label for="phone">Phone (+60)</label>
    <input id="phone" name="phone" required/>

    <label for="gender">Gender</label>
    <select id="gender" name="gender">
      <option>Male</option>
      <option>Female</option>
    </select>

    <label for="password">Password</label>
    <input id="password" type="password" name="password" required/>

    <label for="repass">Re-enter Password</label>
    <input id="repass" type="password" name="repass" required/>

    <button class="btn" type="submit">Sign Up</button>
  </form>
</body>
</html>
