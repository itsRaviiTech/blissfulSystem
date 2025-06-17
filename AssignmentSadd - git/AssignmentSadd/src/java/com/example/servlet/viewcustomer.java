package com.example.servlet;

//import com.example.model.Appointment;
//import com.example.dao.AppointmentDao;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.time.LocalTime;
//import java.time.format.DateTimeFormatter;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet("/viewCustomer")
//public class viewcustomer extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        List<Appointment> list = AppointmentDao.getAllAppointments();
//
//        // Add end time to each appointment
//        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
//
//        List<String> endTimes = new ArrayList<>();
//        for (Appointment a : list) {
//            try {
//                LocalTime start = LocalTime.parse(a.getTime(), timeFormatter);
//                int addonCount = (a.getAddons() != null && !a.getAddons().trim().isEmpty()) ? a.getAddons().split(",").length : 0;
//                LocalTime end = start.plusMinutes(30 + addonCount * 30);
//                endTimes.add(end.format(timeFormatter));
//            } catch (Exception e) {
//                endTimes.add("Invalid time");
//            }
//        }
//
//        request.setAttribute("appointments", list);
//        request.setAttribute("endTimes", endTimes);
//        request.getRequestDispatcher("viewCustomer.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}


import com.example.model.Appointment;
import com.example.dao.AppointmentDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewCustomer")
public class viewcustomer extends HttpServlet {  // Class name capitalized

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve all appointments
        List<Appointment> list = AppointmentDao.getAllAppointments();

        // Generate end times
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        List<String> endTimes = new ArrayList<>();

        for (Appointment a : list) {
            try {
                LocalTime start = LocalTime.parse(a.getTime(), timeFormatter);
                int addonCount = (a.getAddons() != null && !a.getAddons().trim().isEmpty())
                        ? a.getAddons().split(",").length : 0;
                LocalTime end = start.plusMinutes(30 + addonCount * 30);
                endTimes.add(end.format(timeFormatter));
            } catch (Exception e) {
                endTimes.add("Invalid time");
            }
        }

        // Pass data to JSP
        request.setAttribute("appointmentList", list);
        request.setAttribute("endTimes", endTimes);

        request.getRequestDispatcher("viewCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Optional) Handle status update, if allowed for customers
        doGet(request, response);
    }
}