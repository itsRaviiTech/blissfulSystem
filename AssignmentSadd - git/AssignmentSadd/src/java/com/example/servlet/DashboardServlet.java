/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet;

import com.example.dao.AppointmentDao;
import com.example.model.Appointment;
import com.example.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    HttpSession session = req.getSession(false);
    User user = session==null ? null : (User)session.getAttribute("user");
    if (user == null) {
      resp.sendRedirect("Login.jsp");
      return;
    }

    try {
      List<Appointment> appts =
        AppointmentDao.findByUser(user.getId());
      req.setAttribute("appts", appts);
      req.getRequestDispatcher("Dashboard.jsp")
         .forward(req, resp);
    } catch (SQLException e) {
      throw new ServletException(e);
    }
  }
}
