<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="shoes.ShoesDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="store.Store" %>
<%@ page import="shoes.Shoe" %>
<%@ page import="store.StoreOwner" %>
<% request.setCharacterEncoding("UTF-8");%>
<html>
<head>
    <title> ABC 마트 재고관리 페이지에 접속하신걸 환영합니다. </title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">
    <link rel="stylesheet" type="text/css" href="css/search.css">

    <%

        String loginId = null;      //   사용자아이디, 세션으로 받아진다
        String storeName = null;    //   지점이름, 사용자아이디로 서버에서 얻어진다
        String shareStoreLoginId = null;
        Store storeInfo = null;     //   지점 정보모두 가져온다.

        OwnerDAO ownerDAO = new OwnerDAO();
        StoreDAO storeDAO = new StoreDAO();
        ShoesDAO shoesDAO = new ShoesDAO();

        // 세션으로 사용자아이디, 그리고 지점명, 지점정보 얻어오기
        try {
            if (session.getAttribute("requestStoreOwnerId") != null) {
                shareStoreLoginId = (String) session.getAttribute("requestStoreOwnerId");
            }
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
        function checkRelation(loginId) {
            location.href = './searchShareStoreInfoAction.jsp?requestStoreOwnerId=' + loginId;
        }

        function sendRequset(receiverId){
            location.href = './sendRequestShareActoin.jsp?receiverId=' + receiverId;
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
                <a style="font-size :32px; font-weight:500; font-family:'Jeju Gothic';">주변지점 재고확인</a>
                <p>
                <a style="font-size :15px;">같은 </a>
                <u style="font-size :16px; font-weight:300; font-family:'Jeju Gothic';"><%= storeInfo.getAddre1()%></u>
                <a style="font-size :15px;">지역에 입점한 ABC마트의 재고 상황입니다</a>
            </div>
        </div>
        <div class="row" style="padding-bottom:30px">

            <!-- 공유 지점 리스트 (왼쪽)  -->
            <div class="col-sm-2 col-md-2 col-lg-2 col-xs-2" style="border-radius:8%;">
                <h5 style="text-align:left;"> 재고 공유 리스트</h5>

                <!-- 공유지점 버튼리스트 -->
                <%
                    ArrayList<String> idList = storeDAO.getSharedOwnerId(loginId);
                    ArrayList<StoreOwner> shareStoreList = storeDAO.getSameAreaStoreInfo(storeInfo.getAddre1(),loginId);
                    for (int i = 0; i < shareStoreList.size(); i++) {
                        StoreOwner st = shareStoreList.get(i);
                        String shareStoreName = st.getName();
                        String shareStoreID = st.getId();
                %>
                <div class="form-row" style="padding:5px">
                    <button class="btn btn-danger btn-rounded" type="button" id="<%=shareStoreID%>"
                            onclick="checkRelation('<%=shareStoreID%>');"><%=shareStoreName%>
                    </button>
                </div>
                <%
                    }
                %>
            </div>


            <!-- 테이블부분 (오른쪽)-->
            <div class="col-sm-10 col-md-10 col-lg-10 col-xs-10">
                <table class="product_info_table">
                    <thead>
                    <tr style="font-size:12px">
                        <th>제품번호</th>
                        <th>제품명</th>
                        <th>브랜드</th>
                        <th>성별</th>
                        <th>색상</th>
                        <th>사이즈</th>
                        <th>재고</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 여기부터 하렴 -->
                    <%
                        ArrayList<Shoe> list;
                        if (shareStoreLoginId != null) {
                            list = shoesDAO.getAllShoes(shareStoreLoginId);
                            if (list.size()!=0) {
                                for (int a = 0; a < list.size(); a++) {
                                    Shoe s = list.get(a);

                    %>
                    <tr class="tbody_custom_class">
                        <td style="width:150px"><%=s.getShoesId()%>
                        </td>
                        <td style="width:430px"><%=s.getName()%>
                        </td>
                        <td style="width:230px"><%=s.getBrand()%>
                        </td>
                        <td style="width:90px"><%=s.getSex()%>
                        </td>
                        <td style="width:120px"><%=s.getColor()%>
                        </td>
                        <td style="width:120px"><%=s.getSize()%>
                        </td>
                        <td style="width:120px"><%=s.getStock()%>
                        </td>

                    </tr>
                    <%
                                }
                            }
                        }
                    %>
                    </tbody>
                </table>
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
