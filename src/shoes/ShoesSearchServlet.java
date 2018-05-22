package shoes;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "ShoesSearchServlet")
public class ShoesSearchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String brand = request.getParameter("brand");
        String[] sex = request.getParameterValues("sex");
        String minPrice = request.getParameter("price_min");
        String maxPrice = request.getParameter("price_max");
        String[] color = request.getParameterValues("color");
        String[] size = request.getParameterValues("size");
        String[] type = request.getParameterValues("type");
        //response.getWriter().writer(getJSON())
    }

    public String getJSON(String loginId, String brand, String[] sex, String min, String max,
                          String[] color, String[] size, String[] type){
        StringBuffer result = new StringBuffer();
        result.append("{\result\":[");
        ShoesDAO shoesDao = new ShoesDAO();
        ArrayList<Shoe> list = new ArrayList();
        // list =  shoesDao의 원하는 조건에 맞는 신발 가져오기 함수 부르기
        // 이 함수에서 stock을 가져오도록 해야됩니다.
        // 그냥 shoes 테이블엔 재고가 없는거 아시죠?
        for(int i =0;i< list.size();i++){
            result.append("{\"value\": \""+list.get(i).getName()+ "\"},");
            result.append("[{\"value\": \""+list.get(i).getBrand()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getType()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getSex()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getColor()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getPrice()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getSize()+ "\"},");
            result.append("{\"value\": \""+list.get(i).getStock()+ "\"},");
        }
        result.append("]}");
        return result.toString();
    }






}
