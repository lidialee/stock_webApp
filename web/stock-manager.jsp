<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="shoes.Shoe" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:useBean id="shoes" class="shoes.Shoe" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<% request.setCharacterEncoding("UTF-8");%>
<html>

<head>
    <title>Title</title>
    <meta http-equiv ="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/stock_manager.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <%
        String loginID2 ="",storeName="";
        OwnerDAO OwnerDAO = new OwnerDAO();
        try {
            if (session.getAttribute("ownerLoginId") != null) {
                loginID2 = (String) session.getAttribute("ownerLoginId");
                storeName = OwnerDAO.getOwnerStoreName(loginID2);

            } else {
    %>
    <script>
        location.href = 'index.jsp';
        alert("로그인 해주세요");
    </script>
    <%
            }

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
    %>
    <script type="text/javascript">
        var request = new XMLHttpRequest();
        function searchFuntion() {
            request.open("Post", "./ShoesSearchServlet?ShoesNameInput=" + encodeURIComponent(document.getElementById("ShoesNameInput").value), true);
            request.send(null);
            request.onreadystatechange = searchProcess;

        }

        function searchProcess() {
            var table = document.getElementById("ajaxTable");
            table.innerHTML = "";
            if (request.readyState == 4 && request.status == 200) {
                var object = eval('(' + request.responseText + ')');
                var result = object.result;
                for (var i = 0; i < result.length; i++) {
                    var row = table.insertRow(0);
                    for (var j = 0; j < result[i].length; j++) {
                        var cell = row.insertCell(j);
                        cell.innerHTML = result[i][j].value;
                    }
                }
            }
        }

    </script>
</head>
<body>
<hgroup>
    <h1 class="main_title">ABC-MART</h1>
    <div class="user_info">
        <div class="user_text">
            <%--<a class="user_nick" id="onlyHere"><%=loginID2%></a> 님--%>
            <%--<input type="text" id="userName" value="<%=loginID2%>" readonly>--%>
                <div type="text" id="<%=loginID2%>"><%=loginID2%></div>
            <%--&lt;%&ndash;회원정보에서 점주의 이름 불러오기 &ndash;%&gt;--%>
        </div>
        <div class="user_text">
            <a class="user_nick"><%=storeName%></a>
            <%--회원정보에서 지점명 불러오기 --%>
        </div>
        <a href="logoutAction.jsp" class="logout_click">로그아웃</a>
        <!-- 로그인페이지로 넘어가면서, 로그인 정보 모두 초기화 -->
    </div>
</hgroup>

<div id="grid">
    <aside>
        <div id="menu" class="index">
            <nav class="sub_nav">
                <ul id="menu">
                    <li class=menu_list>
                        <div class="menu_label">
                            <a href="main.jsp" class="menu_list">
                                <span class="title">제품검색</span>
                            </a>
                        </div>
                    </li>
                    <li class=menu_list>
                        <div class="menu_label">
                            <a href="stock-manager.jsp" class="menu_list">
                                <span class="title" id="now_title">My 재고관리</span>
                            </a>
                        </div>
                    </li>
                    <li class=menu_list>
                        <div class="menu_label">
                            <a href="main.jsp" class="menu_list">
                                <span class="title">타지점 재고검색</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </nav>
        </div>
    </aside>
    <div id="content">
        <h1 class="subtitle">My 재고관리</h1>
        <div class ="form-group row pull-right">
            <div>
                <input class="form-control" id="ShoesNameInput" onkeyup="searchFuntion();" type="text" placeholder="제품명을 검색하세요" >
            </div>
            <div>
                <button class="btn btn-primary" onclick="searchFuntion();" type="button">검색</button>
            </div>
        </div>


        <p>
        <table class="my_stock_table">
            <thead>
            <tr>
                <th>제품명</th>
                <th>브랜드</th>
                <th>성별</th>
                <th>색상</th>
                <th>사이즈</th>
                <th>재고</th>
                <th>재고</th>
                <th>재고</th>
                <th>재고</th>
            </tr>
            </thead>
            <tbody id="ajaxTable"></tbody>
        </table>
        </p>
        <input type="submit" value="재고변경" class="search_btn">
        <%--</form>--%>

    </div>

</div>
</body>
</html>
