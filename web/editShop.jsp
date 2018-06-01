<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="owner.OwnerDAO" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="store.Store" %>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

    <%
        String loginId;
        Store storeInfo = null;
        OwnerDAO ownerDAO = new OwnerDAO();
        StoreDAO storeDAO = new StoreDAO();

        try {
            if (session.getAttribute("ownerLoginId") != null) {
                loginId = (String) session.getAttribute("ownerLoginId");
                storeInfo = storeDAO.getStoreInfo(loginId);
                if(storeInfo!=null)
                    System.out.println("null이 아니다");
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
</head>
<body>


<section class="container">
    <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#editShopModal">가게정보수정하기</a>
</section>

<div class="modal fade" id="editShopModal" tabindex="-1" role="dialog" aria-labelledbt="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal"> 가게 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"> &times; </span>
                </button>
            </div>

            <div class="modal-body">
                <form action="./editShopAction.jsp" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label>지점명</label>
                            <input type="text" name="name" class="form-control" maxlength="30" value="<%=storeInfo.getName()%>">
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
                            <input type="text" name="addre2" class="form-control" maxlength="30" value="<%=storeInfo.getAddre2()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>읍/면/동, 추가주소 입력</label>
                            <input type="text" name="addre3" class="form-control" maxlength="1000" value="<%=storeInfo.getAddre3()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>가게 전화번호</label>
                            <input type="text" name="phone" class="form-control" maxlength="10000" value="<%=storeInfo.getPhone()%>">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>가게 웹사이트</label>
                            <input type="text" name="website" class="form-control" maxlength="10000" value="<%=storeInfo.getWebsite()%>">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-secondary">수정완료</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
