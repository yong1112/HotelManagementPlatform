/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Room;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author leeki
 */
@WebServlet(name = "C201_CreateRoom", urlPatterns = {"/C201_CreateRoom"})
public class C201_CreateRoom extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");
        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String roomName = request.getParameter("roomName");
        String roomNum = request.getParameter("roomNum");
        String roomPrice = request.getParameter("roomPrice");
        String adultCapacity = request.getParameter("adultCapacity");
        String childCapacity = request.getParameter("childCapacity");
        String description = request.getParameter("description");
        String availability = request.getParameter("availability");
        String roomImage = request.getParameter("roomImage");
        System.out.println(roomNum);
        boolean checkRoomExist = db.isRoomIdExist(roomNum);

        if (checkRoomExist) {
            session.setAttribute("roomIdExist", "Room_id already exist in the database");
            response.sendRedirect("/hotelmanagement/Manager/CreateRoom.jsp");
        } else {

            //File name
            String Extension = ".png";
            File file;

            //Limit File size
            int MB = 1024 * 1024;
            int maxFileSize = 100 * MB;
            int maxMemSize = 100 * MB;
            String filePath = getServletContext().getRealPath("/") + "..\\..\\src\\main\\webapp\\Image\\";
            //String filePath = context.getInitParameter("file-upload");
            String contentType = request.getContentType();
            //LinkedList to store the data
            LinkedList<String> Parameter = new LinkedList();
            //If contains multipart
            if ((contentType.contains("multipart/form-data"))) {
                //then save in the local memory
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File(filePath));
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);

                try {
                    // Get the file that just uploaded from the user
                    List fileItems = upload.parseRequest(request);
                    System.out.println("File items " + fileItems);
                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    //This one just in case the user upload multiple images
                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (fi.isFormField()) {
                            //Get the room name, you can see from the output
                            Parameter.add(fi.getString().trim().toUpperCase());
                            System.out.println("Parameters " + Parameter);
                        } else if (!fi.isFormField()) {
                            // Get the uploaded file parameters
                            // Write the file
                            file = new File(filePath
                                    + Extension.substring(Extension.lastIndexOf("\\") + 1));
                            System.out.println("File " + file);
                            fi.write(file);
                        }
                    }
                    //inputImagePath will look like this /webapp/image/.jpg
                    String inputImagePath = filePath + Extension;
                    //outputImagePath will look like this /webapp/image/imagesName.jsp
                    String outputImagePath = filePath + Parameter.get(1) + Extension;
                    int scaleWidth = 500;
                    int scaleHeight = 500;

                    //Make the  new size of images
                    File inputFile = new File(inputImagePath);
                    BufferedImage inputImage = ImageIO.read(inputFile);
                    BufferedImage outputImage = new BufferedImage(scaleWidth,
                            scaleHeight, inputImage.getType());

                    Graphics2D g2d = outputImage.createGraphics();
                    g2d.drawImage(inputImage, 0, 0, scaleWidth, scaleHeight, null);
                    g2d.dispose();

                    String formatName = outputImagePath.substring(outputImagePath
                            .lastIndexOf(".") + 1);

                    // writes the file
                    ImageIO.write(outputImage, formatName, new File(outputImagePath));

                } catch (Exception ex) {
                    System.out.println(ex);
                }
                Room room = new Room(Parameter.get(0), Parameter.get(1), Parameter.get(2),
                        Parameter.get(3), Parameter.get(4), Parameter.get(5), Parameter.get(6));
                db.createRoom(room);
                response.sendRedirect("C202_RoomList");
            }

        }
    }
    
    public ArrayList<String> createRoomTest(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity, String availability) {
        ArrayList<String> roomList = new ArrayList<>();
        roomList.add(roomName);
        roomList.add(roomNum);
        roomList.add(roomPrice);
        roomList.add(adultCapacity);
        roomList.add(childCapacity);
        roomList.add(availability);
        
        return roomList;
    }
}