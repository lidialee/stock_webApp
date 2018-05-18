<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>

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

            <form method="post" action="loginAction.jsp">
                <h3 style="text-align: center;">Welcome to stuck manager</h3>

                <div class="form-group">
                    <input type="text" class="form-control" placeholder="ID" name="ownerLoginId" maxlength="45">
                </div>

                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" name="ownerPass"
                           maxlength="45">
                </div>
                <input type="submit" class="btn btn-primary form-control" value="Login">
            </form>

            <input type="button" class="btn badge-dark" value="Sign-in" style="margin: 10px"
                   onclick="location.href='/signin.jsp'">
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
