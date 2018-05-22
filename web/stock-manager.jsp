
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/stock_manager.css">
</head>
<body>
<hgroup>
    <h1 class="main_title">ABC-MART</h1>
    <div class="user_info">
        <div class="user_text">
            <a class="user_nick">이정민</a> 님
        </div>
        <div class="user_text">
            <a class="user_store">명동중앙점</a> 점
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
        <form action="http//:localhost/search.php" method="post">
            <p>

            <table class="my_stock_table" >
                <caption class="table_title"><a class="user_store"> 명동중앙점 </a> 점</caption>
                <thead>
                <tr>
                    <th>제품ID</th>  <th>제품번호</th>  <th>사이즈</th> <th>재고량</th> <th>재고변경</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>12121212</td> <td>신발</td> <td>신발</td> <td>신발</td> <td><button class="stock_btns">+</button><button class="stock_btns">-</button></td>
                </tr>
                </tbody>
            </table>
            </p>
            <input type="submit" value="재고변경" class="search_btn">
        </form>

    </div>

</div>
</body>
</html>
