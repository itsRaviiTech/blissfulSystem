/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet;

import com.example.dao.AppointmentDao;
import com.example.dao.StaffDAO;
import com.example.dao.StaffDAOImpl;
import com.example.model.Appointment;
import com.example.model.Staff;
import com.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.List;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        // 1. Ensure user is logged in
        HttpSession session = req.getSession(false);
        User user = (session != null) 
            ? (User) session.getAttribute("user") 
            : null;
        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String act = req.getParameter("act");
        try {
            if ("new".equals(act)) {
                // show NewAppt.jsp
                List<Staff> staffList = StaffDAOImpl.getAll();
                req.setAttribute("staffList", staffList);
                req.getRequestDispatcher("NewAppt.jsp")
                   .forward(req, resp);

            } else if ("edit".equals(act)) {
                // show EditAppointment.jsp
                int id = Integer.parseInt(req.getParameter("id"));
                Appointment a = AppointmentDao.getAppointmentById(id);

                // guard: only allow editing if phone matches
                if (a == null || !user.getPhone().equals(a.getPhone())) {
                    resp.sendRedirect("appointment");
                    return;
                }

                List<Staff> staffList = StaffDAOImpl.getAll();
                req.setAttribute("appt", a);
                req.setAttribute("staffList", staffList);
                req.getRequestDispatcher("EditAppointment2.jsp")
                   .forward(req, resp);

            } else {
                // list appointments by phone
                List<Appointment> appts =
                  AppointmentDao.findByUser(user.getId());
                req.setAttribute("appts", appts);
                req.getRequestDispatcher("Appointment.jsp")
                   .forward(req, resp);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        // 1. Ensure user is logged in
        HttpSession session = req.getSession(false);
        User user = (session != null) 
            ? (User) session.getAttribute("user") 
            : null;
        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String act = req.getParameter("act");
        try {
            if ("new".equals(act)) {
                // create new appointment
                Appointment a = new Appointment();
                a.setName(user.getName());            // if your model tracks name
                a.setPhone(user.getPhone());          // crucial: use phone
                a.setService(req.getParameter("service"));
                a.setAddons(req.getParameter("add_ons"));
                a.setApptDate(Date.valueOf(req.getParameter("appt_date")));
                a.setApptTime(Time.valueOf(req.getParameter("appt_time")));
                a.setStaffid(Integer.parseInt(
                   req.getParameter("staff_id")));
                a.setPrice(new BigDecimal(
                   req.getParameter("total_price")));

                AppointmentDao.create(a);
                resp.sendRedirect("Appointment.jsp");

            } else if ("edit".equals(act)) {
                // update existing appointment
                Appointment a = new Appointment();
                a.setId(Integer.parseInt(req.getParameter("id")));
                a.setName(user.getName());
                a.setPhone(user.getPhone());
                a.setService(req.getParameter("service"));
                a.setAddons(req.getParameter("add_ons"));
                a.setApptDate(Date.valueOf(req.getParameter("appt_date")));
                a.setApptTime(Time.valueOf(req.getParameter("appt_time")));
                a.setStaffid(Integer.parseInt(
                   req.getParameter("staff_id")));
                a.setPrice(new BigDecimal(
                   req.getParameter("total_price")));

                AppointmentDao.update(a);
                resp.sendRedirect("Appointment.jsp");

            } else {
                // fallback: show list
                resp.sendRedirect("Appointment.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
