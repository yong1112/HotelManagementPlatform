/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author sorak
 */
public class Booking {

    private String bookingID;
    private String roomId;
    private String roomPrice;
    private String startDate;
    private String endDate;
    private String totalStay;
    private String totalPrice;
    private String bookedFor;

    //request extra items & services
    private int pillow = 0;
    private int blanket = 0;
    private int slippers = 0;
    private int towel = 0;
    private String others;

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }
    private boolean pickUpService = false;

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public int getPillow() {
        return pillow;
    }

    public void setPillow(int pillow) {
        this.pillow = pillow;
    }

    public int getBlanket() {
        return blanket;
    }

    public void setBlanket(int blanket) {
        this.blanket = blanket;
    }

    public int getSlippers() {
        return slippers;
    }

    public void setSlippers(int slippers) {
        this.slippers = slippers;
    }

    public int getTowel() {
        return towel;
    }

    public void setTowel(int towel) {
        this.towel = towel;
    }

    public boolean isPickUpService() {
        return true;
    }

    public void setPickUpService(boolean pickUpService) {
        this.pickUpService = pickUpService;
    }

    public Booking(String bookingID, String roomId, String roomPrice, String startDate, String endDate, String totalStay, String totalPrice, String bookedFor, int pillow, int blanket, int slippers, int towel, String others, boolean pickUpService) {
        this.bookingID = bookingID;
        this.roomId = roomId;
        this.roomPrice = roomPrice;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalStay = totalStay;
        this.totalPrice = totalPrice;
        this.bookedFor = bookedFor;
        this.pillow = pillow;
        this.blanket = blanket;
        this.slippers = slippers;
        this.towel = towel;
        this.others = others;
        this.pickUpService = pickUpService;
    }

    public Booking(String bookingID, int pillow, int blanket, int slippers, int towel, String others, boolean pickUpService) {
        this.bookingID = bookingID;
        this.pillow = pillow;
        this.blanket = blanket;
        this.slippers = slippers;
        this.towel = towel;
        this.others = others;
        this.pickUpService = pickUpService;
    }
    public Booking(String bookingID, String roomId, String roomPrice, String startDate, String endDate, String totalStay, String totalPrice, String bookedFor) {
        this.bookingID = bookingID;
        this.roomId = roomId;
        this.roomPrice = roomPrice;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalStay = totalStay;
        this.totalPrice = totalPrice;
        this.bookedFor = bookedFor;
    }

    public String getBookingId() {
        return bookingID;
    }

    public void setBookingId(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(String roomPrice) {
        this.roomPrice = roomPrice;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getTotalStay() {
        return totalStay;
    }

    public void setTotalStay(String totalStay) {
        this.totalStay = totalStay;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBookedFor() {
        return bookedFor;
    }

    public void setBookedFor(String bookedFor) {
        this.bookedFor = bookedFor;
    }
}
