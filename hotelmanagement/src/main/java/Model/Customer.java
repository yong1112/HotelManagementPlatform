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
public class Customer extends User{
    
    boolean promotion;

    public Customer(String firstName, String lastName, String username, String password, boolean promotion) {
        super(firstName, lastName, username, password);
        this.promotion = promotion;
    }

    public Customer( String firstName, String lastName, String username, String password, String type, boolean promotion, boolean active) {
        super(firstName, lastName, username, password, type, active);
        this.promotion = promotion;
    }

    public boolean isPromotion() {
        return promotion;
    }

    public void setPromotion(boolean promotion) {
        this.promotion = promotion;
    }
    
}
