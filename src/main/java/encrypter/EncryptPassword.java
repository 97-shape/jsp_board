package encrypter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptPassword {
	
	public String encryptPassword(String password) {
		try {
			// 해시(SHA-256)를 통한 암호화
	        MessageDigest md = MessageDigest.getInstance("SHA-256");
	        byte[] hashedBytes = md.digest(password.getBytes());

	        StringBuilder sb = new StringBuilder();
	        for (byte b : hashedBytes) {
	            sb.append(String.format("%02x", b));
	        }
	        return sb.toString();
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

}
