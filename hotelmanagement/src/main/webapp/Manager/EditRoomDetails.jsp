<%@page import="Model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Edit Details</title>
    </head>
    <body> 
        <%
            Room r = (Room) session.getAttribute("rooms");
            %>
        <div class="ui middle aligned grid" 
             style="margin-top: 20px; margin-left: 20%; margin-right:20%">
            <div class="column">
                <h1>
                    <div class="content">
                        Edit room details
                    </div>
                </h1>
                <center>
                    <form class="ui form segment" action="/hotelmanagement/C205_EditRoomDetails" method="Get">
                        
                            <div class="five wide field">
                                <label>Room Name</label>
                                <input value="<%=r.getRoomName()%>" autocomplete="off" required name="roomName" type="text">
                            </div>
                            <div class="five wide field">
                                <label>Room Number</label>
                                <input value="<%=r.getRoomNum()%>" autocomplete="off" required name="roomNum" type="text" readonly>
                            </div>
                            <div class="five wide field">
                                <label>Room Price</label>
                                <input value="<%=r.getRoomPrice()%>" autocomplete="off" required name="roomPrice" type="text">
                            </div>
                            <div class="five wide field">
                                <label>Adult Capacity</label>
                                <input value="<%=r.getAdultCapacity()%>" autocomplete="off" required name="adultCapacity" type="text">
                            </div>
                            <div class="five wide field">
                                <label>Child Capacity</label>
                                <input value="<%=r.getChildCapacity()%>" autocomplete="off" required name="childCapacity" type="text">
                            </div>
                             <div class="five wide field">
                                <label>Description</label>
                                <input value="<%=r.getDescription()%>" autocomplete="off" required name="description" type="text">
                            </div>
                            <div >
                                <button type="submit" class="ui green medium submit button">Confirm Changes</button>
                                <button type="button" onClick="ToManagerRoom()" class="ui medium button">Cancel</button>

                            </div>
                      
                    </form>
                </center>
            </div>
        </div>
    </body>
</html>