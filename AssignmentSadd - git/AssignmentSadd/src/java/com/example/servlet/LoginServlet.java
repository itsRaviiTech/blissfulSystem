/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet;

import com.example.dao.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.sql.*;
import com.example.model.*;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author User
 */

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        
        String user=req.getParameter("username"),
               pw=req.getParameter("password");
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        try(Connection c = DatabaseConnection.getConnection();
            PreparedStatement p=c.prepareStatement(sql)) {
                p.setString(1,user); p.setString(2,pw);
                ResultSet r = p.executeQuery();

                if(r.next()){
                  if(!"active".equals(r.getString("user_status"))){
                    resp.sendRedirect("Login.jsp?err=inactive"); return;
                }
                User u=new User();
                u.setId(r.getInt("id"));
                u.setName(r.getString("name"));
                u.setUsername(user);
                u.setPhone(r.getString("phone"));
                u.setGender(r.getString("gender"));
                u.setUserStatus(r.getString("user_status"));
                u.setRole(r.getString("role"));
                req.getSession().setAttribute("user",u);
                resp.sendRedirect("Dashboard.jsp");
            } else {
              resp.sendRedirect("Login.jsp?err=unauth");
            }
        } catch(Exception e){
          throw new ServletException(e);
        }
    }
}
