package Controller;

import DAO.MongoDBManager;
import Model.Customer;
import java.util.UUID;
import static org.junit.Assert.*;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 *
 * @author oneilrangiuira
 */
public class C106_ResetPasswordTest {
      
    MongoDBManager db;
    
    Customer cust;
    String token;
    String email;
    String password;
    
    public C106_ResetPasswordTest() {
        db = new MongoDBManager();
    }
    
    @BeforeAll
    public static void setUpClass() {
        System.out.println("C106_ResetPaswordTest is running");
    }
    
    @AfterAll
    public static void tearDownClass() {
         System.out.println("C106_ResetPaswordTest is completed");
    }
    
    @BeforeEach
    public void setUp() {
        System.out.println("Beginning new test!");
        
        email = "Test@gmail.com";
        token = UUID.randomUUID().toString();
        password = "Password";
        cust = new Customer("Testfirst", "TestLast", email, password, true);
    }
    
    @AfterEach
    public void tearDown() {
        // Delete created user
        db.deleteUser(email);
        System.out.println("A Test Completed");
    }
    
    // Test to create a token in the database
    @Test
    public void createUserTokenTest() {
        System.out.println("Testing isTokenExist in database");

        assertFalse("Testing non-existant Token is false" ,db.isTokenExist(token));
        
        // Create new user
        db.CreateCustomer(cust);

        // Create token for user
        db.createUserToken(email, token);
        
        assertTrue("Testing that the existing token is true", db.isTokenExist(token));
        
        // Delete created user
        db.deleteUser(email);
    }
    
    
    // Get Customer first name
    @Test
    public void getNamebyTokenTest() {
        System.out.println("Testing if Token is completed");
        
        Assertions.assertThrows(NullPointerException.class, () -> {
            System.out.println("Testing to get an empty string for finding a token that doesn't exists");
            db.getNamebyToken(token);
        });
        
        // Create new user & token
        db.CreateCustomer(cust);
        db.createUserToken(email, token);
        
        assertNotEquals("Testing to get the incorrect string name", "IncorrectTestFirstname", db.getNamebyToken(token));        
        assertEquals("Testing to get the correct string name", "Testfirst", db.getNamebyToken(token));
    }

    // Test to check the difference
    @Test
    public void TokenDateTimeDiffTest() {
        System.out.println("Testing time difference");
        
        Assertions.assertThrows(NullPointerException.class, () -> {
            System.out.println("Testing to get empty string if token does not exists");
            db.getTokenTimeDiff(token);
        });
        
        // Create new user & token
        db.CreateCustomer(cust);
        db.createUserToken(email, token);
        
        // Create 2 hrs time frame to milliseconds
        long expiryTime = 2 * 60 * 60 * 1000;
        
        assertTrue("Testing that time differenent is under expiryTime", db.getTokenTimeDiff(token) < expiryTime);
        assertFalse("Testing that time differenent is over expiryTime", db.getTokenTimeDiff(token) > expiryTime);
    }
}
