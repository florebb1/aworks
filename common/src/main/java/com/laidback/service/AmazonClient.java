package com.laidback.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;
//import com.amazonaws.services.s3.model.*;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.*;
import java.net.URLConnection;
import java.util.Date;
import java.util.UUID;

@Service
public class AmazonClient {

    private AmazonS3 s3client;

    private final Logger log = LoggerFactory.getLogger(AmazonClient.class);

    @Value("${amazonProperties.endpointUrl}")
    private String endpointUrl;
    @Value("${amazonProperties.bucketName}")
    private String bucketName;
    @Value("${amazonProperties.accessKey}")
    private String accessKey;
    @Value("${amazonProperties.secretKey}")
    private String secretKey;

    @PostConstruct
    private void initializeAmazon() {

        try {
            this.s3client = AmazonS3ClientBuilder.defaultClient();
        }catch(Exception e){
            AWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);
            this.s3client = new AmazonS3Client(credentials);
        }
//        this.s3client = AmazonS3ClientBuilder.defaultClient();
    }

    public String uploadFile(MultipartFile multipartFile) {
        String fileUrl = "";
        try {
            File file = convertMultiPartToFile(multipartFile);
            String fileName = generateFileName(file);
            fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            uploadFileTos3bucket(fileName, file);
            file.delete();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return fileUrl;
    }


    public String uploadOriginalFile(MultipartFile multipartFile, String originalFilename) {
        String fileUrl = "";
        try {
            File file = convertMultiPartToFile(multipartFile);
            String fileName = originalFilename;
            fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            uploadFileTos3bucket(fileName, file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileUrl;
    }


    public String uploadFile(File file) {
        String fileUrl = "";
        try {
            String fileName = generateFileName(file);
            fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            uploadFileTos3bucket(fileName, file);
            file.delete();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return fileUrl;
    }

    public String uploadFileBase64(String str){
        String fileUrl = "";
        try {
            byte[] bI = org.apache.commons.codec.binary.Base64.decodeBase64((str.substring(str.indexOf(",") + 1)).getBytes());

            String contentType = URLConnection.guessContentTypeFromStream(new ByteArrayInputStream(bI));

            InputStream fis = new ByteArrayInputStream(bI);
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(bI.length);
            String fileName = "";
            if(contentType.equals("image/jpeg")){
                fileName = new Date().getTime() + "-" + UUID.randomUUID()+".jpg";
                fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            }else if(contentType.equals("image/gif")){
                fileName = new Date().getTime() + "-" + UUID.randomUUID()+".gif";
                fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            }else if(contentType.equals("image/png")){
                fileName = new Date().getTime() + "-" + UUID.randomUUID()+".png";
                fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            }
            metadata.setContentType(contentType);
            metadata.setCacheControl("public, max-age=31536000");
            s3client.putObject(new PutObjectRequest(bucketName, fileName, fis, metadata)
                    .withCannedAcl(CannedAccessControlList.PublicRead));
        }catch (Exception e) {
            e.printStackTrace();
        }
        return fileUrl;
//        s3client.putObject(bucketName, filename, fis, metadata);
//        s3.setObjectAcl(BUCKET_NAME, filename, CannedAccessControlList.PublicRead);
    }
    public String uploadFileAndDelete(File file, File deleteFile) {
        String fileUrl = "";
        try {
            String fileName = generateFileName(file);
            fileUrl = endpointUrl + "/" + bucketName + "/" + fileName;
            uploadFileTos3bucket(fileName, file);
            file.delete();

            deleteFile.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileUrl;
    }

    private File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }

    private String generateFileName(File file) {
        return new Date().getTime() + "-" + UUID.randomUUID()+"."+ FilenameUtils.getExtension(file.getPath());
    }

    private void uploadFileTos3bucket(String fileName, File file) {
        System.out.println(fileName);
        s3client.putObject(new PutObjectRequest(bucketName, fileName, file)
                .withCannedAcl(CannedAccessControlList.PublicRead));
//        try {
////            s3client.putObject(bucketName, fileName, file);
//            s3client.putObject(new PutObjectRequest(bucketName, fileName, file));
//        } catch (AmazonServiceException e) {
//            System.err.println(e.getErrorMessage());
//            System.exit(1);
//        }
    }

    public boolean deleteFileFromS3Bucket(String fileUrl) {
        try{
            String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            s3client.deleteObject(new DeleteObjectRequest(bucketName, fileName));
            return true;
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return false;
        }
    }

    @Async
    public void deleteFileFromS3BucketAsync(String fileUrl) {
        try{

            String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            s3client.deleteObject(new DeleteObjectRequest(bucketName, fileName));
        }catch (Exception e){
            log.error(e.getMessage(),e);
        }
    }

    public S3Object downloadFile(String fileUrl){
        try{
            String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            return s3client.getObject(new GetObjectRequest(bucketName,fileName));
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return null;
        }
    }

}
