/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author leeki
 */
public class Room {

    private String roomName;
    private String roomNum;
    private String roomPrice;
    private String adultCapacity;
    private String childCapacity;
    private String availability;
    private String description;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    private String roomImage;

    public Room(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity, String description) {
        this.roomName = roomName;
        this.roomNum = roomNum;
        this.roomPrice = roomPrice;
        this.adultCapacity = adultCapacity;
        this.childCapacity = childCapacity;
        this.description = description;

    }

    public Room(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity, String description, String availability, String roomImage) {
        this.roomName = roomName;
        this.roomNum = roomNum;
        this.roomPrice = roomPrice;
        this.adultCapacity = adultCapacity;
        this.childCapacity = childCapacity;
        this.description = description;
        this.availability = availability;
        this.roomImage = roomImage;
    }

    public Room(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity, String description, String availability) {
        this.roomName = roomName;
        this.roomNum = roomNum;
        this.roomPrice = roomPrice;
        this.adultCapacity = adultCapacity;
        this.childCapacity = childCapacity;
        this.description = description;
        this.availability = availability;
        
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomNum() {
        return roomNum;
    }

    public void setRoomNum(String roomNum) {
        this.roomNum = roomNum;
    }

    public String getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(String roomPrice) {
        this.roomPrice = roomPrice;
    }

    public String getAdultCapacity() {
        return adultCapacity;
    }

    public String getChildCapacity() {
        return childCapacity;
    }

    public void setChildCapacity(String childCapacity) {
        this.childCapacity = childCapacity;
    }

    public void setAdultCapacity(String adultCapacity) {
        this.adultCapacity = adultCapacity;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    public String getRoomImage() {
        return roomImage;
    }

    public void setRoomImage(String roomImage) {
        this.roomImage = roomImage;
    }
}