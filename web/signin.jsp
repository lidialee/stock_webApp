<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="owner.Owner" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <link rel="stylesheet" type="text/css" href="css/nanumgothic.css"></link>
    <link rel="stylesheet" type="text/css" href="css/sign_up.css"></link>
    <link rel="stylesheet" href="css/bootstrap.css">
    <title> 점주 등록 과정 </title>

    <script>

        function goHome() {
            location.href = "login.html";
        }

        function checkdata() {
            var sign_id = document.getElementById("id");
            var sign_pw = document.getElementById("pw");
            var sign_phone = document.getElementById("phone");
            <!--sign_name 변수를 만들어 겹치는지 확인-->

            if (sign_id.value == "") {
                alert("아이디를 입력하세요");
                sign_id.focus();
                return;
            }
            ;

            if (sign_pw.value == "") {
                alert("비밀번호를 입력하세요");
                sign_pw.focus();
                return;
                ㅔ
            }
            ;

            if (sign_pw.value.length < 4) {
                alert("패스워드를 4자 이상 입력하세요");
                sign_pw.focus();
                return;
            }
            ;

            if (sign_phone.value == "") {
                alert("전화번호를 입력하세요");
                sign_phone.focus();
                return;
            }
            ;
        };
    </script>

</head>
<body>

<div class="container" style="padding-top:30px; padding-bottom:10px;">
    <div class="col-lg-12"></div>

    <div class="jumbotron" style="padding-top:20px; padding-bottom:3px; background-color:transparent;">
        <form name="sign_up" action="signinAction.jsp" method="post">
            <div class="row" style="padding-bottom:30px">


                <div class="col-sm-4 col-md-4 col-lg-4 col-xs-4" style="border-radius:8%; float:center;">
                    <h2 class="sub_title" style="text-align:left; margin-bottom:30px">회원 가입</h2>
                    <div class="form-row" style="margin-bottom:10px">
                        <a style="font-family:Jeju Gothic; font-size:18px;">아이디</a>
                        <input type="text" class="inputbox" id="id" name="ownerLoginId" placeholder="아이디를 입력하세요">
                    </div>

                    <div class="form-row" style="margin-bottom:10px">
                        <a style="font-family:Jeju Gothic; font-size:18px;">비밀번호</a>
                        <input type="password" class="inputbox" id="pw" name="ownerPass" placeholder="비밀번호를 입력하세요">
                    </div>

                    <div class="form-row" style="margin-bottom:10px">
                        <a style="font-family:Jeju Gothic; font-size:18px;">점주 전화번호 </a>
                        <input type="text" class="inputbox" id="phone" name="ownerPhone" placeholder="전화번호를 입력하세요">
                    </div>

                    <div class="form-row" style="margin-bottom:10px">
                        <a style="font-family:Jeju Gothic; font-size:18px;">점주 이름 </a>
                        <input type="text" class="inputbox" id="name" name="ownerName" placeholder="점주 이름을 입력하시오">
                    </div>

                    <div class="form-row" style="margin-bottom:10px">
                        <a style="font-family:Jeju Gothic; font-size:18px; margin-right:8px"> 지점명을 선택해주세요. </a>
                        <select name="storeCharName" id="selectbox">
                            <%
                                OwnerDAO OwnerDAO = new OwnerDAO();
                                ArrayList<String> ownerName = OwnerDAO.getStoreName();
                                for (int i = 0; i < ownerName.size(); i++) {
                            %>
                            <option value="<%=ownerName.get(i) %>"><%=ownerName.get(i)%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-row" style="margin-bottom:10px; float:center;" >
                        <input type="submit" name="submit" id="sign1" value="Finish" onclick="checkdata();">
                    </div>
                </div>

                <div class="col-sm-6 col-md-6 col-lg-6 col-xs-6" style="float:right;">
                    <img src="img/ABC.jpg" style="width:auto;height:auto;">
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
