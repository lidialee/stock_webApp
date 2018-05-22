<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
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
    Boolean resultGetOwnerId;
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

    String selectedStoreName = request.getParameter("storeCharName").toString();
    System.out.println("선택  가게 확인 :" + selectedStoreName);


    if (owner.getOwnerLoginId() == null || owner.getOwnerPass() == null || owner.getOwnerName() == null || owner.getOwnerPhone() == null || selectedStoreName == null) {
        printWriter.println("<script>");
        printWriter.println("alert('입력 안 된 사항이 있습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    } else {

        OwnerDAO OwnerDAO = new OwnerDAO();
        int result = OwnerDAO.join(owner, selectedStoreName);

        if (result == -3) {
            printWriter.println("<script>");
            printWriter.println("alert('이미 존재하는 아이디입니다')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        } else if (result == -2) {
            printWriter.println("<script>");
            printWriter.println("alert('이미 등록된 점포입니다. 다시 선택해주세요')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        } else if (result == -1) {
            printWriter.println("<script>");
            printWriter.println("alert('쿼리에러')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        } else {

            int result2 = OwnerDAO.setOwnerIdIntoStore(owner.getOwnerLoginId(), selectedStoreName);
            if (result2 == -1) {
                printWriter.println("<script>");
                printWriter.println("alert('ownerId를 가져오지 못했음')");
                printWriter.println("history.back()");
                printWriter.println("</script>");
            } else if (result2 == -2) {
                printWriter.println("<script>");
                printWriter.println("alert('쿼리오류')");
                printWriter.println("history.back()");
                printWriter.println("</script>");
            } else {
                printWriter.println("<script>");
                printWriter.println("alert('등록에 성공했습니다. 메인화면으로 돌아갑니다')");
                printWriter.println("location.href = 'index.jsp'");
                printWriter.println("</script>");

            }
        }
    }
%>
</body>
</html>
