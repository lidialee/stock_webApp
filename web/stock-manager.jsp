<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="shoes.Shoe" %>
<%@ page import="store.Store" %>
<jsp:useBean id="owner" class="owner.Owner" scope="page"/>
<jsp:useBean id="shoes" class="shoes.Shoe" scope="page"/>
<jsp:setProperty name="owner" property="ownerLoginId"/>
<% request.setCharacterEncoding("UTF-8");%>
<html>

<head>
    <title> ABC 마트 재고관리 페이지에 접속하신걸 환영합니다. </title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">
    <link rel="stylesheet" type="text/css" href="css/stock_manager.css">
    <%
        String loginId = "", storeName = "";
        Store storeInfo = null;     //   지점 정보모두 가져온다.

        OwnerDAO OwnerDAO = new OwnerDAO();
        StoreDAO storeDAO = new StoreDAO();
        ShoesDAO shoesDAO = new ShoesDAO();
        try {
            if (session.getAttribute("ownerLoginId") != null) {
                loginId = (String) session.getAttribute("ownerLoginId");
                storeInfo = storeDAO.getStoreInfo(loginId);
                storeName = storeInfo.getName();
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

        function goStockUpdate(shoesID) {
            var stock = parseInt(document.getElementById(shoesID).value);
            location.href = './stockUpdateAction.jsp?shoesID=' + shoesID + '&stock=' + stock;
        }

        function goDeleteStock(shoesID) {
            location.href = './deleteStockAction.jsp?shoesID=' + shoesID;
        }

        function register() {
            var shoes_id = parseInt(document.getElementById('registerNumber').value);
            var stock2 = parseInt(document.getElementById('registerStock').value);
            location.href = './stockAction.jsp?shoesID=' + shoes_id + '&stock=' + stock2;
        }


    </script>
</head>
<body>
<!--- 상단 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:red">
    <a class="navbar-brand" href="mainTest.jsp" style="color:yellow"> ABC 마트 재고관리 </a>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <!--이 파일이 이제 mainTest.jsp가 아니겠지-->
                <a class="nav-link" href="mainTest.jsp">신발 검색</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="stock-manager.jsp">재고 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="near-store.jsp">주변지점 재고검색</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="modal" href="#editShopModal">가게정보수정하기</a>
            </li>
        </ul>
    </div>
    <a class="nav-link" style="float:right;color:white;"><%=storeName + "-" + loginId + " 점주님"%>
    </a>
</nav>

<div class="container" style="padding-top:30px; padding-bottom:30px;">
    <div class="col-lg-12"></div>
    <div class="col-lg-12">
        <div class="jumbotron" style="padding-top:20px; padding-bottom:3px; background-color:transparent;">
            <div class="form-group">
                <a style="font-size :32px; font-weight:500; font-family:'Jeju Gothic';">재고 관리</a>
                <button class="btn btn-danger btn-rounded" type="button" data-toggle="modal"
                        data-target="#registerShoes" style="margin-left:10px; float:right; font-color:yellow;">입고 등록
                </button>
            </div>
        </div>
    </div>

    <div class="col-lg-13">
        <table class="my_stock_table">
            <thead>
            <tr style="font-size:12px">
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
            <tbody>
            <%
                ArrayList<Shoe> list;
                list = shoesDAO.getAllShoes(loginId);
                if (list != null) {
                    for (int a = 0; a < list.size(); a++) {
                        Shoe s = list.get(a);
                        int shoes_id = s.getShoesId();
            %>
            <tr>
                <td style="width:430px;font-size:12px;"><%=s.getName()%>
                </td>
                <td style="width:220px;font-size:12px;"><%=s.getBrand()%>
                </td>
                <td style="width:100px;font-size:12px;"><%=s.getSex()%>
                </td>
                <td style="width:100px;font-size:12px;"><%=s.getColor()%>
                </td>
                <td style="width:130px;font-size:12px;"><%=s.getSize()%>
                </td>
                <td style="width:130px;font-size:12px;"><%=s.getType()%>
                </td>
                <td style="width:150px;font-size:12px;"><%=s.getPrice()%>원
                </td>
                <td style="width:600px;font-size:12px;">
                    <button style="font-color:black;" id="<%=shoes_id%>_plus" onclick="plus_One('<%=shoes_id%>');">+
                    </button>
                    <input type="text" id="<%=shoes_id%>" style="width:35px" value="<%=s.getStock()%> ">
                    <button id="<%=shoes_id%>_minus" onclick="minus_One('<%=shoes_id%>');">-</button>
                    <button id="<%=shoes_id%>_finish" onclick="goStockUpdate('<%=shoes_id%>')">완료</button>
                    <button id="<%=s.getShoesId()%>_remove" onclick="goDeleteStock('<%=shoes_id%>')">삭제</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<%--입고 등록 모달 --%>
<div id="registerShoes" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 헤더 -->
            <div class="modal-header" style="background-color:#fffc7a;">
                <h5 class="modal-title" id="modal"> 요청 리스트 </h5>
            </div>

            <!-- 본문 -->
            <div class="modal-body">

                <div class="form-row">
                    <div class="form-group col-sm-6" style="text-align:center; font-style:bold;">
                        <th>신발아이디</th>
                    </div>
                    <div class="form-group col-sm-6"  style="text-align:center; font-style:bold;">
                        <th>재고량</th>
                    </div>
                </div>


                <div class="form-row">
                    <div class="form-group col-sm-6">
                        <input type="text" id="registerNumber" class="form-control" placeholder="신발번호"
                               name="shoesId" maxlength="20">

                    </div>
                    <div class="form-group col-sm-6">
                        <input type="text" id="registerStock" class="form-control" placeholder="재고량" name="stock"
                               maxlength="20">
                    </div>
                </div>
                <input type="button" class="btn btn-outline-danger waves-effect" style="float:right;" value="등록" onclick="register()">
            </div>
        </div>
    </div>
</div>


<!-- 가게 정보 수정 모달 부분 -->
<div class="modal fade" id="editShopModal" tabindex="-1" role="dialog" aria-labelledbt="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#fffc7a;">
                <h5 class="modal-title" id="modal"> 가게 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"> &times; </span>
                </button>
            </div>

            <div class="modal-body">
                <form action="./editShopAction.jsp" method="post">
                    <div class="form-row">
                        <div class="form-group col-sm-12">
                            <label>지점명</label>
                            <input type="text" name="name" class="form-control" maxlength="30"
                                   value="<%=storeInfo.getName()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-6">
                            <label>시/도</label>
                            <select name="addre1" class="form-control">
                                <option value="서울특별시">서울특별시</option>
                                <option value="부산광역시">부산광역시</option>
                                <option value="대구광역시">대구광역시</option>
                                <option value="인천광역시">인천광역시</option>
                                <option value="광주광역시">광주광역시</option>
                                <option value="대전광역시">대전광역시</option>
                                <option value="울산광역시">울산광역시</option>
                                <option value="세종특별자치시">세종특별자치시</option>
                                <option value="경기도">경기도</option>
                                <option value="강원도">강원도</option>
                                <option value="충청북도">충청북도</option>
                                <option value="충청남도">충청남도</option>
                                <option value="전라북도">전라북도</option>
                                <option value="전라남도">전라남도</option>
                                <option value="경상북도">경상북도</option>
                                <option value="경상남도">경상남도</option>
                                <option value="제주특별자치도">제주특별자치도</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-6">
                            <label>시/군/구</label>
                            <input type="text" name="addre2" class="form-control" maxlength="30"
                                   value="<%=storeInfo.getAddre2()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-12">
                            <label>읍/면/동, 추가주소 입력</label>
                            <input type="text" name="addre3" class="form-control" maxlength="1000"
                                   value="<%=storeInfo.getAddre3()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-12">
                            <label>가게 전화번호</label>
                            <input type="text" name="phone" class="form-control" maxlength="10000"
                                   value="<%=storeInfo.getPhone()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-12">
                            <label>가게 웹사이트</label>
                            <input type="text" name="website" class="form-control" maxlength="10000"
                                   value="<%=storeInfo.getWebsite()%>">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger btn-rounded">수정완료</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- 제이쿼리 import 부분 -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/jquery.min.js"></script>
</body>
</html>
