<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Account</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("customerLoginCheck");
        User user = (User) session.getAttribute("user");
    %>
    <body onload="registerCheck()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToCustomerIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToCustomerRoom()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToCustomerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToCustomerAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToCustomerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToMyBooking()" class="item">
                            MY BOOKING
                        </a>
                        <div class="right item">
                            <a onClick="ToCustomerAccount()" class="active ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>   
                </div>
            </div>
            <div style="margin-top: 10px; margin-left: 50px">
                <!-- Site content !-->
                <h1 class="ui header">ACCOUNT</h1>
            </div>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <table id ="example" class="ui large celled striped table">
                <thead>
                    <tr><th>First Name</th>
                        <td><%=user.getFirstName()%></td> 
                    </tr>
                    <tr><th>Last Name</th>
                        <td> <%=user.getLastName()%></td>
                    </tr>
                    <tr><th>Email</th>
                        <td> <%=user.getUsername()%></td>
                    </tr>
                    <tr><th>Password</th>
                        <td> <%=user.getPassword()%></td>
                    </tr>
                </thead>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <!-- Site content !-->
            <button class ="ui blue button" type="submit" onClick="ToEditCustomerDetails()">Edit Details</button>
        </div>
        <script>
            function registerCheck()
            {
                const checkCustomerLogin = "" + "<%=checkLogin%>";
                if (checkCustomerLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }
            }
        </script>
    </body>
</html>
