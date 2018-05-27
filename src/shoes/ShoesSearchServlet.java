package shoes;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet("/ShoesSearchServlet")
public class ShoesSearchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String shoesNameInput = request.getParameter("ShoesNameInput");
        String loginID = request.getParameter("OwnerLogin");
        System.out.println("in doPost : "+loginID);
        System.out.println("nameINPUT : "+ shoesNameInput);
        response.getWriter().write(getJSON(shoesNameInput,"checkID"));
    }

    public String getJSON(String shoesNameInput,String loginID){
        if(shoesNameInput == null) shoesNameInput = "";
        if(loginID.equals("")) {
            System.out.println("problem occur");
            return "";
        }

        StringBuffer result = new StringBuffer();
        result.append("{\"result\":[");
        ShoesDAO shoesDAO = new ShoesDAO();
        ArrayList<Shoe> list = shoesDAO.resultSearchByName(loginID,shoesNameInput);
        for(int i =0;i< list.size();i++){
            System.out.println("in getjson : "+list.get(i).getName());
            result.append("[{\"value\":\""+list.get(i).getShoesId()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getName()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getBrand()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getType()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getSex()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getColor()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getPrice()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getSize()+ "\"},");
            result.append("{\"value\":\""+list.get(i).getStock()+ "\"}],");
        }
        result.append("]}");
        return result.toString();
    }






}
