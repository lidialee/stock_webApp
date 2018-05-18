<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="owner.ownerDAO" %>
<%@ page import="owner.Owner" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title></title>

</head>
<body>

<div class="container">
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 100px">
            <form method="post" action="signinAction.jsp">
                <h3 style="text-align: center;">Register new owner infomation</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="ID" name="ownerLoginId" maxlength="45" >
                    <input type="text" class="form-control" placeholder="Password" name="ownerPass" maxlength="45" >
                    <h1>지점을 선택해주세요</h1>
                    <select name="storeCharName">
                        <%
                            ownerDAO ownerDAO = new ownerDAO();
                            ArrayList<String> ownerName = ownerDAO.getStoreName();
                            for(int i =0 ; i<ownerName.size();i++){
                        %>
                              <option value="<%=ownerName.get(i) %>"><%=ownerName.get(i)%></option>
                        <%
                            }
                        %>
                    </select>
                    <%--<input type="text" class="form-control" placeholder="StoreName" name="ownerName" maxlength="45" >--%>
                    <input type="text" class="form-control" placeholder="ownerName" name="ownerName" maxlength="20" >
                    <input type="text" class="form-control" placeholder="ownerPhone" name="ownerPhone" maxlength="20" >
                </div>
                <input type="submit" class="btn btn-primary form-control" value="Finish">
            </form>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
