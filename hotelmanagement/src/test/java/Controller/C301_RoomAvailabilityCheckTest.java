/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Room;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mockito;

/**
 *
 * @author sorak
 */
public class C301_RoomAvailabilityCheckTest extends Mockito {

    // This will start and stop MongoDB for every test
    
    public MongoDBManager mongo = new MongoDBManager();

    //Declare class from the controller
    C301_RoomAvaiabilityCheck roomchecker;
    C301_RoomAvailabilityCheckTest roomcheckerTest;

    //Before running the test
    @BeforeEach
    void setUp() {
        System.out.println("C301_Room avaiable check test is running");
        roomchecker = new C301_RoomAvaiabilityCheck();
        roomcheckerTest = new C301_RoomAvailabilityCheckTest();
    }

    //Test if no room avaiable during the period
    @Test
    public void checkUnavaiableRoomTest() throws Exception {
        try {
            ArrayList<Room> roomList = mongo.GetRoomEdit();
            ArrayList<String> AllRoomId = new ArrayList<>();

            //Get all room id and store in AllRoomId
            for (int i = 0; i < roomList.size(); i++) {
                AllRoomId.add(roomList.get(i).getRoomNum());
            }

            //First test case
            ArrayList<String> checkRoomId = roomchecker.checkroomID("2021-09-01", "2021-09-10", mongo);
            //Second test case
            ArrayList<String> checkRoomId1 = roomchecker.checkroomID("2021-09-11", "2021-09-20", mongo);
            //Thrid test case
            ArrayList<String> checkRoomId2 = roomchecker.checkroomID("2021-09-21", "2021-09-30", mongo);

            //remove duplicated unavaiable room id
            Set<String> removeCheckRoomId = new HashSet<>(checkRoomId);
            Set<String> removeCheckRoomId1 = new HashSet<>(checkRoomId1);
            Set<String> removeCheckRoomId2 = new HashSet<>(checkRoomId2);

            //clear old unavaiable room id
            checkRoomId.clear();
            checkRoomId1.clear();
            checkRoomId2.clear();

            //add removed duplicate unavaiable room id
            checkRoomId.addAll(removeCheckRoomId);
            checkRoomId1.addAll(removeCheckRoomId1);
            checkRoomId2.addAll(removeCheckRoomId2);

            //roomcheckerTest.findAvaiableRoomId(checkRoomId, roomList, "2", "1");
            //if all room id = unaviable room id in the first test case, mean no room avaiable
            if (AllRoomId.size() == checkRoomId.size()) {
                assertFalse(AllRoomId.size() == checkRoomId.size());
                fail("No room avaiable between 2021-09-01 to 2021-09-10");
                //if all room id = unaviable room id in the second test case, mean no room avaiable   
            } else if (AllRoomId.size() == checkRoomId1.size()) {
                assertFalse(AllRoomId.size() == checkRoomId1.size());
                fail("No room avaiable between 2021-09-11 to 2021-09-20");
                //if all room id = unaviable room id in the thrid test case, mean no room avaiable   
            } else if (AllRoomId.size() == checkRoomId2.size()) {
                assertFalse(AllRoomId.size() == checkRoomId2.size());
                fail("No room avaiable between 2021-09-21 to 2021-09-30");
            }
        } catch (NullPointerException e) { //catch null pointer exception
            assert e.getMessage() != null : "Avaiable should not be null";
        }
    }

}
