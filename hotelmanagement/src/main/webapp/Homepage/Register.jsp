<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Register</title>
    </head>
    <%
        String usernameCheck = (String) session.getAttribute("UserErr");
        String samePassword = (String) session.getAttribute("PasswordErr");

    %>
    <body onload="registerCheck()">
        <div class="ui middle aligned grid" 
             style="margin-top: 100px; margin-left: 400px; margin-right:400px">
            <div class="column">
                <h1>
                    <div class="content">
                        Sign Up
                    </div>
                </h1>
                <form class="ui form segment" action="/hotelmanagement/C102_CustomerRegister" method="post">
                    <div class="two fields">
                        <div class="field">
                            <label>First name</label>
                            <input placeholder="First Name" autocomplete="off" required name="firstName" type="text">
                        </div>
                        <div class="field">
                            <label>Last name</label>
                            <input placeholder="Last Name" autocomplete="off" required name="lastName" type="text">
                        </div>
                    </div>
                    <div class="field">
                        <label>Email</label>
                        <input placeholder="example@example.com" autocomplete="off" required name="username" type="email">
                        <p id="existingEmail"></p>      
                    </div>       
                    <div class="field">
                        <label>Password</label>
                        <input placeholder="8-10 characters in length" autocomplete="off" required name="password" type="password">
                    </div>
                    <div class="field">
                        <label>Confirm password</label>
                        <input placeholder="8-10 characters in length" autocomplete="off" required name="confirmPassword" type="password">
                    </div>
                    <div id="differentPassword"><p><p></div>
                    <div class="inline field">
                        <div class="ui left checkbox">
                            <input name="terms" type="checkbox" value="true">
                            <label>I agree to receive latest news and offers</label>
                        </div>
                    </div>
                    <div class="two fields" style="margin-left: 1px">
                        <button type="submit" class="ui green medium submit button">Sign up</button>
                        <button type="button" onClick="window.location.replace('http://localhost:8080/hotelmanagement/')" class="ui medium button">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function registerCheck()
            {
                const emailCheck = "" + "<%=usernameCheck%>";
                const passwordCheck = "" + "<%=samePassword%>";
                if (emailCheck === ("Email already exists in the database")) {
                    alert("Email already exists in the database");
                    location.reload();
                } else if (passwordCheck === ("Password is not the same")) {
                    alert("Password is not the same");
                    location.reload();
                }
            }
        </script>
        <%
            session.removeAttribute("UserErr");
            session.removeAttribute("PasswordErr");
        %>
    </body>
</html>
