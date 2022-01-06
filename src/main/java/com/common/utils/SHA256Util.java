package com.common.utils;

import java.security.MessageDigest;
import java.util.Random;

public class SHA256Util {

    public static String getSalt() {
        Random random = new Random();
        byte[] salt = new byte[10];

        random.nextBytes(salt);

        StringBuffer sb = new StringBuffer();

        for(int i=0; i<salt.length; i++) {
            sb.append(String.format("%02x", salt[i]));
        }

        return sb.toString();
    }

    public static String SHA256Encrypt(String password, String salt) throws Exception{
        String result = "";
        byte[] bytes = (password+salt).getBytes();

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(bytes);

            byte[] b = md.digest();

            StringBuffer sb = new StringBuffer();

            for(int i=0; i<b.length; i++) {
                sb.append(Integer.toString((b[i] & 0xFF) + 256, 16).substring(1));
            }
            result = sb.toString();
        } catch (Exception e) {
            System.out.println("EncBySHA256 Error:" + e.toString());
        }
        return result;
    }

}

