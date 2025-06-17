/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet;

import com.example.dao.StaffDAOImpl;
import com.example.model.Staff;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class StaffServlet extends HttpServlet {

    // Use actual database-connected DAO
    private static StaffDAOImpl staffDAO = new StaffDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action != null && request.getParameter("id") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            switch (action) {
                case "delete":
                    staffDAO.deleteStaff(id);
                    break;
                case "edit":
                    Staff staff = staffDAO.getStaffById(id);
                    request.setAttribute("editStaff", staff);
                    break;
            }
        }

        // Always refresh staff list
        request.getServletContext().setAttribute("staffList", staffDAO.getAllStaff());

        // Forward to JSP
        request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String expertise = request.getParameter("expertise");
            boolean availability = Boolean.parseBoolean(request.getParameter("availability"));
            String description = request.getParameter("description");

            Staff staff = new Staff(name, username, expertise, availability, description);
            HttpSession session = request.getSession();

            if ("edit".equalsIgnoreCase(action)) {
                staffDAO.updateStaff(staff);
                session.setAttribute("flashMessage", "Staff updated successfully!");
            } else {
                staffDAO.addStaff(staff);
                session.setAttribute("flashMessage", "Staff added successfully!");
            }

            request.getServletContext().setAttribute("staffList", staffDAO.getAllStaff());

        } catch (Exception e) {
            e.printStackTrace();
            // Optionally set an error attribute
        }

        // Redirect back to staff page
        response.sendRedirect("manageStaff.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Handles staff management operations";
    }
}
