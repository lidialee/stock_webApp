<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="store.Store" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="shoes" class="shoes.Shoe" scope="page"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String ownerId, shareOwnerId;
    int shoesID;

    ShoesDAO shoesDAO = new ShoesDAO();
    PrintWriter printWriter = response.getWriter();

    if (session.getAttribute("ownerLoginId") != null || request.getParameter("requestStoreOwnerId") != null) {
        ownerId = (String) session.getAttribute("ownerLoginId");
        shareOwnerId = request.getParameter("requestStoreOwnerId");
        session.setAttribute("requestStoreOwnerId", shareOwnerId);
        printWriter.println("<script>");
        printWriter.println("location.replace('near-store.jsp')");
        printWriter.println("</script>");


    }
%>

</body>
</html>
