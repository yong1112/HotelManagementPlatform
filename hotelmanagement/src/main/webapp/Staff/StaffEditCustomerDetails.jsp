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
    <%
        String sesh = (String) session.getAttribute("passwordError");
        String usernameCheck = (String) session.getAttribute("UserErr");
        String samePassword = (String) session.getAttribute("PasswordErr");
        Customer cust = (Customer) session.getAttribute("customer");
        String checkLogin = (String) session.getAttribute("staffLoginCheck");
    %>
    <body onload="passwordCheck()">
        <div class="ui middle aligned grid" 
             style="margin-top: 100px; margin-left: 20%; margin-right:20%">
            <div class="column">
                <h1>
                    <div class="content">
                        Edit Details
                    </div>
                </h1>
                <form class="ui form segment" action="/hotelmanagement/L107_ConfirmStaffCustomerChanges" method="post">
                    <div class="two fields">
                        <div class="field">
                            <label>First name</label>
                            <input value="<%=cust.getFirstName()%>" autocomplete="off" required name="firstName" type="text">
                        </div>
                        <div class="field">
                            <label>Last name</label>
                            <input value="<%=cust.getLastName()%>" autocomplete="off" required name="lastName" type="text">
                        </div>
                    </div>
                    <div class="field">
                        <label>Old Email</label>
                        <input value="<%=cust.getUsername()%>" autocomplete="off" required name="oldEmail" type="email" readonly>
                        <p id="existingEmail"></p>
                    </div>
                    <div class="field">
                        <label>Password</label>
                        <input value="<%=cust.getPassword()%>" placeholder="Enter password" autocomplete="off" required name="password" type="password">
                    </div>
                    <div class="field">
                        <label>Confirm password</label>
                        <input placeholder="Re-enter Password" autocomplete="off" required name="confirmPassword" type="password">
                    </div>
                    <div id="differentPassword"><p><p></div>
                    <div class="two fields" style="margin-left: 1px">
                        <button type="submit" class="ui green medium submit button">Confirm Changes</button>
                        <button type="button" onClick="toStaffAccount()" class="ui medium button">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function passwordCheck() {
                var checker = "" + "<%=sesh%>";
                const checkStaffLogin = "" + "<%=checkLogin%>";
                if (checkStaffLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }else  if (checker !== ("null")) {//if password is not the same
                    alert("Password is not the same.");
                }
            }
            ;
        </script>
        <%
            session.removeAttribute("UserErr");
            session.removeAttribute("PasswordErr");
            session.removeAttribute("passwordError");
        %>
    </body>
</html>
