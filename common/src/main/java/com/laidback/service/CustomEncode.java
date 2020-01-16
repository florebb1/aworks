package com.laidback.service;

import org.springframework.stereotype.Service;

@Service
public class CustomEncode {
    public Object stringChange(char str){
        String str2 = Character.toString(str);

        switch(str2){
            case "a":
                str = "c".charAt(0);
                break;
            case "b":
                str = "f".charAt(0);
                break;
            case "c":
                str = "e".charAt(0);
                break;
            case "d":
                str = "h".charAt(0);
                break;
            case "e":
                str = "g".charAt(0);
                break;
            case "f":
                str = "j".charAt(0);
                break;
            case "0":
                str = "2".charAt(0);
                break;
            case "1":
                str = "5".charAt(0);
                break;
            case "2":
                str = "4".charAt(0);
                break;
            case "3":
                str = "7".charAt(0);
                break;
            case "4":
                str = "6".charAt(0);
                break;
            case "5":
                str = "9".charAt(0);
                break;
            case "6":
                str = "8".charAt(0);
                break;
            case "7":
                str = "1".charAt(0);
                break;
            case "8":
                str = "0".charAt(0);
                break;
            case "9":
                str = "3".charAt(0);
                break;
            default:
                break;
        }
//        if(str2 == "y"){
//            str = "a".charAt(0);
//        }else if(str2 == "z"){
//            str = "b".charAt(0);
//        }else if(str2 == "8"){
//            str = "0".charAt(0);
//        }else if(str2 == "9"){
//            str = "1".charAt(0);
//        }else{
//            str = ++str;
//            str = ++str;
//        }
        return str;
    }


    public Object numberChange(char str) {
        String str2 = Character.toString(str);
        switch(str2){
            case "0":
                str = "d".charAt(0);
                break;
            case "1":
                str = "1".charAt(0);
                break;
            case "2":
                str = "f".charAt(0);
                break;
            case "3":
                str = "g".charAt(0);
                break;
            case "4":
                str = "4".charAt(0);
                break;
            case "5":
                str = "i".charAt(0);
                break;
            case "6":
                str = "j".charAt(0);
                break;
            case "7":
                str = "7".charAt(0);
                break;
            case "8":
                str = "l".charAt(0);
                break;
            case "9":
                str = "m".charAt(0);
                break;
            default:
                break;
        }
        return str;
    }

    public Integer getAscii(char str){
        Integer num = (int) str;
        return num;
    }
}
