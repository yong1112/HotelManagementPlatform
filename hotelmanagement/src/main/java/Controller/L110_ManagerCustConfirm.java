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
@WebServlet(name = "L110_ManagerCustConfirm", urlPatterns = {"/L110_ManagerCustConfirm"})
public class L110_ManagerCustConfirm extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        // Capture form data from JSP
        String originalEmail = request.getParameter("oldEmail");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        //firstName = "working";
        
        //db.editStaffDetails(originalEmail, email, firstName, lastName, password);
        //response.sendRedirect("/hotelmanagement/Staff/StaffAccount.jsp");
        
        try {
            if(password.equals(confirmPassword)){
                //Do the thing
                //db.editCustomerDetails(originalEmail, firstName, lastName, password);
                db.editCustomerDetails(originalEmail, firstName, lastName, password);
                //Grabs an arraylist
                //It needs to be updated as an arraylist
                session.setAttribute("customer", db.getAllCustomers());
                response.sendRedirect("/hotelmanagement/Manager/ManagerAccountsList.jsp");
            }
            else {
                session.setAttribute("passwordError", "Passwords do not match.");
                response.sendRedirect("/hotelmanagement/Manager/ManagerCustomerEdit.jsp");
            }
        } catch (NullPointerException ex) { 
            System.out.println(ex);
        }
        
    }
}
