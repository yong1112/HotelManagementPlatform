<%@page import="Model.Staff"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Customer"%>
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
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
        ArrayList<Customer> customer = (ArrayList<Customer>) session.getAttribute("customer");
        ArrayList<Staff> staff = (ArrayList<Staff>) session.getAttribute("staff");
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
                        <a onClick="ToManagerAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToManagerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToManagerBooking()" class="item">
                            VIEW BOOKINGS
                        </a>
                        <a onClick="ToManagerViewAccounts()" class="active item">
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
            <div style="margin-top: 10px; margin-left: 50px">
                <!-- Site content !-->
                <h1 class="ui header">ACCOUNT</h1>
            </div>
            <% for (Customer customers : customer) {%>
            <form action="/hotelmanagement/L109_ManagerCust" method="post">
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <table id ="example" class="ui large celled striped table">
                        <thead>
                            <tr><th>First Name</th>
                                <td><%=customers.getFirstName()%></td>
                            </tr>
                            <tr><th>Last Name</th>
                                <td> <%=customers.getLastName()%></td>
                            </tr>
                            <tr><th>Email</th>
                                <td> <%=customers.getUsername()%></td>
                            </tr>
                            <tr><th>Password</th>
                                <td> <%=customers.getPassword()%></td>
                            </tr>
                            <tr><th>Type</th>
                                <td> <%=customers.getType()%></td>
                            </tr>
                        </thead>
                        </tbody>
                    </table>
                </div>
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <!-- Site content !-->
                    <button class ="ui blue button" type="submit" name="butt" value="<%=customers.getUsername()%>" >Edit Details</button>
                </div>
            </form>
            <%}%>
            <% for (Staff s : staff) {%>
            <form action="/hotelmanagement/L108_ManagerListThing" method="post">
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <table id ="example" class="ui large celled striped table">
                        <thead>
                            <tr><th>First Name</th>
                                <td><%=s.getFirstName()%></td>
                            </tr>
                            <tr><th>Last Name</th>
                                <td> <%=s.getLastName()%></td>
                            </tr>
                            <tr><th>Email</th>
                                <td> <%=s.getUsername()%></td>
                            </tr>
                            <tr><th>Password</th>
                                <td> <%=s.getPassword()%></td>
                            </tr>
                            <tr><th>Type</th>
                                <td> <%=s.getType()%></td>
                            </tr>
                            <tr><th>Position</th>
                                <td> <%=s.getPosition()%></td>
                            </tr>
                        </thead>
                        </tbody>
                    </table>
                </div>
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <!-- Site content !-->
                    <button class ="ui blue button" type="submit" name="btn" value="<%=s.getUsername()%>" >Edit Details</button>
                </div>
            </form>
            <%}%>
        </div> 
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/dataTables.semanticui.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" ></script>
<script>
                                function checkLogin() {
                                    const checkStaffLogin = "" + "<%=checkLogin%>";
                                    if (checkStaffLogin === ("null")) {
                                        setTimeout(() => {
                                            ;
                                        }, 0);
                                        window.location.href = "http://localhost:8080/hotelmanagement/";
                                    }
                                }
</script>
