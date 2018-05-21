<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.ownerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    String loginId = null;
    try{
        if(session.getAttribute("ownerLoginId")!=null) {
            loginId = (String) session.getAttribute("ownerLoginId");
            System.out.println("아이디 확인 : "+ loginId);
        }
    }catch(Exception e){
        System.out.println(e.getLocalizedMessage());
    }

%>


</body>
</html>
