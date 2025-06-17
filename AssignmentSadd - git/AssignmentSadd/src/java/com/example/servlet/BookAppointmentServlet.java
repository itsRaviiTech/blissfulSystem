package com.example.servlet;

import com.example.model.Appointment;
import com.example.dao.AppointmentDao;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

// Price list for services
    private BigDecimal getServicePrice(String service) {
        BigDecimal price;
        switch (service) {
            case "Haircut":
                price = BigDecimal.valueOf(25);
                break;
            case "Shaving":
                price = BigDecimal.valueOf(15);
                break;
            case "Hair Coloring":
                price = BigDecimal.valueOf(80);
                break;
            case "Beard Trim":
                price = BigDecimal.valueOf(20);
                break;
            default:
                price = BigDecimal.ZERO;
        }
        return price;
    }

    // Price list for add-ons
    private BigDecimal getAddonPrice(String addon) {
        BigDecimal price;
        switch (addon) {
            case "Massage":
                price = BigDecimal.valueOf(40);
                break;
            case "Facial":
                price = BigDecimal.valueOf(50);
                break;
            case "Scalp Treatment":
                price = BigDecimal.valueOf(35);
                break;
            default:
                price = BigDecimal.ZERO;
        }
        return price;
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        // 1. Read form parameters
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String dateStr = request.getParameter("date");
        String timeStr = request.getParameter("time");
        String service = request.getParameter("service");
        String staffid = request.getParameter("barber");
        String[] addons = request.getParameterValues("addons");

        // 2. Validate mandatory fields
        if (name == null || phone == null || dateStr == null || timeStr == null
                || service == null
                || name.isEmpty() || phone.isEmpty() || dateStr.isEmpty() || timeStr.isEmpty()
                || service.isEmpty()) {

            redirectError(response, "All fields are required.");
            return;
        }

        // 2a. Validate name
        if (!name.matches("^[A-Za-z' ]{2,30}$")) {
            redirectError(response, "Name must contain only letters and spaces (2–30 characters).");
            return;
        }

        // 2b. Validate phone number
        if (!phone.matches("\\d{7,15}")) {
            redirectError(response, "Phone number must contain 7–15 digits (no +, spaces, or letters).");
            return;
        }

        // 3. Validate and parse date/time and check for conflict
        LocalDate date;
        LocalTime time;
        int addonDurationMinutes = (addons != null) ? addons.length * 30 : 0;

        try {
            date = LocalDate.parse(dateStr);
            time = LocalTime.parse(timeStr);

            LocalDate today = LocalDate.now();
            if (date.isBefore(today)) {
                redirectError(response, "Date must be today or in the future.");
                return;
            }

            if (date.equals(today)) {
                LocalTime now = LocalTime.now();
                if (!time.isAfter(now)) {
                    redirectError(response, "Time must be in the future.");
                    return;
                }
            }

            // Calculate end time based on base 30 mins + add-ons
            LocalTime endTime = time.plusMinutes(30 + addonDurationMinutes);

            // Use new conflict checking logic
            if (AppointmentDao.hasConflictWithDuration(date, time, endTime, Integer.parseInt(staffid))) {
                redirectError(response, "Barber has another appointment during this time.");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectError(response, "Invalid date or time format.");
            return;
        }

        // 4. Calculate price
        BigDecimal totalPrice = getServicePrice(service);
        if (addons != null) {
            for (String addon : addons) {
                totalPrice = totalPrice.add(getAddonPrice(addon));
            }
        }

        // 5. Build and save appointment
        String addonList = (addons != null) ? String.join(", ", addons) : "";

        Appointment appt = new Appointment();
        appt.setName(name);
        appt.setPhone(phone);
        appt.setDate(LocalDate.parse(dateStr));
        appt.setTime(timeStr);
        appt.setService(service);
        appt.setStaffid(Integer.parseInt(staffid));
        appt.setAddons(addonList);
        appt.setPrice(totalPrice);
        appt.setStatus("Pending");

        System.out.println("Saving appointment:");
        System.out.println("Name: " + appt.getName());
        System.out.println("Phone: " + appt.getPhone());
        System.out.println("Date: " + appt.getDate());
        System.out.println("Service: " + appt.getService());
        System.out.println("Time: " + appt.getTime());
        System.out.println("Addons: " + appt.getAddons());
        System.out.println("Price: " + appt.getPrice());
        System.out.println("Status: " + appt.getStatus());
        System.out.println("Staff ID: " + appt.getStaffid());
        int status = AppointmentDao.save(appt);
        
        // Count how many times this phone has been used
        int phoneCount = AppointmentDao.countAppointmentsByPhone(phone);
        boolean isEligibleForOffer = phoneCount >= 5;

        // Store flag to pass to confirmation page
        request.setAttribute("isEligibleForOffer", isEligibleForOffer);

        // 6. Redirect accordingly
        if (status > 0) {
            request.setAttribute("isElligibleForOffer", isEligibleForOffer);
            request.getRequestDispatcher("success.jsp").forward(request, response);
        } else {
            redirectError(response, "Failed to save appointment.");
        }
        
        
    }

    // Redirect to error page
    private void redirectError(HttpServletResponse resp, String msg) throws IOException {
        resp.sendRedirect("error.jsp?message=" + URLEncoder.encode(msg, "UTF-8"));
    }
}
