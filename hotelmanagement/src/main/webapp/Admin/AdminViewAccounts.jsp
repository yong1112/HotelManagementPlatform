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
        String adminLoginCheck = (String) session.getAttribute("adminLoginCheck");
        ArrayList<Customer> customer = (ArrayList<Customer>) session.getAttribute("customer");
        ArrayList<Staff> staff = (ArrayList<Staff>) session.getAttribute("staff");
        ArrayList<Staff> manager = (ArrayList<Staff>) session.getAttribute("manager");
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
                        <a onClick="ToAdminRoom()" class="item">
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
                        <a onClick="ToAdminAccountsList()" class="active item">
                            VIEW ACCOUNTS 
                        </a>
                        <a onClick="ToAdminRegister()" class="item">
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
            <form action="/hotelmanagement/L113_AdminCust" method="post">
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
            <form action="/hotelmanagement/L115_AdminListThing" method="post">
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
            <% for (Staff m : manager) {%>
            <form action="/hotelmanagement/L117_AdminMan" method="post">
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <table id ="example" class="ui large celled striped table">
                        <thead>
                            <tr><th>First Name</th>
                                <td><%=m.getFirstName()%></td>
                            </tr>
                            <tr><th>Last Name</th>
                                <td> <%=m.getLastName()%></td>
                            </tr>
                            <tr><th>Email</th>
                                <td> <%=m.getUsername()%></td>
                            </tr>
                            <tr><th>Password</th>
                                <td> <%=m.getPassword()%></td>
                            </tr>
                            <tr><th>Type</th>
                                <td> <%=m.getType()%></td>
                            </tr>
                            <tr><th>Position</th>
                                <td> <%=m.getPosition()%></td>
                            </tr>
                        </thead>
                        </tbody>
                    </table>
                </div>
                <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
                    <!-- Site content !-->
                    <button class ="ui blue button" type="submit" name="boy" value="<%=m.getUsername()%>" >Edit Details</button>
                </div>
            </form>
            <%}%>
        </div> 
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
        </script>
