<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>About Us</title>
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
                        <a onClick="ToManagerRoom()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToManagerRoomManage()" class="item">
                            ROOM MANAGEMENT
                        </a>
                        <a onClick="ToManagerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToManagerAbout()" class="active item">
                            ABOUT US
                        </a>
                        <a onClick="ToManagerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToManagerBooking()" class="item">
                            VIEW BOOKINGS
                        </a>
                        <a onClick="ToManagerAccountsList()" class="item">
                            VIEW ACCOUNTS
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
        <div style="margin-top: 10px; margin-left: 50px">
            <!-- Site content !-->
            <h1 class="ui header">ABOUT US</h1>
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
</html>
