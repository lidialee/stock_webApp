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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/stock_manager.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <%
        String loginID2 = "", storeName = "";
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
    <script>

        // + 버튼
        function plus_One(shoesID) {
            var num = document.getElementById(shoesID).value;
            var result = parseInt(num) + 1;
            document.getElementById(shoesID).value = result;
        }

        // - 버튼
        function minus_One(shoesID) {
            var num = document.getElementById(shoesID).value;
            if (num >= 1) {
                var result = parseInt(num) - 1;
                document.getElementById(shoesID).value = result;
            } else {
                alert("0개 입니다");
            }
        }

      function goStockUpdate(shoesID){
          var stock = parseInt(document.getElementById(shoesID).value);
          location.href='./stockUpdateAction.jsp?shoesID='+shoesID+'&stock='+stock;
      }

      function goDeleteStock(shoesID){
         location.href='./deleteStockAction.jsp?shoesID='+shoesID;
      }
    </script>

</head>
<body>
<hgroup>
    <h1 class="main_title">ABC-MART</h1>
    <div class="user_info">
        <div class="user_text">
            <a type="text" id="<%=loginID2%>"><%=loginID2%>
            </a>
        </div>
        <div class="user_text">
            <a class="user_nick"><%=storeName%>
            </a>
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
        <div class="form-group row pull-right">
            <div>
                <input class="form-control" id="ShoesNameInput" onkeyup="searchFuntion();" type="text"
                       placeholder="제품명을 검색하세요" style="margin-left:13px">
            </div>
            <div>
                <button class="btn btn-primary" onclick="searchFuntion();" type="button" style="margin-left:4px">검색
                </button>
                <button class="btn btn-primary" type="button" style="margin-left:10px"> 입고 등록</button>
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
                <th>타입</th>
                <th>가격</th>
                <th>재고량</th>
            </tr>
            </thead>
            <tbody id="resultTable" style="font-size: 12px;">
            <%
                ArrayList<Shoe> list;
                ShoesDAO shoesDAO = new ShoesDAO();
                list = shoesDAO.getAllShoes(loginID2);
                if (list != null) {
                    for (int a = 0; a < list.size(); a++) {
                        Shoe s = list.get(a);
                        int shoes_id = s.getShoesId();
            %>
            <tr>
                <td style="width:430px"><%=s.getName()%>
                </td>
                <td style="width:220px"><%=s.getBrand()%>
                </td>
                <td style="width:100px"><%=s.getSex()%>
                </td>
                <td style="width:100px"><%=s.getColor()%>
                </td>
                <td style="width:130px"><%=s.getSize()%>
                </td>
                <td style="width:130px"><%=s.getType()%>
                </td>
                <td style="width:150px"><%=s.getPrice()%>
                </td>
                <td style="width:600px">
                    <button class="stock_btns" id="<%=shoes_id%>_plus" onclick="plus_One('<%=shoes_id%>');">+</button>
                    <input type="text" id="<%=shoes_id%>" style="width:35px" value="<%=s.getStock()%> ">
                    <button class="stock_btns" id="<%=shoes_id%>_minus" onclick="minus_One('<%=shoes_id%>');">-</button>
                    <button class="stock_btns" id="<%=shoes_id%>_finish" onclick="goStockUpdate('<%=shoes_id%>')">완료</button>
                    <button class="stock_btns" id="<%=s.getShoesId()%>_remove" onclick="goDeleteStock('<%=shoes_id%>')">삭제</button>
                </td>
            </tr>
            <%
                    }
                }

            %>
            </tbody>
        </table>
        </p>


    </div>

</div>
</body>
</html>
