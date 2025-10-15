package com.greensense.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordGenerator {

    public static void main(String[] args) {
        // --- STEP 1: Enter your desired password here ---
        String myPassword = "citizen123";

        // --- STEP 2: The code below will generate the hash ---
        String hashedPassword = BCrypt.hashpw(myPassword, BCrypt.gensalt());

        System.out.println("Your new hashed password is:");
        System.out.println(hashedPassword);
    }
}