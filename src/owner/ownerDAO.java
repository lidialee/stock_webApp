package owner;

import java.sql.*;
import java.util.*;

// 디비를 사용해 데이터를 조회하거나 조작하는 기능을 전담하는 클래스
public class ownerDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet resultSet;
    private String SQL_instruct;

    public ownerDAO(){
        try {
            String dbURL = "jdbc:mysql://localhost:3306/beetle";
            String dbID = "root";
            String dbPass = "0516";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPass);
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
            System.out.println(e.getLocalizedMessage());
        }
    }

    /**
     * return
     *  1  : 로그인 성공
     * -2  : 데이터베이스 오류
     * -1  : 아이디가 없음
     *  0  : 비밀번호 불일치
     */
    public int login(String id, String pass) {
        SQL_instruct = "SELECT password FROM owner WHERE login_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, id);  // 첫번째(1) ?를 id로 채우기
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                if (resultSet.getString(1).equals(pass))
                    return 1;
                else
                    return 0;
            }

            return -1;
        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return -2;
    }


    /**
     * DB 'owner'테이블의 'name'의 모든 값 가져오기
     */
    public ArrayList<String> getStoreName() {
        ArrayList<String> list = new ArrayList();
        SQL_instruct = "SELECT name FROM store";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
                list.add(resultSet.getString(1));

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return list;
    }


    /**
     * 이미 등록된 점포인지 확인
     * (첫번째)
     * return
     *  1  : 등록가능
     * -2  : 이미 등록된 매장
     * -1  : 쿼리 에러
     */
    public int checkAlreadyRegister(String storeName) {
        SQL_instruct = "SELECT owner_id FROM store WHERE name = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, storeName);
            resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                if (resultSet.getString(1).equals("1")) return 1;        //  등록가능
                else return -2;                                          //  이미 등록된 매장
            }

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return -1;                                                       //  쿼리 에러
    }

    /**
     * 해당 store_id를 구하는 함수
     * (두번째)
     * <p>
     * return
     * resultSet.getInt(1)   : 성공한 경우 결과값, 매장의 ID를 반환한다(INT(11))
     * 1                     : 실패한 경우
     */
    public int getStoreId(String storeName) {
        SQL_instruct = "SELECT store_id FROM store WHERE name = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, storeName);
            resultSet = pstmt.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return 1;
    }

    /**
     * getStoreId에서 얻는 결과를 가지고 나머지 아이디, 비밀번호와 함께 디비에 최종 저장하기 결과가
     * (최종 등록번째)
     * 1. owner에 새로운 점주정보 등록
     * 2. 해당 store의 owner_id를 1에서 새로운 owner_id로 업데이트하자
     */
    public int join(Owner owner, String storeName) {
        int re = checkAlreadyRegister(storeName);
        int storeId;

        if (re == 1) {
            storeId = getStoreId(storeName);  //  store_id 가져오기
            if (storeId != 1) {
                SQL_instruct = "INSERT INTO owner(owner_id,login_id,password,phone,name,store_id) VALUES(?,?,?,?,?,?)";
                try {
                    pstmt = conn.prepareStatement(SQL_instruct);
                    pstmt.setString(1, makeRandomOwnerId());
                    pstmt.setString(2, owner.getOwnerLoginId());
                    pstmt.setString(3, owner.getOwnerPass());
                    pstmt.setString(4, owner.getOwnerPhone());
                    pstmt.setString(5, owner.getOwnerName());
                    pstmt.setInt(6, storeId);
                    return pstmt.executeUpdate();
                } catch (SQLException e) {
                    System.out.println("join()에서의 에러2 : " + e.getLocalizedMessage());
                }
            } else System.out.println("등록은 안된 매장이지만 .. 어째서인가 매장id를 가져오지 못한다.");

        } else if (re == -2) return -2;          //  이미 등롣됨
        else if (re == -1) return -1;          //  쿼리 에러
        return -3;                            //  아이디 중복
    }



    public int setOwnerIdIntoStore(String loginId,String storeName){
        String ownerId;
        SQL_instruct = "SELECT owner_id FROM owner WHERE login_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, loginId);
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                ownerId = resultSet.getString(1);
                SQL_instruct = "UPDATE store SET owner_id = ? WHERE name = ? ";
                try {
                    pstmt = conn.prepareStatement(SQL_instruct);
                    pstmt.setString(1, ownerId);
                    pstmt.setString(2, storeName);
                    return pstmt.executeUpdate();
                }catch(SQLException e){
                    System.out.println("위치확인1");
                    System.out.println(e.getLocalizedMessage());
                }
            }else{
                System.out.println("ownerId를 구하지 못한경우");
                return -1;
            }
        } catch (Exception e) {
            System.out.println("위치확인2");
            System.out.println(e.getLocalizedMessage());
        }
        return -2;
    }




    /**
     * owner테이블의 pk인 owner_id를 생성하는 랜덤함수
     * 총 10가지 원소로 length = 9인 랜덤 문자열출력
     * 10의 9승의 경우의 수 중복 가능성이 희박하다고 생각해서
     * 중복 발생 처리를 하지 않았다.
     * 나중에 해야지
     */
    private String makeRandomOwnerId() {
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();

        String elements[] = "a,b,c,d,e,f,g,h,j,1,2,3,4,5,6,7,8,9".split(",");
        for (int i = 0; i < 9; i++)
            buffer.append(elements[random.nextInt(elements.length)]);

        return buffer.toString();
    }

}
