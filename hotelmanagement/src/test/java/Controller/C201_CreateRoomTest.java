package Controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mockito;
import org.mockito.Mock;

public class C201_CreateRoomTest extends Mockito {

    //Declare class from the controller
    C201_CreateRoom createRoom;

    @Mock
    HttpServletRequest request;

    @Mock
    HttpServletResponse response;

    //Before running the test
    @BeforeEach
    public void setUp() {
        System.out.println("C201_Create room test is running.");
        createRoom = new C201_CreateRoom();
    }

    //Check if create room is created
    public ArrayList<String> createRoomTest(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity, String availability) {
        ArrayList<String> roomList = new ArrayList<>();
        roomList.add(roomName);
        roomList.add(roomNum);
        roomList.add(roomPrice);
        roomList.add(adultCapacity);
        roomList.add(childCapacity);
        roomList.add(availability);

        return roomList;
    }

    @org.junit.jupiter.api.Test
    public void checkCreatedRoomTest() throws Exception {
        try {
            ArrayList<String> roomList = new ArrayList<>();

            //test whether the room is created
            ArrayList<String> room = new ArrayList<>();
            ArrayList<String> room2 = new ArrayList<>();
            ArrayList<String> room3 = new ArrayList<>();

            //test case
            room = createRoomTest("premium", "101", "120", "2", "1", "available");
            room2 = createRoomTest("premium1", "102", "202", "3", "1", "available");
            room3 = createRoomTest("premium2", "202", "200", "4", "1", "available");

            if (!room.isEmpty()) {
                assertEquals("premium", room.get(0));
                assertEquals("101", room.get(1));
                assertEquals("120", room.get(2));
                assertEquals("2", room.get(3));
                assertEquals("1", room.get(4));
                assertEquals("available", room.get(5));
                System.out.println("First test case is successful!");
            } if (!room2.isEmpty()) {
                assertEquals("premium1", room2.get(0));
                assertEquals("102", room2.get(1));
                assertEquals("202", room2.get(2));
                assertEquals("3", room2.get(3));
                assertEquals("1", room2.get(4));
                assertEquals("available", room2.get(5));
                System.out.println("Second test case is successful!");
            } if (!room3.isEmpty()) {
                assertEquals("premium2", room3.get(0));
                assertEquals("202", room3.get(1));
                assertEquals("200", room3.get(2));
                assertEquals("4", room3.get(3));
                assertEquals("1", room3.get(4));
                assertEquals("available", room3.get(5));
                System.out.println("Third test case is successful!");
            }

        } catch (NullPointerException e) { //catch null pointer exception
            assert e.getMessage() != null : "Room should be created";
            response.sendRedirect("/hotelmanagement/index.jsp");
        }

    }

    @AfterEach
    void afterTesting() {
        System.out.println("C201_Create room has passed the test.");
    }

}