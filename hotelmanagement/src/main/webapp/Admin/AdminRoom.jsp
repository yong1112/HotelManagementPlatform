<%@page import="java.util.ArrayList"%>
<%@page import="Model.Room"%>
<%@page import="DAO.MongoDBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Rooms</title>
    </head>
    <%
        String adminLoginCheck = (String) session.getAttribute("adminLoginCheck");
    %>
    <body onload="checkLogin()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToAdminIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToAdminRoomTwo()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToAdminRoom()" class="active item">
                            ROOM MANAGEMENT
                        </a>
                        <a onClick="ToAdminDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToAdminAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToAdminContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToAdminAccountsList()" class="item">
                            VIEW ACCOUNTS 
                        </a>
                        <a onClick="ToManagerRegister()" class="item">
                            CREATE AN ACCOUNT
                        </a>
                        <div class="right item">
                            <a onClick="ToManagerAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>
                </div>   
            </div>
        </div>
        <div style="margin-top: 10px; margin-left: 50px">
            <!-- Header !-->
            <h1 class="ui header">ROOM MANAGEMENT</h1>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <!-- Site content !-->
            <button class ="ui blue button" type="submit" onClick="ToCreateRoom()">Create Room</button>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <table id ="example" class="ui large celled striped table">
                <thead>
                    <tr><th>Room Name</th>
                        <th>Room Number</th>
                        <th>Room Price</th>
                        <th>Adult Capacity</th>
                        <th>Child Capacity</th>
                        <th>Room status</th>
                        <th>Room description</th>
                        <th>Edit Room</th>
                        <th>Delete Room</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

                        if (db == null) {
                            db = new MongoDBManager();
                            session.setAttribute("Query", db);
                        }

                        ArrayList<String> RoomList = db.GetRoomList();
                        for (int i = 0; i < RoomList.size(); i += 8) {
                    %>
                    <tr>
                        <td><%=RoomList.get(i)%></td>
                        <td><%=RoomList.get(i + 1)%></td>
                        <td><%=RoomList.get(i + 2)%></td>
                        <td><%=RoomList.get(i + 3)%></td>
                        <td><%=RoomList.get(i + 4)%></td>
                        <td><%=RoomList.get(i + 5)%></td>
                        <td><%=RoomList.get(i + 6)%></td>
                <form action="/hotelmanagement/C204_EditRoom" method="GET">   
                    <td>
                        <button class ="ui blue button" type="submit" name="editButton" value="<%=RoomList.get(i + 1)%>">Edit</button>
                    </td>
                </form>
                <form action="/hotelmanagement/C203_DeleteRoom" method="post">
                    <td><button type="submit" class="ui red button" name="roomNum" value="<%=RoomList.get(i + 1)%>">Delete</button></td>
                </form>   
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/dataTables.semanticui.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" ></script>
<script>

                function checkLogin()
                {
                    const checkAdminLogin = "" + "<%=adminLoginCheck%>";
                    if (checkAdminLogin === ("null")) {
                        setTimeout(() => {
                            ;
                        }, 0);
                        window.location.href = "http://localhost:8080/hotelmanagement/";
                    }
                }

                $(document).ready(function () {
                    $('#example').DataTable();
                });
</script>
<script>
    function ToCreateRoom() {
        window.location = "/hotelmanagement/Manager/CreateRoom.jsp";
    }
</script>
