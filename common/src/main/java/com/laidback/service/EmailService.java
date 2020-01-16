package com.laidback.service;

import com.laidback.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.Message.RecipientType;
import javax.mail.internet.*;
import java.io.File;
import java.util.Properties;


/**
 * Created by jack on 2018. 7. 30..
 */
@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailService;

    @Autowired
    private FileStorageService fileStorageService;


    @Async
    public void sendmail(String from, String title, String content, String to, String bcc,String file) throws Exception{


        MimeMessage message = javaMailService.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        String charset = "UTF-8";
        try {

            message.setSubject(title);
            message.setFrom(new InternetAddress(from, from));
            message.addRecipient(RecipientType.TO, new InternetAddress(to));
            if(bcc != null) message.addRecipient(RecipientType.BCC,new InternetAddress(bcc));

//            messageBodyPart.setText()
//            if(file != null){
//                FileSystemResource file2 = new FileSystemResource(file);
////
//                helper.addAttachment(file2.getFilename(),file2);
////                helper.addAttachment(file2.getFilename(), new ClassPathResource(file2));
//
//            }
//            messageBodyPart.setText(content);

            if(file != null) {
                BodyPart messageBodyPart = new MimeBodyPart();
                ((MimeBodyPart) messageBodyPart).setText(content,charset,"html");
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);

                messageBodyPart = new MimeBodyPart();
                String filename = file;
                DataSource source = new FileDataSource("./uploads/"+filename);
                messageBodyPart.setDataHandler(new DataHandler(source));
                messageBodyPart.setFileName(MimeUtility.encodeText(filename,charset,"B"));
                multipart.addBodyPart(messageBodyPart);
                message.setContent(multipart);
            }else{
                message.setText(content, charset, "html");
            }

            javaMailService.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
