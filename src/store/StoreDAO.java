package store;

import java.sql.*;
import java.util.*;

// 디비를 사용해 데이터를 조회하거나 조작하는 기능을 전담하는 클래스
public class StoreDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet resultSet;
    private String SQL_instruct;
    private String SQL_instruct2;
    private int managerNum = 1;
    private int storeId;

    public StoreDAO() throws ClassNotFoundException {
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
//
//    -2 : 데이터베이스 오류
//    -1 : 아이디가 없음
//    0 : 비밀번호 불일치
//    1 : 로그인 성공

    public int login(String id, String pass) {
        SQL_instruct = "SELECT manager_pass FROM store_info WHERE manager_id = ?";
        System.out.println("id = " + id);
        System.out.println("pass = " + pass);
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
     * DB 'store'테이블의 'name'의 모든 값 가져오기
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
     * return  1  : 등록가능
     * 100 : 이미 등록된 매장
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
                else return 100;                                         //  이미 등록된 매장
            }

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return -1;                                                       //  쿼리 에러
    }

    /**
     * checkAlreadyRegister의 결과가 1인 경우(성공)
     * 해당 store_id를 구하는 함수
     * (두번째)
     * <p>
     * return  resultSet.getInt(1) : 성공한 경우 결과값, 매장의 ID를 반환한다(INT(11))
     * 1                   :
     */
    public int getStoreId(int checkStoreResult, String storeName) {

        // 등록가능한 경우
        if (checkStoreResult == 1) {
            System.out.println("등록가능한 점포");
            SQL_instruct = "SELECT store_id FROM store WHERE name = ?";
            try {
                pstmt = conn.prepareStatement(SQL_instruct);
                pstmt.setString(1, storeName);
                resultSet = pstmt.executeQuery();
                if (resultSet.next())
                    return resultSet.getInt(1);
                else
                    return 1;

            } catch (Exception e) {
                System.out.println(e.getLocalizedMessage());
            }

        }

        // 이미 등록된 매장
        else if (checkStoreResult == 100) {
            System.out.println("이미 등록한 점포");
            return 1;
        }
        // 쿼리 에러
        else {
            System.out.println("데이터베이스 오류");
            return 1;
        }
        return 1;
    }

    /**
     * getStoreId에서 얻는 결과를 가지고 나머지 아이디, 비밀번호와 함께 디비에 최종 저장하기 결과가
     * (최종 등록번째)
     * 1. owner에 새로운 점주정보 등록
     * 2. 해당 store의 owner_id를 1에서 새로운 owner_id로 업데이트하자
     */
    public int join(Store store, String storeName) {
        storeId = getStoreId(checkAlreadyRegister(storeName), storeName);

        if (storeId != 1) {
            SQL_instruct = "INSERT INTO owner(owner_id,login_id,password,phone,name,store_id) VALUES(?,?,?,?,?,?)";
            try {
                pstmt = conn.prepareStatement(SQL_instruct);
                pstmt.setString(1, makeRandomOwnerId());
                pstmt.setString(2, store.getOwnerLoginId());
                pstmt.setString(3, store.getOwnerPass());
                pstmt.setString(4, store.getOwnerPhone());
                pstmt.setString(5, store.getOwnerName());
                pstmt.setInt(6, storeId);
                System.out.println(managerNum);
                return pstmt.executeUpdate();

            } catch (SQLException e) {
                System.out.println("join()에서의 에러1 : " + e.getSQLState());
                System.out.println("join()에서의 에러2 : " + e.getLocalizedMessage());
                System.out.println("join()에서의 에러3 : " + e.getErrorCode());
            }
        } else {
            System.out.println("어딘가문제가 나온다");
            return -2;
        }
        return -1; // 데이터베이스 오류
    }

    public void saveOwenrId() {

    }

    private String makeRandomOwnerId() {
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();

        String elements[] = "a,b,c,d,e,f,g,h,j,1,2,3,4,5,6,7,8,9".split(",");
        for (int i = 0; i < 6; i++)
            buffer.append(elements[random.nextInt(elements.length)]);

        return buffer.toString();
    }
}
