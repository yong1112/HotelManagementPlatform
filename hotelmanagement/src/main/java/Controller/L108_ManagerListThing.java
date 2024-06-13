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
@WebServlet(name = "L108_ManagerListThing", urlPatterns = {"/L108_ManagerListThing"})
public class L108_ManagerListThing extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String username = request.getParameter("btn");
        //System.out.print(username);
        session.setAttribute("staff", db.FindStaffDetails(username)); //Sets the staff
        response.sendRedirect("/hotelmanagement/Manager/ManagerStaffEdit.jsp");
    }
}
