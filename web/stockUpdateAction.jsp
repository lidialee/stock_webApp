<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="shoes" class="shoes.Shoe" scope="page"/>
<% request.setCharacterEncoding("UTF-8");%><html>
<head>
    <title>stock-manager</title>
</head>
<body>
<%
    String loginID;
    int stock;
    int shoesID;
    ShoesDAO shoesDAO = new ShoesDAO();
    PrintWriter printWriter = response.getWriter();

    if (session.getAttribute("ownerLoginId") != null || request.getParameter("stock") !=null || request.getParameter("shoesID") != null) {
        loginID = (String) session.getAttribute("ownerLoginId");
        stock = Integer.parseInt(request.getParameter("stock"));
        shoesID = Integer.parseInt(request.getParameter("shoesID"));

        int funcResult = shoesDAO.changeStock(stock,shoesID,loginID);
        if(funcResult == -1){
            printWriter.println("<script>");
            printWriter.println("alert('재고 갱신에 실패했습니다')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        }else{
            printWriter.println("<script>");
            printWriter.println("alert('재고 갱신에 성공했습니다')");
            printWriter.println("location.replace('stock-manager.jsp')");
            printWriter.println("</script>");
        }
    }else{
        printWriter.println("<script>");
        printWriter.println("alert('필요한 정보를 불러오는데 실패했습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    }
%>
</body>
</html>
