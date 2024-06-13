package Controller;

import DAO.MongoDBManager;
import Model.Staff;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "L102_AccountList", urlPatterns = {"/L102_AccountList"})
public class L102_AccountList extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        ArrayList<Staff> staffs = new ArrayList<Staff>();
        String username = (String) request.getParameter("username");

        staffs = db.GetStaffEdit();
        session.setAttribute("newRoom", staffs);
        response.sendRedirect("/hotelmanagement/Manager/AccountList.jsp");
        
    }
}