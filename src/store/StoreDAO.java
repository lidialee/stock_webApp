package store;

import java.sql.*;

public class StoreDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String SQL_instruct;

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

    public Store getStoreInfo(String loginID){
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

    public int updateStoreInfo(Store store, String loginId){
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
            System.out.println("updateStoreInfo 문제 발생 "+e.getLocalizedMessage());
        }
        return -1;
    }

}
