<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<jsp:setProperty name="owner" property="ownerPass"/>
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
    String userId = null;

    if (session.getAttribute("ownerLoginId") != null) {
        userId = (String) session.getAttribute("ownerLoginId");
    }
    if (userId != null) {
        printWriter.println("<script>");
        printWriter.println("alert('이미 로그인이 되어있습니다')");
        printWriter.println("location.href = 'main.jsp'");
        printWriter.println("</script>");
    }
    OwnerDAO OwnerDAO = new OwnerDAO();
    int result = OwnerDAO.login(owner.getOwnerLoginId(), owner.getOwnerPass());

    if (result == 1) {
        session.setAttribute("ownerLoginId", owner.getOwnerLoginId());
        printWriter.println("<script>");
        printWriter.println("location.href = 'main.jsp'");
        printWriter.println("</script>");

    } else if (result == 0) {
        printWriter.println("<script>");
        printWriter.println("alert('비밀번호가 틀립니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else if (result == -1) {
        printWriter.println("<script>");
        printWriter.println("alert('존재하지 않는 아이디입니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else if (result == -2) {
        printWriter.println("<script>");
        printWriter.println("alert('데이터베이스 오류가 발생했습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    }
%>
</body>
</html>
