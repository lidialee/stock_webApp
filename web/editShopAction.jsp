<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="store.StoreDAO" %>
<jsp:useBean id="store" class="store.Store" scope="page"/>
<jsp:setProperty name="store" property="name"/>
<jsp:setProperty name="store" property="addre1"/>
<jsp:setProperty name="store" property="addre2"/>
<jsp:setProperty name="store" property="addre3"/>
<jsp:setProperty name="store" property="phone"/>
<jsp:setProperty name="store" property="website"/>
<% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    PrintWriter printWriter = response.getWriter();
    // 세션을 통해서 아이디 얻기
    String loginId= (String)session.getAttribute("ownerLoginId");
    String name = store.getName();
    String addre1 = store.getAddre1();
    String addre2 = store.getAddre2();
    String addre3 = store.getAddre3();
    String phone = store.getPhone();
    String website = store.getWebsite();


    if (name == null || addre1 == null || addre2 == null || addre3 == null || phone == null || website == null) {
        printWriter.println("<script>");
        printWriter.println("alert('입력 안 된 사항이 있습니다')");
        printWriter.println("history.back()");
        printWriter.println("</script>");
    }else{
        StoreDAO storeDAO = new StoreDAO();
        int result = storeDAO.updateStoreInfo(store, loginId);

        if(result == -1){
            printWriter.println("<script>");
            printWriter.println("alert('에러 발생')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        }else{
            printWriter.println("<script>");
            printWriter.println("alert('상점 정보 수정에 성공했습니다')");
            printWriter.println("history.back()");
            printWriter.println("</script>");
        }

    }
%>

</body>
</html>
