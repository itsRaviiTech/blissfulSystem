<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String msg = request.getParameter("message");
    if (msg == null || msg.trim().isEmpty()) {
        msg = "An unexpected error occurred.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        /* ---------- page baseline ---------- */
        *, *::before, *::after { box-sizing: border-box; }
        body  { margin:0; font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                background:#f2f2f2; display:flex; justify-content:center; align-items:center;
                min-height:100vh; padding:20px; }

        /* ---------- card ---------- */
        .card { background:#ffffff; width:100%; max-width:480px; padding:32px 28px;
                border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.1);
                text-align:center; }

        h1     { font-size:1.75rem; color:#d9534f; margin:0 0 12px; }
        p      { color:#555; font-size:1rem; line-height:1.4; margin:0 0 26px; }

        /* ---------- buttons ---------- */
        .btn      { display:inline-block; padding:12px 28px; margin:6px 4px;
                    border:none; border-radius:8px; font-size:1rem; cursor:pointer;
                    transition:background .25s, transform .15s; text-decoration:none; }
        .btn:active { transform:translateY(1px); }

        .btn-primary  { background:#007BFF; color:#fff; }
        .btn-primary:hover  { background:#0063d1; }
        .btn-outline   { background:#ffffff; color:#007BFF; border:2px solid #007BFF; }
        .btn-outline:hover { background:#e8f1ff; }

        /* ---------- responsive ---------- */
        @media (max-width:480px){
            .card{ padding:26px 20px;}
            h1   { font-size:1.5rem; }
        }
    </style>
</head>
<body>

<div class="card">
    <h1>Oops!</h1>
    <p><%= msg %></p>

    <!-- Buttons -->
    <form action="BookAppointment.jsp" method="get" style="display:inline;">
        <button type="submit" class="btn btn-primary">Try Again</button>
    </form>

    <a href="tel:+601110864724" class="btn btn-outline">Contact&nbsp;Us</a>
</div>

</body>
</html>
