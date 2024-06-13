/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author oneilrangiuira
 */
public class Staff extends User{
    private String position;

    public Staff(String firstName, String lastName, String username, String password, String position) {
        super(firstName, lastName, username, password);
        this.position = position;
    }

    public Staff(String firstName, String lastName, String username, String password, String type, String position, boolean active) {
        super(firstName, lastName, username, password, type, active);
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
    
}
