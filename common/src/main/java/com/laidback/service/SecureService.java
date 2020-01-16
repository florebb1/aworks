package com.laidback.service;

import org.apache.commons.codec.binary.Hex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;

/**
 * Created by jack on 2018. 8. 22..
 */
@Service
public class SecureService {

    private final Logger log = LoggerFactory.getLogger(SecureService.class);

    @Value("${aes.pw}")
    private String aesPw;

    public String encode(String message){
        try{
            byte[] seedB = aesPw.getBytes();
            SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
            sr.setSeed(seedB);
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, sr); // 192 and 256 bits may not be available
            // Generate the secret key specs.
            SecretKey skey = kgen.generateKey();
            String keyString = Hex.encodeHexString(skey.getEncoded());
            SecretKeySpec skeySpec = new SecretKeySpec(skey.getEncoded(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
            byte[] encrypted =  cipher.doFinal(message.getBytes());

            return  Hex.encodeHexString(encrypted);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return null;
        }
    }

    public String decode(String message){
        try{
            byte[] seedB = aesPw.getBytes();
            SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
            sr.setSeed(seedB);

            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, sr); // 192 and 256 bits may not be available

            // Generate the secret key specs.
            SecretKey skey = kgen.generateKey();
            String keyString = Hex.encodeHexString(skey.getEncoded());
            SecretKeySpec skeySpec = new SecretKeySpec(skey.getEncoded(), "AES");

            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            byte[] decrypted =  cipher.doFinal(Hex.decodeHex(message.toCharArray()));
            return new String(decrypted);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return null;
        }
    }
}
