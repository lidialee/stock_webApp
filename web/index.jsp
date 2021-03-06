<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="store.Store" %>
<%@ page import="shoes.Shoe" %>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/login_style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">


    <%
        String loginId = null;      //   사용자아이디, 세션으로 받아진다
        OwnerDAO ownerDAO = new OwnerDAO();

        // 세션으로 사용자아이디, 그리고 지점명, 지점정보 얻어오기
        try {
            if (session.getAttribute("ownerLoginId") != null){
      %>
    <script>
        location.href = 'mainTest.jsp';
    </script>
    <%
            }
        } catch (Exception e) {
            System.out.println("index에서 로그인 세션 유지에러"+e.getLocalizedMessage());
        }
    %>
    <script>
        function checkdata(){
            var login_id = document.getElementById("id");
            var login_pw = document.getElementById("pw");

            if(login_id.value == ""){
                alert("아이디를 입력해주세요");
                login_id.focus();
                return;
            };

            if(login_pw.value == ""){
                alert("비밀번호를 입력해주세요");
                login_pw.focus();
                return;
            };
        }



    </script>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <title>Golden Beetle</title>
</head>
<body>
<div class="loginbox">
    <img src="img/ABC.jpg">
    <form method="post" action="loginAction.jsp">
        <div class="form-input">
          <span style="font-size:2em; color:black; margin-right: 5px">
          <i class="fas fa-user"></i>
        </span>
            <input type="text" id="id" name="ownerLoginId"
                   placeholder="ID">
        </div>
        <div class="form-input">
          <span style="font-size:2em; color:black; margin-right: 5px">
          <i class="fas fa-unlock-alt"></i>
        </span>
            <input type="password" id="pw" name="ownerPass"
                   placeholder="Password">
        </div>
        <input type="submit" name="submit" value="Login" class="login" onclick="checkdata();">
    </form>
    <p></p>
    <input type="button" class="btn badge-dark" value="Sign-in" style="margin: 10px"
           onclick="location.href='/signin.jsp'">
</div>
</body>
</html>
