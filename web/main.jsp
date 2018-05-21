<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.ownerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One" rel="stylesheet">
    <link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/search.css">
    <title> Shoes - search</title>
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
<hgroup>
    <h1 class="main_title">ABC-MART</h1>
    <div class="user_info">
        <div class="user_text">
            <a class="user_nick">이정민님</a> 님
             <%--회원정보에서 점주의 이름 불러오기 --%>
        </div>
        <div class="user_text">
            <a class="user_nick">명동중앙점</a> 님
            <%--회원정보에서 지점명 불러오기 --%>
        </div>
        <a href="login.html" class="logout_click">로그아웃</a>
        <!-- 로그인페이지로 넘어가면서, 로그인 정보 모두 초기화 -->
    </div>
</hgroup>

<div id="grid">

    <aside>
        <div id="menu" class="index">
            <nav class="sub_nav">
                <ul id="menu">
                    <li class="menu_list">
                        <div class="menu_label">
                            <a href="main.jsp" class="menu_list">
                                <span class="title" id="now_title">제품검색</span>
                            </a>
                        </div>
                    </li>
                    <li class="menu_list">
                        <div class="menu_label">
                            <a href="stock-manager.jsp" class="menu_list">
                                <span class="title">My 재고관리</span>
                            </a>
                        </div>
                    </li>
                    <li class="menu_list">
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
        <h1 class="sub_title"> 제품검색 </h1>
        <!--form 으로 브랜드, 성별, 색상, 사이즈, 카테고리 정보 서버로 보냄 -->
        <p id="search_list">
            <form action="http//:localhost/search.php" method="post">
        <p class="search_box">
            <label>
                <cation class="search_title">브랜드</cation>
                <select name="brand" class="select_box">
                    <!--브랜드 나열 -->
                    <%--<option><%함수로 호출%></option>--%>
                    <option> 함수로 호출하는 부분 </option>
                </select>
            </label>
        </p>
        <p class="search_box">
            <cation class="search_title">성별 </cation>
            <label><input type="checkbox" value="man" name="sex"/>남</checkbox></label>
            <label><input type="checkbox" value="woman" name="sex"/>여</checkbox></label>
        </p>
        <p class="search_box">
            <cation class="search_title">가격 </cation>
            <input type="text" class="price_input" name="price_min" value="0" size="10">
            <a> 원 ~ </a>
            <input type="text" class="price_input" name="price_max" value="10000000" size="10">
            <a> 원</a>
            <!-- 가격이 0~10000000인지 확인! -->
        </p>
        <p class="search_box">
            <cation class="search_title">색상</cation>
        <div>
            <label><input type="checkbox" name="color" value="red" />빨강 </checkbox></label>
            <label><input type="checkbox" name="color" value="orange" />주황 </checkbox></label>
            <label><input type="checkbox" name="color" value="yellow" />노랑 </checkbox></label>
            <label><input type="checkbox" name="color" value="green" />초록 </checkbox></label>
            <label><input type="checkbox" name="color" value="blue" />파랑 </checkbox></label>
            <label><input type="checkbox" name="color" value="navy" />남색 </checkbox></label>
            <label><input type="checkbox" name="color" value="violet" />보라 </checkbox></label>
            <label><input type="checkbox" name="color" value="white" />흰색 </checkbox></label>
            <label><input type="checkbox" name="color" value="black" />검정 </checkbox></label>
            <label><input type="checkbox" name="color" value="gray" />회색 </checkbox></label>
            <label><input type="checkbox" name="color" value="pattern" />패턴 </checkbox></label>
        </div>
        </p>
        <p class="search_box">
            <cation class="search_title">사이즈</cation>
        <div>
            <label><input type="checkbox" name="size" value="220" />220</checkbox></label>
            <label><input type="checkbox" name="size" value="225" />225</checkbox></label>
            <label><input type="checkbox" name="size" value="230" />230</checkbox></label>
            <label><input type="checkbox" name="size" value="235" />235</checkbox></label>
            <label><input type="checkbox" name="size" value="240" />240</checkbox></label>
            <label><input type="checkbox" name="size" value="245" />245</checkbox></label>
            <label><input type="checkbox" name="size" value="250" />250</checkbox></label>
            <label><input type="checkbox" name="size" value="255" />255</checkbox></label>
            <label><input type="checkbox" name="size" value="260" />260</checkbox></label>
            <label><input type="checkbox" name="size" value="265" />265</checkbox></label>
            <label><input type="checkbox" name="size" value="270" />270</checkbox></label>
            <label><input type="checkbox" name="size" value="275" />275</checkbox></label>
            <label><input type="checkbox" name="size" value="280" />280</checkbox></label>
            <label><input type="checkbox" name="size" value="285" />285</checkbox></label>
            <label><input type="checkbox" name="size" value="290" />290</checkbox></label>
        </div>
        </p>
        <p class="search_box">
            <cation class="search_title">카테고리</cation>
        <div>
            <label><input type="checkbox" name="type" value="converse" />컨버스화</checkbox></label>
            <label><input type="checkbox" name="type" value="slip-on" />슬립온</checkbox></label>
            <label><input type="checkbox" name="type" value="sneakers" />스니커즈</checkbox></label>
            <label><input type="checkbox" name="type" value="running" />런닝화</checkbox></label>
            <label><input type="checkbox" name="type" value="shoes" />구두</checkbox></label>
            <label><input type="checkbox" name="type" value="sandal" />샌들</checkbox></label>
        </div>
        </p>
        <input type="submit" value="검색" class="search_btn"> <!--검색버튼입니다!! -->
        </form>
        </p>
        <!--제품검색결과를 표로 보여줍니다. (여기선 가격 추가) -->
        <p>
            <label>
                <table class="product_info_table">
                    <thead>
                    <tr>
                        <th>제품명</th>  <th>브랜드</th>  <th>카테고리</th> <th>성별</th> <th>색상</th> <th>사이즈</th> <th>가격</th>  <th>재고</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>스피드러너 2018 뉴제너레이션 </td> <td>아디다스</td> <td>스니커즈</td> <td>여</td> <td>빨강</td> <td>250</td> <td>129000</td>  <td>20</td>
                    </tr>
                    </tbody>
                </table>
            </label>
        </p>
    </div>
</div>
</body>
</html>
