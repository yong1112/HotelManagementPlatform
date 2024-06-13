<%@page import="java.util.ArrayList"%>
<%@page import="Model.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Hotel Management System</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
    %>
    <body onload="checkLogin()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToManagerIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToManagerRoom()" class="active item">
                            ROOMS
                        </a>
                        <a onClick="ToManagerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToManagerAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToManagerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToManagerRegister()" class="item">
                            CREATE AN ACCOUNT
                        </a>
                        <div class="right item">
                            <a onClick="ToManagerAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>
                </div>   
            </div>
        </div>       
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
            <div style="margin-left: 200px; margin-right:200px">
                <table class="ui fixed single line celled table">
                    <thead>
                        <tr><th>Room Name</th>
                            <th>Room Number</th>
                            <th>Room Price</th>
                            <th>Adult Capacity</th>
                            <th>Child Capacity</th>
                            <th>Room description</th> 
                            <th>Room status</th>               
                            <th>Room image</th>
                           
                        </tr>
                    </thead>
                    <%
                        
                        ArrayList<Room> room = (ArrayList<Room>) session.getAttribute("newRoom");                       
                        for (Room r : room) {
                        String png = "/hotelmanagement/Image/" +r.getRoomNum() +".png";
                        System.out.println(png);
                    %> 
                    <tbody>
                        <tr>
                            <td><%=r.getRoomName()%></td>
                            <td><%=r.getRoomNum()%></td>
                            <td><%=r.getRoomPrice()%></td>
                            <td><%=r.getAdultCapacity()%></td>
                            <td><%=r.getChildCapacity()%></td>
                            <td><%=r.getDescription()%></td>
                            <td><%=r.getAvailability()%></td>

                        
                    <td><img src="<%=png%>" width="100" height="100" |/></td>
                    </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
      
        <script>
            function checkLogin() {
                const checkManagerLogin = "" + "<%=checkLogin%>";
                if (checkManagerLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }
            }
        </script>
    </body>
</html>