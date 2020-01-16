package com.laidback.service;

import com.amazonaws.services.s3.model.S3Object;
import com.laidback.exception.FileStorageException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Service
public class FileStorageService {
    private Path fileStorageLocation;

    public String storeFile(MultipartFile file){
        this.fileStorageLocation = Paths.get("./uploads").toAbsolutePath().normalize();
        try{
            Files.createDirectories(this.fileStorageLocation);
        }catch (Exception e){
            throw new FileStorageException("Could not create the directory where the uploaded files will be stored.",e);
        }

        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd_HHmmss", Locale.KOREA );
        Date currentTime = new Date ();
        String mTime = mSimpleDateFormat.format ( currentTime );

        String fileName = mTime + "_" + org.springframework.util.StringUtils.cleanPath(file.getOriginalFilename());

        try{
            if(fileName.contains("..")){
                throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fileName);
            }

            // Copy file to the target location (Replacing existing file with the same name)
            Path targetLocation = this.fileStorageLocation.resolve(fileName);
            Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

            return fileName;
        }catch (IOException e){
            throw new FileStorageException("Could not store file " + fileName + ". Please try again!", e);
        }
    }

    public String storeFile(S3Object s3Object, String fileName){
        this.fileStorageLocation = Paths.get("./temp").toAbsolutePath().normalize();
        try{
            Files.createDirectories(this.fileStorageLocation);
        }catch (Exception e){
            throw new FileStorageException("Could not create the directory where the uploaded files will be stored.",e);
        }

        String fn = org.springframework.util.StringUtils.cleanPath(fileName);

        try{
            if(fn.contains("..")){
                throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fn);
            }

            // Copy file to the target location (Replacing existing file with the same name)
            Path targetLocation = this.fileStorageLocation.resolve(fn);
            Files.copy(s3Object.getObjectContent(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

            return fn;
        }catch (IOException e){
            throw new FileStorageException("Could not store file " + fileName + ". Please try again!", e);
        }
    }
}
