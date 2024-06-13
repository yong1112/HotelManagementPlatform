# Hotel Management Team
The Hotel Management Project is a web-based hotel booking application that allows customers to make reservations at the "Hotel", as well as Admin, Manager and staff to be able to regulate and oversee its operations.

## Structure:
1. **src -> main -> webapp**
Webapp: contains all customer, staff, manager and admin user interfaces using jsp file. 
2. **src -> main -> java -> Controller**
Controller: contains all the operation between front-end and database. It is where logic and data process located.
3. **src -> main -> java -> DAO**
**MongoDB:** initialise database name, username and password for the database.
**MongoDBConnector:** connects the application to the MongoDB database.
**MongoDBManager:** contains all the queries to save, retreive and manipulate data to/form the database.
   
4. **src -> main -> java -> Model**
Model: contains all the model classes to be inherited throughout the project such as room, user, customer, staff, booking models. There are also get and           set methods to retreive and update the data.

## Contribution:
### Sorakrit Wisawapakorn 13754306 (Team Leader)
- URL protection which located all over jsp files using javascript with get and set sessions.
- Error Alert which also located on register.jsp, login.jsp, creatroom.jsp and controllers. Controllers will set a session when user inputs an unexpected data, it will set a session and will be retreieved getsession on jsp to display error messages.
- Booking is in homepage/room.jsp, customerRoom.jsp, 01_RoomavaiabilityCheck, C302_DisplayConfirmation and C303_ConfirmBooking.
      
### Kimgech Pov 13462294 (M4)
- Managers can create room and upload room image (CreateRoom.jsp & C201_CreateRoom.java).
- After create room, the managers can view all room details plus image in RoomList.jsp (C202_RoomList.java).
- Managers can edit room details (EditRoomDetails.jsp & C205_EditRoom.java).
- Managers can delete room (ManagerRoom.jsp & C203_DeleteRoom.java).

### Chang-Song Wang
- Staff, Manager and Admin users are able to book on behalf of customer using the customer's email.
- Customer email is a mandatory field and has been added to the 'ROOMS' tab of each respective user.
- Availability function reuses code fomr 01_RoomavaiabilityCheck, C302_DisplayConfirmation and C303_ConfirmBooking, through if and else statements. 
- Customer emails do not have to exist in the system for staff(s) to be able to book on behalf of the customer, this allows for 'anonymous' or 'non-registered' customers. 

### O'Neil Rangiuira 13780770
- Customers can sign up & login to website.
- Managers and Admins can create new user accounts.
- Forgotten passwords can be reset via the user's email with generated token authentication to secure user accounts.
- Save user passwords using SHA-256 encryption.

### Norinpiseth Ban 13150946
- Design a simple homepage with interactive menu and buttons for all users which can be found in all users' index JSP file (index.jsp, CustomerIndex.jsp, StaffIndex.jsp, ManagerIndex.jsp & AdminIndex.jsp)
- Design the front end for login feature (Login.jsp)
- Design the front end for sign up feature (Register.jsp)
- Customer can cancel their booking (CancelMyBooking.jsp & C402_CancelMyBooking controller)
- Customer can view their current and previous booking in a booking history page (MyBooking.jsp & C401_MyBooking controller)
- Staff can view all bookings in a table (StaffBooking.jsp)
- Staff can edit booking check-in and check-out dates upon customer's request (ChooseEditBooking.jsp, EditBooking.jsp, C404_ChooseEditBooking controller and C405_EditBooking controller)
- Staff can delete booking upon customer's request (CancelBooking.jsp & C403_StaffCancelBooking controller)
- Manager can view all bookings in a table (ManagerBooking.jsp)
