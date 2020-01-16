package com.laidback.util;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Created by jack on 2018. 7. 3..
 */
public class DateUtil {
    private static String dateFormat = "yyyy-MM-dd";
    public static String date2String(Date date, String format){
        if(StringUtils.isEmpty(format)) format = dateFormat;
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }

    public static Date dateCalc(Date date,int field, int value){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(field,value);
        return c.getTime();
    }

    public static Date string2Date(String date, String format){
        if(StringUtils.isEmpty(format)) format = dateFormat;
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        try {
            return sdf.parse(date);
        } catch (ParseException e) {
            return null;
        }
    }

    public static int date2Int(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String str = sdf.format(date);
        return Integer.parseInt(str);
    }

    public static int weekOfYear(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.WEEK_OF_YEAR);
    }

    public static int year(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.YEAR);
    }

    public static int yearMonth(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return Integer.parseInt(c.get(Calendar.YEAR)+""+StringUtils.leftPad(""+(c.get(Calendar.MONTH)+1),2,"0"));
    }

    public static int dateDiff(String lhs,String rhs){
        try{
            SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
            Date lhsD = sdf.parse(lhs);
            Date rhsD = sdf.parse(rhs);
            long diffInMills = Math.abs(rhsD.getTime() - lhsD.getTime());
            long diff = TimeUnit.DAYS.convert(diffInMills,TimeUnit.MILLISECONDS);
            return (int)diff;
        }catch (Exception e){
            return 0;
        }
    }

    public static int dayOfWeek(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.DAY_OF_WEEK);
    }

    public static int getNextDay(int day){
        if(day == 7) return 1;
        else return ++day;
    }

    public static int getDate(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.DAY_OF_MONTH);
    }

    public static int getMonth(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.MONTH)+1;
    }

    public static int getHour(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.HOUR_OF_DAY);
    }
}
