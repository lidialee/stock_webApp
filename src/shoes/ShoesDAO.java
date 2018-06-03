package shoes;


import java.sql.*;
import java.util.*;

public class ShoesDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String SQL_instruct;

    public ShoesDAO() {
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
     * shoes 테이블에 등록된 신발브랜드를 중복을 허용하지 않고 가져옵니다
     */
    public ArrayList<String> getBrandName() {
        ArrayList<String> list = new ArrayList();
        SQL_instruct = "SELECT DISTINCT brand FROM shoes";

        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(rs.getString(1));
            }

        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }
        return list;
    }


    public ArrayList<Shoe> resultShoesList(String loginId, String br, long min, long max, String se, String co, String si, String ty) {
        String sql_first = "SELECT T.*, store_stock.stock  FROM (SELECT shoes_id, name, brand, type, price, sex, size, color FROM shoes WHERE ";
        String sql_second = ")T INNER JOIN store_stock ON T.shoes_id = store_stock.shoes_id WHERE store_stock.login_id = ? ORDER BY T.shoes_id";
        ArrayList<Shoe> resultList = new ArrayList();

        if(br==""&& min==0 && max==0 && se=="" && co=="" && si=="" && ty=="")
            return null;

        ArrayList<String> instructLine = new ArrayList();
        String temp = "";
        String sumInstr = "";
        String resultSQL = "";

        // 브랜드를 입력했을경우
        if (!br.equals("")&&!br.equals("All")) {
            temp += "shoes.brand = '";
            temp += br;
            temp += "'";
            instructLine.add(temp);
            temp = "";
        }

        // 최소값만 입력받았을 경우
        if (min != 0 && max == 0) {
            temp += "shoes.price>=";
            temp += min;
            instructLine.add(temp);
            System.out.println("최소값만 : " + temp);
            temp = "";
        }

        // 최대값만 입력받았을 경우
        if (min == 0 && max != 0) {
            temp += "shoes.price<=";
            temp += max;
            instructLine.add(temp);
            temp = "";
        }

        // 최대,최소 전부 입력받았을 떄
        if (min != 0 && max != 0) {
            temp += "shoes.price between ";
            temp += min;
            temp += " and ";
            temp += max;
            instructLine.add(temp);
            temp = "";
        }

        // 성별
        if (!se.equals("")){
            String[] sexList = se.split("/");
            temp += "shoes.sex IN(";
            for (int i = 0; i < sexList.length; i++) {
                temp += "'";
                temp += sexList[i];
                temp += "'";
                if (i < sexList.length - 1)
                    temp += ",";
            }
            temp +=")";
            instructLine.add(temp);
            temp = "";
        }

        // 색깔
        if (!co.equals("")){
            String[] colorList = co.split("/");
            temp += "shoes.color IN(";
            for (int i = 0; i < colorList.length; i++) {
                temp += "'";
                temp += colorList[i];
                temp += "'";
                if (i < colorList.length - 1)
                    temp += ",";
            }
            temp +=")";
            instructLine.add(temp);
            temp = "";
        }

        // 사이즈
        if (!si.equals("")){
            String[] sizeList = si.split("/");
            temp += "shoes.size IN(";
            for (int i = 0; i < sizeList.length; i++) {
                temp += "'";
                temp += sizeList[i];
                temp += "'";
                if (i < sizeList.length - 1)
                    temp += ",";
            }
            temp +=")";
            instructLine.add(temp);
            temp = "";
        }

        // 타입
        if (!ty.equals("")){
            String[] typeList = ty.split("/");
            temp += "shoes.type IN(";
            for (int i = 0; i < typeList.length; i++) {
                temp += "'";
                temp += typeList[i];
                temp += "'";
                if (i < typeList.length - 1)
                    temp += ",";
            }
            temp +=")";
            instructLine.add(temp);
            temp = "";
        }


        for (int j = 0; j < instructLine.size(); j++) {
            sumInstr += instructLine.get(j);
            if (j < instructLine.size() - 1)
                sumInstr += " and ";
        }

        resultSQL += sql_first;
        resultSQL += sumInstr;
        resultSQL += sql_second;
        System.out.println("최종_결과 : " + resultSQL);

        try {
            pstmt = conn.prepareStatement(resultSQL);
            pstmt.setString(1, loginId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                resultList.add(new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(8), rs.getLong(5), rs.getString(6), rs.getInt(7), rs.getInt(9)));
            }
        } catch (Exception e) {
            System.out.println("resultShoesList : " + e.getLocalizedMessage());
        }

        return resultList;
    }

    // 이름 검색 결과
    public ArrayList<Shoe> resultSearchByName(String loginId, String inputName) {
        SQL_instruct = "SELECT T.*, store_stock.stock  FROM (SELECT shoes_id, name, brand, type, price, sex, size, color FROM shoes WHERE name LIKE ?)T INNER JOIN store_stock ON T.shoes_id = store_stock.shoes_id WHERE store_stock.login_id = ? ORDER BY T.shoes_id";
        ArrayList<Shoe> list = new ArrayList();
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, "%"+inputName+"%");
            pstmt.setString(2, loginId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                System.out.println("*****");
                list.add(new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(8), rs.getLong(5), rs.getString(6), rs.getInt(7), rs.getInt(9)));
            }
        } catch (Exception e) {
            System.out.println("resultSearchByName : " + e.getLocalizedMessage());
        }
        return list;
    }

    //  (조건x) 주인이 등록한 신발 모두 가져오기
    public ArrayList<Shoe> getAllShoes(String loginID){
        SQL_instruct = "SELECT shoes.*, store_stock.stock FROM shoes INNER JOIN store_stock ON shoes.shoes_id = store_stock.shoes_id WHERE store_stock.login_id = ? ORDER BY shoes.shoes_id";
        ArrayList<Shoe> list = new ArrayList();
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, loginID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(8), rs.getLong(5), rs.getString(6), rs.getInt(7), rs.getInt(9)));
            }
        } catch (Exception e) {
            System.out.println("getAllShoes : " + e.getLocalizedMessage());
        }
        return list;
    }


    // 재고량 업데이트 함수 UPDATE store SET owner_id = ? WHERE name = ?
    public int changeStock(int stock,int shoesID, String loginID){
        SQL_instruct = "UPDATE store_stock SET stock = ? WHERE login_id = ? AND shoes_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setInt(1, stock);
            pstmt.setString(2, loginID);
            pstmt.setInt(3, shoesID);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("changeStock에서 문제 발생 "+e.getLocalizedMessage());
        }

        return -1;
    }

    public int deleteShoes(int shoesID, String loginID){
        SQL_instruct = "DELETE FROM store_stock WHERE login_id = ? AND shoes_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL_instruct);
            pstmt.setString(1, loginID);
            pstmt.setInt(2, shoesID);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("deleteShoes 문제 발생 "+e.getLocalizedMessage());
        }
        return -1;
    }





}
