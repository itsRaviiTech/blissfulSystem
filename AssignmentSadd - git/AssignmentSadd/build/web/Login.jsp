<%-- 
    Document   : Login
    Created on : 16 Jun 2025, 6:04:33 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="bg-image"></div>
    <div class="container">
        <!-- Logo added here -->
        <img src="images/logo.png" alt="Logo" class="logo">

        <form action="LoginServlet" method="post">
          <label for="username">Username</label><br/>
          <input id="username" name="username" required/><br/><br/>

          <label for="password">Password</label><br/>
          <input id="password" type="password" name="password" required/><br/><br/>

          <button class="btn" type="submit">Login</button>
        </form>
    </div>
</body>
</html>
