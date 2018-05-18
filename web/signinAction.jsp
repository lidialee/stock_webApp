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
    String selectedStoreName  = request.getParameter("storeCharName").toString();
    System.out.println("선택 가게 확인 :"+selectedStoreName);

    if (store.getOwnerLoginId() == null || store.getOwnerPass() == null || store.getOwnerName() == null ||  store.getOwnerPhone() == null|| selectedStoreName==null) {
        printWriter.println("<script>");
        printWriter.println("alert('입력 안 된 사항이 있습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else {
        StoreDAO storeDAO = new StoreDAO();
        int result = storeDAO.join(store,selectedStoreName);

        if (result == -1) {
            printWriter.println("<script>");
            printWriter.println("alert('이미 존재하는 아이디입니다')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        } else if(result == -2){
            printWriter.println("<script>");
            printWriter.println("alert('이미 등록된 점포입니다. 다시 선택해주세요')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        }
        else {
            printWriter.println("<script>");
            printWriter.println("alert('등록에 성공했습니다. 메인화면으로 돌아갑니다')");
            printWriter.println("location.href = 'index.jsp'");
            printWriter.println("</script>");
        }

    }
%>
</body>
</html>
