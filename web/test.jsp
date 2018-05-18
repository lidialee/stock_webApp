<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.ownerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<jsp:setProperty name="owner" property="ownerPass"/>
<jsp:setProperty name="owner" property="ownerName"/>
<jsp:setProperty name="owner" property="ownerPhone"/>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
</head>
<body>
<%
    PrintWriter printWriter = response.getWriter();
    request.setCharacterEncoding("UTF-8");
    String selectedStoreName  = request.getParameter("ownerName").toString();
    System.out.println("선택 가게 확인 :"+selectedStoreName);

    if (owner.getOwnerLoginId() == null || owner.getOwnerPass() == null || owner.getOwnerName() == null ||  owner.getOwnerPhone() == null|| selectedStoreName ==null) {
        printWriter.println("<script>");
        printWriter.println("alert('입력 안 된 사항이 있습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else {
        ownerDAO ownerDAO = new ownerDAO();
        ownerDAO.test(selectedStoreName);

    }
%>
</body>
</html>
