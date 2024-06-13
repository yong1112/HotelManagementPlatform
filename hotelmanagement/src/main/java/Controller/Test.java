/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//Reading XLS file

import org.bson.Document;

/**
 *
 * @author sorak
 */
@WebServlet(name = "Test", urlPatterns = {"/Test"})
public class Test extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");
        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }
        String name = (String) request.getParameter("name");
        System.out.println(name);
        db.test(name);
    }

}
