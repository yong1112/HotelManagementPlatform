/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author oneilrangiuira
 */
public class PasswordEncryption {
    // Adds extra security to the current password
    final String salt = "HotelWebsite";
    
    // Uses SHA-256 algorithm for one-way hashing which cannot be decrypted
    public String getHash(String password) {
        String hash = "";
        try {
            hash = toHexString(getSHA(password + salt));
        } catch (NoSuchAlgorithmException e) {
            Logger.getLogger(PasswordEncryption.class.getName()).log(Level.SEVERE, null, e);
        }
        return hash;
    }
    
    // Converts String to Bytes which will get hashed by SHA-256 algorithm
    private static byte[] getSHA(String encryptedPassword) throws NoSuchAlgorithmException {
        return MessageDigest.getInstance("SHA-256").digest(encryptedPassword.getBytes(StandardCharsets.UTF_8));
    }
    
    // Converts Bytes to Hexadecimal String
    private static String toHexString(byte [] hash) {
        StringBuilder sb = new StringBuilder(new BigInteger(1, hash).toString(16));
        
        while (sb.length() < 32) {
            sb.insert(0, "0");
        }
        
        return sb.toString();
    }
}
