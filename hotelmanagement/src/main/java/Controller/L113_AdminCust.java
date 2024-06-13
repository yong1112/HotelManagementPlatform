package Controller;

import DAO.MongoDBManager;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.FileSystemNotFoundException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author csw
 */
@WebServlet(name = "L113_AdminCust", urlPatterns = {"/L113_AdminCust"})
public class L113_AdminCust extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String username = request.getParameter("butt");
        System.out.print(username);
        session.setAttribute("customer", db.FindCustomerDetails(username)); //Sets the customer
        response.sendRedirect("/hotelmanagement/Admin/AdminCustomerEdit.jsp");
    }
}
