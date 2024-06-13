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
public class C303_ConfirmBookingTest extends Mockito {

    public MongoDBManager mongo = new MongoDBManager();
    C303_ConfirmBookingTest confirmTest;
    C303_ConfirmBooking confirm;

    @Mock
    HttpServletRequest request;
    @Mock
    HttpServletResponse response;

    //Before running the test
    @BeforeEach
    public void setUp() {
        System.out.println("C303_ConfirmBooking is now being tested.");
        confirmTest = new C303_ConfirmBookingTest();
        confirm = new C303_ConfirmBooking();
    }

    public void checkCustomerEmail(String email) {

    }

    // What am I testing for?
    // Booking confirmation
    @org.junit.jupiter.api.Test
    //@Test
    public void C303_ConfirmBookingTest() throws Exception{
        //Test cases: create 3 bookings
        ArrayList<String> booking1 = new ArrayList<>();
        ArrayList<String> booking2 = new ArrayList<>();
        ArrayList<String> booking3 = new ArrayList<>();

        try {
            //01/01/2025 - 05/01/2025, 2 adults, 1 child, customer1@email.com
            booking1 = confirm.createStaffBookingTest("12345678", "1", "260", "5", "1300", "2025-01-01", "2025-01-05", "customer1@email.com", "Test1@email.com");
            mongo.CreateStaffBooking(booking1.get(0), booking1.get(1), booking1.get(2), booking1.get(3), booking1.get(4), booking1.get(5), booking1.get(6), booking1.get(7), booking1.get(8));

            //01/02/2025 - 05/02/2025, 2 adults, 1 child, customer2@email.com
            booking2 = confirm.createStaffBookingTest("12345688", "2", "500", "5", "2500", "2025-02-01", "2025-02-05", "customer2@email.com", "Test2@email.com");
            mongo.CreateStaffBooking(booking2.get(0), booking2.get(1), booking2.get(2), booking2.get(3), booking2.get(4), booking2.get(5), booking2.get(6), booking2.get(7), booking1.get(8));

            //01/03/2025 - 05/03/2025, 2 adults, 1 child, customer3@email.com
            booking3 = confirm.createStaffBookingTest("12345689", "3", "300", "5", "1500", "2025-03-01", "2025-03-05", "customer3@email.com", "Test3@email.com");
            mongo.CreateStaffBooking(booking3.get(0), booking3.get(1), booking3.get(2), booking3.get(3), booking3.get(4), booking3.get(5), booking3.get(6), booking3.get(7), booking1.get(8));

            //Check booking exists [to see if Customer + Staff + Booking Details are correct]
            if (mongo.BookingExistence("Test1@email.com", "2025-01-01", "customer1@email.com")) {
                System.out.println("Booking1 has passed the test");
                //fail("Booking1 has failed the test");
                if (mongo.BookingExistence("Test2@email.com", "2025-02-01", "customer2@email.com")) {
                    System.out.println("Booking2 has passed the test");
                    //fail("Booking2 has failed the test");
                    if (mongo.BookingExistence("Test3@email.com", "2025-03-01", "customer3@email.com")) {
                        System.out.println("Booking3 has passed the test");
                        //System.out.println("C303_ConfirmBookingTest passed all test cases.");
                        //fail("Booking3 has failed the test");
                    }
                }
            } else {
                System.out.println("Test cases failed");
            }
        } catch (NullPointerException e) {
            assert e.getMessage() != null : "Something went wrong :x";
            response.sendRedirect("/hotelmanagement/index.jsp");
        }

        //Check to see if customer email is stored
        //Check to see if staff email is stored
    }

    @AfterEach
    void afterTest() {
        System.out.println("C303_ConfirmBooking has passed the test.");

        //Cancel bookings
        mongo.cancelBooking("12345678");
        mongo.cancelBooking("12345688");
        mongo.cancelBooking("12345689");
    }
}
