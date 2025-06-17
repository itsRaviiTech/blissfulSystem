<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Eligible Customers</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        h2 { color: #333; }
        table { width: 50%; margin: auto; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #e0e0e0; }
    </style>
</head>
<body>
    <h2 align="center">Customers Eligible for Special Offers</h2>
    <table>
        <tr><th>Phone Number</th></tr>
        <%
            List<String> phones = (List<String>) request.getAttribute("eligiblePhones");
            if (phones != null && !phones.isEmpty()) {
                for (String phone : phones) {
        %>
            <tr><td><%= phone %></td></tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="1">No eligible customers found.</td></tr>
        <%
            }
        %>
    </table>
</body>
</html>