/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet;

import com.example.dao.DatabaseConnection;
import com.example.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
      req.getRequestDispatcher("EditProfile.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        User u = (User)req.getSession().getAttribute("user");
        String name=req.getParameter("name"),
               phone=req.getParameter("phone"),
               gender=req.getParameter("gender"),
               pw=req.getParameter("password");
        String sql = "UPDATE users SET name=?,phone=?,gender=?"
                   + (pw.isEmpty() ? "" : ",password=?")
                   + " WHERE id=?";
        try(Connection c = DatabaseConnection.getConnection();
            PreparedStatement p=c.prepareStatement(sql)) {
          int idx=1;
          p.setString(idx++,name);
          p.setString(idx++,phone);
          p.setString(idx++,gender);
          if(!pw.isEmpty()) p.setString(idx++,pw);
          p.setInt(idx,u.getId());
          p.executeUpdate();
          u.setName(name); u.setPhone(phone); u.setGender(gender);
          req.getSession().setAttribute("user",u);
          resp.sendRedirect("Dashboard.jsp");
        } catch(Exception e){
          throw new ServletException(e);
        }
    }
}