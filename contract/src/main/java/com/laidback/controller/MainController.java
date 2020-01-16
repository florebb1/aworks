package com.laidback.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.laidback.Entity.License;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
//>>>>>>> 6cd92181b78a63eea6f62a9a2b848deab6199091
import com.laidback.util.EncryptUtil;
import jdk.nashorn.internal.parser.JSONParser;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.laidback.util.DateUtil;
import com.laidback.util.JwtUtil;
import org.apache.commons.lang3.StringUtils;


//import javax.servlet.http.HttpServletRequest;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


@RestController
public class MainController extends RootController {
    @Autowired
    UserMapper userMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RepositoryMapper repositoryMapper;

    @Autowired
    BbsNoticeMapper bbsNoticeMapper;

    @Autowired
    RepositoryRecommMapper repositoryRecommMapper;

    @Autowired
    FnqRepository fnqRepository;

    @Autowired
    FaqMapper faqMapper;

    @Autowired
    TrialLicenseMapper trialLicenseMapper;

    @Autowired
    VersionManageMapper versionManageMapper;

    @Autowired
    BbsNewsroomRepository bbsNewsroomRepository;

    @Autowired
    BbsNewsroomMapper bbsNewsroomMapper;

    @Autowired
    ReleaseNoteMapper releaseNoteMapper;

    protected EncryptUtil encryptUtil;

    // 메인
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView main(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));

//        ObjectMapper oMapper = new ObjectMapper();
//        Object obj = super.getSessionUser(httpServletRequest);
//        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
//        System.out.println(map.get("s_seq"));

        Map<String, Object> params = new HashMap<>();
        params.put("displayYn",0);
        params.put("sort", "create_datetime");
        params.put("order", 1);
        params.put("offset", 0);
        params.put("count", 3);


        List<BbsNewsroom> results = bbsNewsroomMapper.find(params);
        mav.addObject("newsroom",results);
        mav.setViewName("main");
        return mav;
    }
