package com.example.servlet;

import com.example.dao.AppointmentDao;
import com.example.model.Appointment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.Locale;

@WebServlet("/financialStats")
public class FinancialStatsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> list = AppointmentDao.getAllAppointments();
        double totalDaily = 0;
        double totalWeekly = 0;
        double totalMonthly = 0;
        double totalYearly = 0;

        LocalDate today = LocalDate.now();
        WeekFields weekFields = WeekFields.of(Locale.getDefault());
        int currentWeek = today.get(weekFields.weekOfWeekBasedYear());
        int currentMonth = today.getMonthValue();
        int currentYear = today.getYear();

        for (Appointment a : list) {
            try {
                LocalDate date = a.getDate();
                if (date == null) continue;

                if ("Complete".equalsIgnoreCase(a.getStatus())) {
                    double price = a.getPrice() != null ? a.getPrice().doubleValue() : 0;

                    if (date.isEqual(today)) {
                        totalDaily += price;
                    }
                    if (date.get(weekFields.weekOfWeekBasedYear()) == currentWeek &&
                        date.getYear() == currentYear) {
                        totalWeekly += price;
                    }
                    if (date.getMonthValue() == currentMonth &&
                        date.getYear() == currentYear) {
                        totalMonthly += price;
                    }
                    if (date.getYear() == currentYear) {
                        totalYearly += price;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Financial Statistics</title>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/chart.js'></script>");
            out.println("<style>");
            out.println("body { font-family: Arial; background-color: #f5f5f5; }");
            out.println("h2 { text-align: center; color: #2c3e50; }");
            out.println(".stat-container { display: flex; justify-content: space-around; flex-wrap: wrap; margin-top: 50px; }");
            out.println(".card { background-color: white; border-radius: 10px; padding: 30px; width: 300px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; margin: 10px; }");
            out.println(".card h3 { color: #3498db; margin-bottom: 10px; }");
            out.println(".card p { font-size: 22px; color: #333; }");
            out.println(".back-btn { display: block; width: 200px; margin: 40px auto; padding: 10px; background: #3498db; color: white; border: none; border-radius: 5px; font-size: 16px; text-align: center; text-decoration: none; }");
            out.println(".back-btn:hover { background: #2980b9; }");
            out.println("#chartContainer { width: 80%; margin: 40px auto; }");
            out.println("</style>");
            out.println("</head><body>");

            out.println("<h2>Financial Statistics - " + today + "</h2>");
            out.println("<div class='stat-container'>");

            out.println("<div class='card'><h3>Daily Revenue</h3><p>RM " + String.format("%.2f", totalDaily) + "</p><p>(" + today + ")</p></div>");
            out.println("<div class='card'><h3>Weekly Revenue</h3><p>RM " + String.format("%.2f", totalWeekly) + "</p><p>(Week " + currentWeek + ", " + currentYear + ")</p></div>");
            out.println("<div class='card'><h3>Monthly Revenue</h3><p>RM " + String.format("%.2f", totalMonthly) + "</p><p>(Month " + currentMonth + ", " + currentYear + ")</p></div>");
            out.println("<div class='card'><h3>Yearly Revenue</h3><p>RM " + String.format("%.2f", totalYearly) + "</p><p>(" + currentYear + ")</p></div>");

            out.println("</div>");

            // Chart section
            out.println("<div id='chartContainer'>");
            out.println("<canvas id='revenueChart'></canvas>");
            out.println("</div>");
            out.println("<script>");
            out.println("const ctx = document.getElementById('revenueChart').getContext('2d');");
            out.println("new Chart(ctx, {");
            out.println("  type: 'bar',");
            out.println("  data: {");
            out.println("    labels: ['Daily', 'Weekly', 'Monthly', 'Yearly'],");
            out.println("    datasets: [{");
            out.println("      label: 'Revenue (RM)',");
            out.println("      data: [" + totalDaily + ", " + totalWeekly + ", " + totalMonthly + ", " + totalYearly + "],");
            out.println("      backgroundColor: ['#3498db', '#2ecc71', '#f1c40f', '#e74c3c'],");
            out.println("      borderWidth: 1");
            out.println("    }]");
            out.println("  },");
            out.println("  options: {");
            out.println("    scales: {");
            out.println("      y: {");
            out.println("        beginAtZero: true");
            out.println("      }");
            out.println("    }");
            out.println("  }");
            out.println("});");
            out.println("</script>");

            out.println("<a class='back-btn' href='" + request.getContextPath() + "/viewAppointments'>Back to Appointments</a>");
            out.println("</body></html>");
        }
    }
}
