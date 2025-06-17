<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Item" %>   <%--  POJO with id, title, details  --%>

<%
    /* ------------------------------------------------------------
       You can fill List<Item> in a servlet and forward here.
       For a quick demo we mock it in-page:
    ------------------------------------------------------------ */
    List<Item> items = (List<Item>) request.getAttribute("items");
    if (items == null) {
        items = new ArrayList<>();
        items.add(new Item(1, "Example Record A", "Some details …"));
        items.add(new Item(2, "Example Record B", "More details …"));
        items.add(new Item(3, "Example Record C", "…"));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Items – View Only</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <h2 class="mb-4 text-center">Items (View Only)</h2>

    <table class="table table-striped align-middle shadow-sm">
        <thead class="table-primary">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Title</th>
                <th scope="col">Details</th>
                <th scope="col" class="text-center">Actions</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="it" items="${items}">
            <tr>
                <td>${it.id}</td>
                <td>${it.title}</td>
                <td>${it.details}</td>

                <!--  ONLY Comment & Report buttons  -->
                <td class="text-center">
                    <form action="comment" method="get" class="d-inline">
                        <input type="hidden" name="id" value="${it.id}">
                        <button class="btn btn-outline-success btn-sm"
                                title="Add a comment">
                            Comment
                        </button>
                    </form>

                    <form action="report" method="post" class="d-inline ms-2">
                        <input type="hidden" name="id" value="${it.id}">
                        <button class="btn btn-outline-danger btn-sm"
                                title="Report this item">
                            Report
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