//    @RequestMapping(value = "/test", method = RequestMethod.GET)
//    public ModelAndView test(ModelAndView mav){
//        mav.setViewName("test");
//        return mav;
//    }

    // 서브1
    @RequestMapping(value = "/rpa", method = RequestMethod.GET)
    public ModelAndView sub1(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/rpa");
        return mav;
    }

    // 서브1
    @RequestMapping(value = "/applied", method = RequestMethod.GET)
    public ModelAndView applied(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/applied");
        return mav;
    }

    // 서브1
    @RequestMapping(value = "/grafting", method = RequestMethod.GET)
    public ModelAndView grafting(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/grafting");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/features", method = RequestMethod.GET)
    public ModelAndView sub2(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/features");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/platform", method = RequestMethod.GET)
    public ModelAndView sub3(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/platform");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/studio", method = RequestMethod.GET)
    public ModelAndView sub4(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/studio");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/robot", method = RequestMethod.GET)
    public ModelAndView sub5(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/robot");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/work_center", method = RequestMethod.GET)
    public ModelAndView sub6(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/work_center");
        return mav;
    }
    // 서브2
    @RequestMapping(value = "/repository", method = RequestMethod.GET)
    public ModelAndView sub7(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/repository");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/solution", method = RequestMethod.GET)
    public ModelAndView sub8(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/solution");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/manual", method = RequestMethod.GET)
    public ModelAndView sub9(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/manual");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/cloud_manual", method = RequestMethod.GET)
    public ModelAndView sub10(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/cloud_manual");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/on_premise_manual", method = RequestMethod.GET)
    public ModelAndView sub10_1(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/on_premise_manual");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/contract", method = RequestMethod.GET)
    public ModelAndView sub11(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/contract");
        return mav;
    }
    // 서브2
    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public ModelAndView sub12(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/about");
        return mav;
    }
    // 서브2
    @RequestMapping(value = "/partner", method = RequestMethod.GET)
    public ModelAndView sub13(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/partner");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/education", method = RequestMethod.GET)
    public ModelAndView education(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/education");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/faq", method = RequestMethod.GET)
    public ModelAndView sub14(
            @RequestParam(value = "filter", defaultValue = "0") Integer filter
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        Map<String, Object> params = new HashMap<>();
        params.put("filter", filter);
        int faqCount = faqMapper.count(params);
        if(faqCount > 0) {
            List<Faq> faq = faqMapper.find(params);
            mav.addObject("faqCount", faqCount);
            mav.addObject("filter", filter);
            mav.addObject("faq", faq);
        }else {
            mav.addObject("faqCount", faqCount);
            mav.addObject("filter", filter);
        }
        mav.setViewName("info/faq");
        return mav;
    }
    // 서브2
    @RequestMapping(value = "/qna", method = RequestMethod.GET)
    public ModelAndView sub15(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
//        if(qnaType != null){
//            mav.addObject("qnaType",qnaType);
//        }else{
//            mav.addObject("qnaType",0);
//        }
        mav.setViewName("info/qna");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public ModelAndView sub16(ModelAndView mav,HttpServletRequest httpServletRequest) {
        // 현재날짜 + 30일
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cl = new GregorianCalendar(Locale.KOREA);
        Date date = new Date();
        cl.setTime(date);
        String now = sdf.format(cl.getTime());
        cl.add(cl.DATE, 60);
        String dt = sdf.format(cl.getTime());
        Map<String, Object> params32 = new HashMap<>();
        params32.put("bit", 0);
        params32.put("version", 2);
        Map<String, Object> params64 = new HashMap<>();
        params64.put("bit", 1);
        params64.put("version", 2);
        int vm32Count = versionManageMapper.get32Count(params32);
        if(vm32Count > 0) {
            VersionManage vm32 = versionManageMapper.get32(params32);
            mav.addObject("file32Path", vm32.getFilePath());
        }

        int vm64Count = versionManageMapper.get64Count(params64);
        if(vm64Count > 0) {
            VersionManage vm64 = versionManageMapper.get64(params64);
            mav.addObject("file64Path", vm64.getFilePath());
        }
        mav.addObject("trialDate", dt);
        mav.setViewName("info/download");
        return mav;
    }

    // 이용약관
    @RequestMapping(value = "/terms", method = RequestMethod.GET)
    public ModelAndView sub17(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/terms");
        return mav;
    }

    // 개인정보처리방침
    @RequestMapping(value = "/privacy", method = RequestMethod.GET)
    public ModelAndView sub18(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/privacy");
        return mav;
    }

    // 서브2
    @RequestMapping(value = "/contactus", method = RequestMethod.GET)
    public ModelAndView contactus(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/contactus");
        return mav;
    }

    // 뉴스룸 리스트
    @RequestMapping(value = "/news_list", method = RequestMethod.GET)
    public ModelAndView newslist(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("news/list");
        return mav;
    }

    // 뉴스룸 상세
    @RequestMapping(value = "/news_view", method = RequestMethod.GET)
    public ModelAndView newsview(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
            ,@RequestParam(value="newsroomId") Integer newsroomId
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("news/view");

        BbsNewsroom bbsNewsroom = bbsNewsroomRepository.findOne(newsroomId);
        mav.addObject("bbs_info",bbsNewsroom);
        return mav;
    }

    // 릴리즈 노트
    @RequestMapping(value = "/release_note", method = RequestMethod.GET)
    public ModelAndView releasenote(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        List<ReleaseNote> releaseNotes1 = releaseNoteMapper.typeFind(1);
        List<ReleaseNote> releaseNotes2 = releaseNoteMapper.typeFind(2);
        List<ReleaseNote> releaseNotes3 = releaseNoteMapper.typeFind(3);
        mav.addObject("releaseNotes1", releaseNotes1);
        mav.addObject("releaseNotes2", releaseNotes2);
        mav.addObject("releaseNotes3", releaseNotes3);
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("info/release_note");
        return mav;
    }
    private String mpublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApQSiLRuYY1EY08ZhsB7VX6UZ5fSWYtM98Vb4C0tCKbFoGS9CafLADp75suEhKBk6h+9MpfX2D/DiZNCOZ4tTy8d/FqdEvaGwBaih74xMhnzhhUu7y3bEiJUyRHN9tT+ftRdOiGvCZ+ORH7DaRa6vAaYHgNCYedVUsOpIhf0xNwgud45ab4acIBM7azWPECjP8AmympDCv2KdVyD5AZ410bVM5papEL+g5s6MUaswKrjLzuxm0WhdbsmU7KgemtOJhOYItUL7fx4UPntBeNuMyB880zBq/UlS8N1F8WA/OK5OhxNPmLv4xNVrukdiR20lMUw4FpYduKHRAgdItwIMyQIDAQAB";
    private String mprivateKey = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClBKItG5hjURjTxmGwHtVfpRnl9JZi0z3xVvgLS0IpsWgZL0Jp8sAOnvmy4SEoGTqH70yl9fYP8OJk0I5ni1PLx38Wp0S9obAFqKHvjEyGfOGFS7vLdsSIlTJEc321P5+1F06Ia8Jn45EfsNpFrq8BpgeA0Jh51VSw6kiF/TE3CC53jlpvhpwgEztrNY8QKM/wCbKakMK/Yp1XIPkBnjXRtUzmlqkQv6DmzoxRqzAquMvO7GbRaF1uyZTsqB6a04mE5gi1Qvt/HhQ+e0F424zIHzzTMGr9SVLw3UXxYD84rk6HE0+Yu/jE1Wu6R2JHbSUxTDgWlh24odECB0i3AgzJAgMBAAECggEACz9kmnR+D47whUbJU8rWOl2zhTQFqBjD6RZHc+WeTd80vDq3aSdNpfF6DZJAw03s6mUKMWmxaua9V6fLfQ1HGeWwKOgfzFkf+VLELuK+OJB8gqxl0Xl37eNVeMryb481oI9FIBFQP+qH8sQILKW6cf9SFZqiOfOrgR+G7/MRDrIYvaxv8VI0EGm6JmXL16HoXNVq3WGZFveYSq0X2IzQeLa56IOPt+dXpkeUnK1LW6+3qztueZFubh0X5+HcLZmFsYJJplXeFY4WTp6Ye6uqgL57vq5OB/VlGW5R4BiujUsi70ouMmpHcspFW3kGeWqpVLK/VdqCRpw7PJc25ZCQcQKBgQDuNOzknR4y29nGxXlQqiOnhifls4BnOIL8cpPTMOsqrfR/oCk1GH9Jv0PBMcQE1JYFBLOa3Sz1t/0yJDOo9IIkrwxpN5nzOhGHCYHpGjRyPFQssdmffXwetYSO4VHrbJXkUUh3VnC2rMNwWy8Bwrxtv8u6oUgZMb6cmVITDAzNlQKBgQCxWCsyNgC3g/bUhLp0Epej7f4Dh54dBwju/VgbWR1Zy3xWzaZ2WZ25ALsN0VZngx6D6bxz3rBuN1AUyWKiCbWNsesX3JeHah5EnPA6Jw3oCH+sZyOFDRn+tw2QsvQ26jNWTKbw+31pWMnSPPlu4KnpSB7GqjXEvCftWxmHsJrtZQKBgEhODl4yhvkfHNKmHHXsvxfZtACYZPBwCeqBCPgBEFELLn0S648vWWvUP8fDyGFC+iqZy77FRiFr8NIohPnTBjIGZHkHpJZc2PcpXqKYDrViNJbAgXNVDrjvlkYchNY2RqVgOuPmfB4nAMf5FaKuLq4NmtSSoiTroZU9QNmBPd2lAoGABw9cgN43fxbIz8MM7SwET2ldEGTovX0XNPRu+n+8tGNuasI7G0EMD15hE/a+etZ0c4ntj6tQ2MJo9Lrjq1G5oY9wrX2BpslptQ+OXLJLUm5sLr/YYSaZX1OIPbdyE3GVY50flD5eyr/XIQB+aZSWDwxo9T23cEKRUFitFoLIWCUCgYBSDjcpNb6qe6x5CQdP6Im3zMczz6c8zW1LSn5m1ANk3Iej+2a6VMCTkli8fuKj3sVik4M1giHg5cf9FwRMhizsYpu4i0be29S/urEIHiX3MlPA/l4Cta+CY2sNF+02D47vYOvkGT/Z2j4H+GJiJ6fGNkAwLgEUrBtKw4jkwjxzjw==";

    @RequestMapping(value = "/key/test", method = RequestMethod.GET)
    public Object keyTest(){
        HashMap<String, String> obj = encryptUtil.createKeypairAsString();
        System.out.println("publicKey : "+obj.get("publicKey"));
        System.out.println("privateKey : "+obj.get("privateKey"));
        return true;
    }

//    @RequestMapping(value = "/key/encrypt", method = RequestMethod.GET)
//    public String encryptMake(){
//        String encrypt = null;
//        try {
//            License license = new License();
//
//
//
//
//            ObjectMapper mapper = new ObjectMapper();
//
//            String json = mapper.writeValueAsString(license);
//            System.out.println(json.getBytes().length);
//            encrypt = encryptUtil.encode(json, mprivateKey);
//
//        }catch(Exception e){
//            e.printStackTrace();
//        }
//        return encrypt;
//    }

    @RequestMapping(value = "/key/decrypt", method = RequestMethod.GET)
    public String decryptMake(){
        String decrypt = encryptUtil.decode("IQPQVdEyIiB63COy1/rnTvmLaAxQ16BGxX4bR3HfaWrhrM0v54arP7X2k1bjnaInVNu17J3qOyhzVg3XtGPiEscLuLJPyNFxdB6euPPwEVj9EfeEaazatyXPhhdrKimB8J23Mg0HDAPfq/OOhH8qxEU5KM53zHhpzopc1G/AF+QWv2svTzNgbEw5jhwUlMBicGE3hwMAKLaNw55+CnA3763TZEba8ZP3uejirZq9jHpDwR2M4x6SG2nQkO5hrBXXlPF850Y+Gtp808rslYIa37GUl2Sp0vvBPAZnDAvp2C6y18lSEMSRY2nfPtVIPlgP7KKv/nDNjiMkfl+bwfEs+w==",mpublicKey);
        return decrypt;
    }

    @RequestMapping(value = "/key/encrypt", method = RequestMethod.GET)
    public String encryptMake(){
        String encrypt = null;
        String json = null;
        try {
            License license = new License();
            license.setCountAttended(encryptUtil.encode("10", mprivateKey));
            license.setCountStudio(encryptUtil.encode("10", mprivateKey));
            license.setCountUnattended(encryptUtil.encode("10", mprivateKey));
            Calendar cal = Calendar.getInstance();
            long time = cal.getTimeInMillis();
            license.setIssuedDatetime(encryptUtil.encode(String.valueOf(time), mprivateKey));
            license.setIssueType(encryptUtil.encode(String.valueOf(0), mprivateKey));
            license.setLicenseFinishedDatetime(encryptUtil.encode(String.valueOf(time), mprivateKey));
            license.setLicenseKey(encryptUtil.encode(String.valueOf(UUID.randomUUID()), mprivateKey));
            license.setName(encryptUtil.encode("licenseName", mprivateKey));
            license.setLicenseStartedDatetime(encryptUtil.encode(String.valueOf(time), mprivateKey));
            license.setPriceAttended(encryptUtil.encode(String.valueOf(1000), mprivateKey));
            license.setPriceUnattended(encryptUtil.encode(String.valueOf(1000), mprivateKey));
            license.setPriceStudio(encryptUtil.encode(String.valueOf(1000), mprivateKey));
            license.setSubscriptor(encryptUtil.encode(String.valueOf(UUID.randomUUID()), mprivateKey));
            license.setTariff(encryptUtil.encode("Hour", mprivateKey));
            license.setType(encryptUtil.encode("Organization", mprivateKey));
            ObjectMapper mapper = new ObjectMapper();

            json = mapper.writeValueAsString(license);

        }catch(Exception e){
            e.printStackTrace();
        }
        return json;
    }
}
