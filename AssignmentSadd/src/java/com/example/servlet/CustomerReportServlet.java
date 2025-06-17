package com.example.servlet;

import com.example.model.Appointment;
import com.example.dao.AppointmentDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet("/customerReport")
public class CustomerReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> allAppointments = AppointmentDao.getAllAppointments();

        Map<String, Integer> totalCount = new HashMap<>();
        Map<String, Integer> completedCount = new HashMap<>();
        Map<String, String> nameMap = new HashMap<>();

        for (Appointment a : allAppointments) {
            String phone = (a.getPhone() != null) ? a.getPhone().trim() : "";
            String name = (a.getName() != null) ? a.getName().trim() : "";

            totalCount.put(phone, totalCount.getOrDefault(phone, 0) + 1);

            String status = (a.getStatus() != null) ? a.getStatus().trim() : "";
            if ("Complete".equalsIgnoreCase(status)) {
                completedCount.put(phone, completedCount.getOrDefault(phone, 0) + 1);
            }

            nameMap.putIfAbsent(phone, name);
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<html><head><title>Customer Report</title>");
            out.println("<link rel='stylesheet' href='https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css'>");
            out.println("<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>");
            out.println("<script src='https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js'></script>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }");
            out.println("h2 { text-align: center; color: #2c3e50; }");
            out.println("table { width: 100%; border-collapse: collapse; margin-top: 30px; }");
            out.println("th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }");
            out.println("th { background-color: #3498db; color: white; }");
            out.println("tr:nth-child(even) { background-color: #f9f9f9; }");
            out.println("a.button { display: inline-block; margin: 20px 0; padding: 10px 20px; background-color: #3498db; color: white; text-decoration: none; border-radius: 5px; }");
            out.println("a.button:hover { background-color: #2980b9; }");
            out.println(".offer { color: green; font-weight: bold; }");
            out.println("</style>");
            out.println("<script>$(document).ready(function() { $('#reportTable').DataTable(); });</script>");
            out.println("</head><body>");

            out.println("<h2>Customer Booking Report</h2>");
            out.println("<a href='viewAppointments' class='button'>← Back to Appointments</a>");

            out.println("<table id='reportTable'>");
            out.println("<thead><tr><th>No.</th><th>Name</th><th>Phone</th><th>Total Bookings</th><th>Completed</th><th>Offer Status</th></tr></thead>");
            out.println("<tbody>");

            int no = 1;
            for (String phone : totalCount.keySet()) {
                String name = nameMap.getOrDefault(phone, "Unknown");
                int total = totalCount.getOrDefault(phone, 0);
                int complete = completedCount.getOrDefault(phone, 0);

                out.println("<tr>");
                out.println("<td>" + (no++) + "</td>");
                out.println("<td>" + escapeHtml(name) + "</td>");
                out.println("<td>" + escapeHtml(phone) + "</td>");
                out.println("<td>" + total + "</td>");
                out.println("<td>" + complete + "</td>");

                // Show "Get Offer" if completed bookings >= 20, else dash
                if (complete >= 20) {
                    out.println("<td class='offer'>Get Offer</td>");
                } else {
                    out.println("<td>-</td>");
                }

                out.println("</tr>");
            }

            if (totalCount.isEmpty()) {
                out.println("<tr><td colspan='6'>No customers found.</td></tr>");
            }

            out.println("</tbody></table>");
            out.println("</body></html>");
        }
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;");
    }
}
