<%@page import="java.util.ArrayList"%>
<%@page import="Model.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Room Management</title>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <link rel="stylesheet" href="style.css" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%
        String checkRoomNum = (String) session.getAttribute("roomIdExist");
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
        String adminLoginCheck = (String) session.getAttribute("adminLoginCheck");
    %>

    <body onload="checkRoomId()">
        <div class="ui middle aligned grid" 
             style="margin-top: 20px; margin-left: 20%; margin-right:20%">
            <div class="column">
                <h1>
                    <div class="content">
                        Fill in the room details
                    </div>
                </h1>
                <center>
                    <form class="ui form segment" enctype="multipart/form-data" action="/hotelmanagement/C201_CreateRoom" method="post" >
                        <center>
                            <div class="five wide field">
                                <label>Room name</label>
                                <input type="text" required name="roomName">
                            </div>
                            <div class="five wide field">
                                <label>Room number</label>
                                <input type="text" required name="roomNum">
                            </div>
                            <div class="five wide field">
                                <label>Price</label>
                                <input type="text" required name="roomPrice">
                            </div>
                            <div class="five wide field">
                                <label>Adult Capacity</label>
                                <input type="text" required name="adultCapacity">
                            </div>
                            <div class="five wide field">
                                <label>Child Capacity</label>
                                <input type="text" required name="childCapacity">
                            </div>
                            <div class="ten wide field">
                                <label>Description</label>
                                <input type="text" required name="description">
                            </div>
                            <div class="five wide field">     
                                <label>File:</label>
                                <input type="file" name="roomImage" id="roomImage" onchange="loadFile(event)"/> 
                                <p><img id="output" width="200" /></p>
                            </div>
                            <div >
                                <input type="hidden" name="availability" value="available">
                                <button type="submit" class="ui positive button">Create</button>
                                <button type="button" class="ui button" onclick="ToManagerRoom()">Cancel</button>
                            </div>

                            <p>&nbsp;</p>
                        </center>
                    </form>
                </center>
            </div>
        </div>

        <script>
            function checkRoomId()
            {
                const roomIdExist = "" + "<%=checkRoomNum%>";
                const checkManagerLogin = "" + "<%=checkLogin%>";
                const checkAdminLogin = "" + "<%=adminLoginCheck%>";
                if (checkManagerLogin === ("null") && checkAdminLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                } else if (roomIdExist === ("Room_id already exist in the database"))
                {
                    alert(roomIdExist);
                    location.reload();
                }
            }
            //display uploaded image in html
            var loadFile = function (event) {
                var image = document.getElementById('output');
                image.src = URL.createObjectURL(event.target.files[0]);
            };
        </script>
        <%
            session.removeAttribute("roomIdExist");
        %>
    </body>
</html>
