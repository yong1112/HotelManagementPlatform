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
@WebServlet(name = "L104_StaffEditDetails", urlPatterns = {"/L104_StaffEditDetails"})
public class L104_StaffEditDetails extends HttpServlet {

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
        System.out.println(originalEmail);
        System.out.println(firstName);
        System.out.println(lastName);
        System.out.println(password);
        System.out.println(confirmPassword);
        
        //firstName = "working";
        //db.editStaffDetails(originalEmail, email, firstName, lastName, password);
        //response.sendRedirect("/hotelmanagement/Staff/StaffAccount.jsp");
        
        //try {
            if(password.equals(confirmPassword)){
                //Do the thing
                //db.editCustomerDetails(originalEmail, firstName, lastName, password);
                session.setAttribute("user", db.editStaffDetails(originalEmail, firstName, lastName, password));
                response.sendRedirect("/hotelmanagement/Staff/StaffAccount.jsp");
            }
            else {
                session.setAttribute("passwordError", "Passwords do not match.");
                response.sendRedirect("/hotelmanagement/Staff/EditStaffDetail.jsp");
            }
        } //catch (NullPointerException ex) { 
            //System.out.println(ex);
        //}
        
    //} 
}
