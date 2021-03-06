package store;

import java.sql.*;
import java.util.*;
import java.util.ArrayList;

public class StoreDAO {
    private Connection conn;
    private PreparedStatement pstmt, pstmt2;
    private ResultSet rs, rs2;
    private String SQL_instruct, SQL_instruct2;

    public StoreDAO() {
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

    public Store getStoreInfo(String loginID) {
        SQL_instruct = "SELECT name,addre1,addre2,addre3,phone,website FROM store WHERE owner_id = ?";
        Store store = null;
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, loginID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                store = new Store(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {
            System.out.println("getAllShoes : " + e.getLocalizedMessage());
        }
        return store;
    }

    public int updateStoreInfo(Store store, String loginId) {
        SQL_instruct = "UPDATE store SET name =? ,addre1 = ? ,addre2 = ?,addre3 =? ,phone =? ,website = ? WHERE owner_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, store.getName());
            pstmt.setString(2, store.getAddre1());
            pstmt.setString(3, store.getAddre2());
            pstmt.setString(4, store.getAddre3());
            pstmt.setString(5, store.getPhone());
            pstmt.setString(6, store.getWebsite());
            pstmt.setString(7, loginId);

            return pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateStoreInfo 문제 발생 " + e.getLocalizedMessage());
        }
        return -1;
    }

    // (Share) 공유 지점의 점주 아이디 가져오기
    public ArrayList<String> getSharedOwnerId(String loginId) {
        ArrayList<String> list = new ArrayList();
        SQL_instruct = "SELECT store_1 FROM relation WHERE store_2=?";
        SQL_instruct2 = "SELECT store_2 FROM relation WHERE store_1=?";

        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt2 = conn.prepareStatement(SQL_instruct2);
            pstmt.setString(1, loginId);
            pstmt2.setString(1, loginId);
            rs = pstmt.executeQuery();
            rs2 = pstmt2.executeQuery();

            while (rs.next())
                list.add(rs.getString(1));

            while (rs2.next())
                list.add(rs2.getString(1));

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return list;
    }

    // 같은 경기도 지역 가게 이름과 점장 아이디 가져오기
    public ArrayList<StoreOwner> getSameAreaStoreInfo(String addre1,String myId) {
        ArrayList<StoreOwner> resultList = new ArrayList();
        SQL_instruct = "SELECT name, owner_id FROM store WHERE addre1=? AND owner_id NOT IN('1',?)";

        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, addre1);
            pstmt.setString(2, myId);
            rs = pstmt.executeQuery();
            while (rs.next())
                resultList.add(new StoreOwner(rs.getString(1), rs.getString(2)));

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return resultList;
    }
}
