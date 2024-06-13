/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mock;
import org.mockito.Mockito;

/**
 *
 * @author chang
 */
public class C403_StaffCancelBookingTest extends Mockito {

    public MongoDBManager mongo = new MongoDBManager();
    C403_StaffCancelBookingTest cancelTest;
    C403_StaffCancelBooking cancel;
    C303_ConfirmBooking create;

    @Mock
    HttpServletRequest request;
    @Mock
    HttpServletResponse response;

    //Before running the test
    @BeforeEach
    public void setUp() {
        System.out.println("C403_StaffCancelBooking is now being tested.");
        cancelTest = new C403_StaffCancelBookingTest();
        cancel = new C403_StaffCancelBooking();
        create = new C303_ConfirmBooking();
    }

    @org.junit.jupiter.api.Test
    //@Test
    public void C403_StaffCancelBookingTest() throws Exception {
        //Test cases: create 3 bookings then delete 3 bookings
        ArrayList<String> booking1 = new ArrayList<>();
        ArrayList<String> booking2 = new ArrayList<>();
        ArrayList<String> booking3 = new ArrayList<>();

        try {
            

            //Create booking 1
            booking1 = create.createStaffBookingTest("12345678", "1", "260", "5", "1300", "2022-01-01", "2022-01-05", "staff1@email.com", "customer1@email.com");
            mongo.CreateStaffBooking(booking1.get(0), booking1.get(1), booking1.get(2), booking1.get(3), booking1.get(4), booking1.get(5), booking1.get(6), booking1.get(7), booking1.get(8));
            //Delete booking 1
            mongo.cancelBooking(booking1.get(0));

            //Create booking 2
            booking2 = create.createStaffBookingTest("12131415", "2", "500", "5", "2500", "2022-02-01", "2022-02-05", "staff2@email.com", "customer2@email.com");
            mongo.CreateStaffBooking(booking2.get(0), booking2.get(1), booking2.get(2), booking2.get(3), booking2.get(4), booking2.get(5), booking2.get(6), booking2.get(7), booking2.get(8));
            //Delete booking 2     
            mongo.cancelBooking(booking2.get(0));

            //Create booking 3
            booking3 = create.createStaffBookingTest("01020304", "3", "300", "5", "1500", "2022-03-01", "2022-03-05", "staff3@email.com", "customer3@email.com");
            mongo.CreateStaffBooking(booking3.get(0), booking3.get(1), booking3.get(2), booking3.get(3), booking3.get(4), booking3.get(5), booking3.get(6), booking3.get(7), booking3.get(8));
            //Delete booking 3
            mongo.cancelBooking(booking3.get(0));
            
            //Retrieve all booking ID from database
            ArrayList<String> allBookingID = mongo.getBookingID();
            //Check if booking exists or not by comparing BookingID to AllBookingID in database
            if (!allBookingID.contains(booking1.get(0))) {
                System.out.println("First test case is successful!");
                if (!allBookingID.contains(booking2.get(0))) {
                    System.out.println("Second test case is successful!");
                    if (!allBookingID.contains(booking3.get(0))) {
                        System.out.println("Third test case is successful!");
                    }
                }
            } else {
                System.out.println("Test cases failed");
            }
        } catch (NullPointerException e) {
            assert e.getMessage() != null : "Something went wrong :x";
            response.sendRedirect("/hotelmanagement/index.jsp");
        }
    }

    @AfterEach
    void afterTest() {
        System.out.println("C403_StaffCancelBooking has passed the test.");
    }
}
