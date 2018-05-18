<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="store" class="store.Store" scope="page"/>
<jsp:setProperty name="store" property="ownerLoginId"/>
<jsp:setProperty name="store" property="ownerPass"/>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
</head>
<body>
<%

    StoreDAO storeDAO = new StoreDAO();
    int result = storeDAO.login(store.getOwnerLoginId(), store.getOwnerPass());
    PrintWriter printWriter = response.getWriter();

    if (result == 1) {
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
