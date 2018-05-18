<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="store" class="store.Store" scope="page"/>
<jsp:setProperty name="store" property="ownerLoginId"/>
<jsp:setProperty name="store" property="ownerPass"/>
<jsp:setProperty name="store" property="ownerName"/>
<jsp:setProperty name="store" property="ownerPhone"/>
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

    if (store.getOwnerLoginId() == null || store.getOwnerPass() == null || store.getOwnerName() == null ||  store.getOwnerPhone() == null|| selectedStoreName ==null) {
        printWriter.println("<script>");
        printWriter.println("alert('입력 안 된 사항이 있습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else {
        StoreDAO storeDAO = new StoreDAO();
        storeDAO.test(selectedStoreName);

    }
%>
</body>
</html>
