<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Log In</title>
    </head>
    <%
        String notFound = (String) session.getAttribute("LoginErr");
    %>
    <body onload="checkUser()">
        <div class="ui middle aligned center aligned grid" 
             style="margin-top: 20%; margin-left: 20%; margin-right:20%">
            <div class="column">
                <h1>
                    <div class="content">
                        Log in to your account
                    </div>
                </h1>
                <form class="ui large form" action="/hotelmanagement/C101_UserLogin" method="post">
                    <div class="ui stacked segment">
                        <div class="field">
                            <div class="ui left icon input">
                                <i class="user icon"></i>
                                <input type="email" autocomplete="off" required name="username" placeholder="E-mail address">
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui left icon input">
                                <i class="lock icon"></i>
                                <input type="password" autocomplete="off" required name="password" placeholder="Password">
                            </div>
                            <div class="two fields" style="margin-top: 15px">
                                <button type="submit" class="ui fluid large blue submit button" style="margin-right: 10px">Log in</button>
                                <button type="button" onClick="window.location.replace('http://localhost:8080/hotelmanagement/')" class="ui fluid large button">Cancel</button>
                            </div>
                            <a href="ForgotPassword.jsp">Forgot Password?</a>
                        </div>
                    </div>
                </form>

                <div class="ui message">
                    Want to be our member? <a onClick="ToRegister()" class="ui medium green button"
                                              style="margin-left: 10px">Sign up now</a>
                </div>

            </div>
        </div>
    </body>
    <script>
        function checkUser() {
            const checkAccount = "" + "<%=notFound%>";
            if (checkAccount === ("Login failed")) {
                alert("Username or Password is incorrect");
                location.reload();
            } else if (checkAccount === ("Reset password succesful")) {
                alert("You have successful reset your password. Please login using your new password.");
                location.reload();
            }
        }
    </script>
</html>
<%
    session.removeAttribute("LoginErr");
%>

