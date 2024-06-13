package DAO;
import com.mongodb.connection.Connection;


public class MongoDB {
        protected String db = "hotelmanagement";//name of the database   
        protected String dbuser  = "admin"; 
        protected String dbpass = "admin";
        protected Connection conn; //connection null-instance to be initialized in sub-classes
}
