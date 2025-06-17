package com.example.servlet;

import com.example.model.Appointment;
import com.example.dao.AppointmentDao;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/viewAppointments")
public class viewAppointment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> list = AppointmentDao.getAllAppointments();
        request.setAttribute("appointmentList", list);

        request.getRequestDispatcher("viewAppointments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String newStatus = request.getParameter("status");

        if (idStr != null && newStatus != null &&
            (newStatus.equals("Pending") || newStatus.equals("Complete") || newStatus.equals("Cancelled"))) {
            try {
                int id = Integer.parseInt(idStr);
                AppointmentDao.updateStatus(id, newStatus);
            } catch (NumberFormatException e) {
                // Invalid ID
            }
        }

        response.sendRedirect(request.getContextPath() + "/viewAppointments");
    }
}
