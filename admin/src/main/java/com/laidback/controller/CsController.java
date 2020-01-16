package com.laidback.controller;

import com.amazonaws.services.s3.model.S3Object;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;

import com.laidback.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.RegEx;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;


@RestController
public class CsController extends RootController {

    @Autowired
    AmazonClient amazonClient;

    @Autowired
    BbsFileMapper bbsFileMapper;

    @Autowired
    BbsFileRepository bbsFileRepository;

    @Autowired
    BbsNoticeMapper bbsNoticeMapper;

    @Autowired
    BbsNoticeRepository bbsNoticeRepository;

    @Autowired
    BbsOnetooneMapper bbsOnetooneMapper;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    ContactusMapper contactusMapper;

    @Autowired
    ContactusRepository contactusRepository;

    @Autowired
    BbsNewsroomRepository bbsNewsroomRepository;

    @Autowired
    BbsNewsroomMapper bbsNewsroomMapper;

    @Autowired
    DivOneMapper divOneMapper;

    @Autowired
    DivOneRepository divOneRepository;

    @Autowired
    protected ResponseService responseService;

    @Autowired
    ReleaseNoteRepository releaseNoteRepository;

    @Autowired
    ReleaseNoteMapper releaseNoteMapper;

    @GetMapping(value = "/cs/notice")
    public ModelAndView noticeList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);

        // Order value Change
        setOrderValueChange(mav, params, order);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = bbsNoticeMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<BbsNotice> results = bbsNoticeMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("cs/notice");
        return mav;
    }

    // 공지 상세 정보 페이지 호출
    @GetMapping(value = "/cs/noticeView")
    public ModelAndView view(ModelAndView mav,
                             @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsNotice notice = bbsNoticeMapper.findByNotice(params);
            mav.addObject("notice", notice);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "notice");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            mav.addObject("bbsFiles", bbsFiles);
        }

        mav.setViewName("cs/noticeView");
        return mav;
    }

    // 공지사항 등록, 수정 모달 호출
    @GetMapping(value = "/cs/noticeModalView")
    public ModelAndView modalView(ModelAndView mav,
                                  @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsNotice notice = bbsNoticeMapper.findByNotice(params);
            mav.addObject("notice", notice);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "notice");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            mav.addObject("bbsFiles", bbsFiles);
        }

        mav.setViewName("cs/noticeModal");
        return mav;
    }

    @PostMapping(value = "/cs/save")
    public Object save(BbsNotice notice, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            // 첨부파일 임시 저장 리스트
            List<BbsFile> fileList = new ArrayList<>();

            // 수정
            if(notice.getSeq() != null){
                BbsNotice old = bbsNoticeRepository.findOne(notice.getSeq());
                old.setTitle(notice.getTitle());
                String notiContent = notice.getContent();
                notiContent = notiContent.substring(0, notiContent.length() -1);
                old.setContent(notiContent);
                old.setUpdateDatetime(new Date());
                bbsNoticeRepository.save(old);

                MultipartFile[] files = notice.getFile();
                for(MultipartFile file : files) {
//                    String fileName = file.getOriginalFilename();
                    String fileName = file.getOriginalFilename();
                    int startIndex = fileName.replaceAll("\\\\", "/").lastIndexOf("/");
                    fileName = fileName.substring(startIndex + 1);
                    if(fileName != null && !"".equals(fileName)) {
                        BbsFile bbsFile = new BbsFile();
                        bbsFile.setBbsSeq(notice.getSeq());
                        bbsFile.setBbsCode("notice");
                        bbsFile.setFileType(1);
                        bbsFile.setCreateDatetime(new Date());
                        String fileUrl = amazonClient.uploadFile(file);
                        bbsFile.setOriginalFileName(fileName);
                        bbsFile.setFileName(fileUrl);
                        fileList.add(bbsFile);
                    }
                }
            }
            // 등록
            else {
                notice.setWriter("관리자");
                notice.setCreateDatetime(new Date());
                notice.setViewCnt(0);
                BbsNotice saveNotice = bbsNoticeRepository.save(notice);

                MultipartFile[] files = notice.getFile();
                if(files.length > 0) {
                    for(MultipartFile file : files) {
                        if(!file.isEmpty()) {
                            BbsFile bbsFile = new BbsFile();
                            bbsFile.setBbsSeq(saveNotice.getSeq());
                            bbsFile.setBbsCode("notice");
                            bbsFile.setFileType(1);
                            bbsFile.setCreateDatetime(new Date());
                            String fileUrl = amazonClient.uploadFile(file);
                            bbsFile.setOriginalFileName(file.getOriginalFilename());
                            bbsFile.setFileName(fileUrl);
                            fileList.add(bbsFile);
                        }
                    }
                }
            }

            bbsNoticeRepository.flush();
            bbsFileRepository.save(fileList);
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    // 공지 첨부파일 삭제
    @RequestMapping(value = "/cs/noticeFileDelete", method = RequestMethod.POST)
    public Object noticeFileDelete(BbsFile bbsFile, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            int fileSeq = bbsFile.getSeq();
            params.put("seq", fileSeq);
            params.put("bbsCode", "notice");
            BbsFile oldFiles = bbsFileMapper.findByFile(params);
            oldFiles.setDeleteDatetime(new Date());
            bbsFileRepository.save(oldFiles);
            bbsFileRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }


    // 공지 삭제 처리
    @RequestMapping(value = "/cs/noticeDelete", method = RequestMethod.POST)
    public Object noticeDelete(BbsNotice notice, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            String deleteArray = notice.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                notice = bbsNoticeMapper.findByNotice(params);
                notice.setDeleteDatetime(new java.util.Date());
                bbsNoticeRepository.save(notice);

                params.put("bbsSeq", Integer.parseInt(seq));
                params.put("bbsCode", "notice");
                List<BbsFile> oldFiles = bbsFileMapper.findByFiles(params);
                for (int i = 0; i < oldFiles.size(); i++) {
                    oldFiles.get(i).setDeleteDatetime(new Date());
                    bbsFileRepository.save(oldFiles);
                }
            }

            bbsNoticeRepository.flush();
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    // 버그신고 리스트
    @GetMapping(value = "/cs/bug")
    public ModelAndView bugList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "bo.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){
        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(2);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);

        // Order value Change
        setOrderValueChange(mav, params, order);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = bbsOnetooneMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<BbsOnetoone> results = bbsOnetooneMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("cs/bug");
        return mav;
    }

    // 버그신고 상세 정보 페이지 호출
    @GetMapping(value = "/cs/bugView")
    public ModelAndView bugView(ModelAndView mav,
                                @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        BbsOnetoone onetoone = bbsOnetooneMapper.findByOnetoone(params);
        mav.addObject("bug", onetoone);

        params.put("bbsSeq", seq);
        params.put("bbsCode", "bug");
        List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
        mav.addObject("bbsFiles", bbsFiles);

        mav.setViewName("cs/bugView");
        return mav;
    }

    // 버그신고 등록, 수정 모달 호출
    @GetMapping(value = "/cs/bugModalView")
    public ModelAndView bugModalView(ModelAndView mav,
                                     @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsOnetoone onetoone = bbsOnetooneMapper.findByOnetoone(params);
            mav.addObject("bug", onetoone);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "bug");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            List<BbsFile> userFileList = new ArrayList<>();
            List<BbsFile> answerFileList = new ArrayList<>();
            for(int i=0;i<bbsFiles.size();i++) {
                int fileType = bbsFiles.get(i).getFileType();
                if(fileType == 0) {
                    userFileList.add(bbsFiles.get(i));
                } else {
                    answerFileList.add(bbsFiles.get(i));
                }
            }
            mav.addObject("userFileList", userFileList);
            mav.addObject("answerFileList", answerFileList);
        }

        mav.setViewName("cs/bugModal");
        return mav;
    }

    @PostMapping(value = "/cs/bugModify")
    public Object bugSave(BbsOnetoone onetoone, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            // 첨부파일 임시 저장 리스트
            List<BbsFile> fileList = new ArrayList<>();

            // 수정
            if(onetoone.getSeq() != null){
                BbsOnetoone old = bbsOnetooneRepository.findOne(onetoone.getSeq());
                old.setTitle(onetoone.getTitle());
                old.setContent(onetoone.getContent());
                old.setAnswer("관리자");
                old.setAnswerContent(onetoone.getAnswerContent());
                if(onetoone.getAnswerContent() != null && !"".equals(onetoone.getAnswerContent())) {
                    old.setAnswerYn(1);
                } else {
                    old.setAnswerYn(0);
                }
                old.setUpdateDatetime(new Date());
                bbsOnetooneRepository.save(old);

                if(onetoone.getAnswerContent() != null && !"".equals(onetoone.getAnswerContent())) {
                    MultipartFile[] files = onetoone.getFile();
                    if(files.length > 0) {
                        for(MultipartFile file : files) {
                            String fileName = file.getOriginalFilename();
                            int startIndex = fileName.replaceAll("\\\\", "/").lastIndexOf("/");
                            fileName = fileName.substring(startIndex + 1);

                            if(fileName != null && !"".equals(fileName)) {
                                BbsFile bbsFile = new BbsFile();
                                bbsFile.setBbsSeq(onetoone.getSeq());
                                bbsFile.setBbsCode("bug");
                                bbsFile.setFileType(1);
                                bbsFile.setCreateDatetime(new Date());
                                String fileUrl = amazonClient.uploadFile(file);
                                bbsFile.setOriginalFileName(fileName);
                                bbsFile.setFileName(fileUrl);
                                fileList.add(bbsFile);
                            }
                        }
                    }
                }
            }
            bbsFileRepository.save(fileList);

            bbsOnetooneRepository.flush();
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e) {
            transactionManager.rollback(status);
            log.error(e.getMessage(), e);
            return responseService.getFailResult(0, "");
        }
    }

    // 버그신고 삭제 처리
    @RequestMapping(value = "/cs/bugDelete", method = RequestMethod.POST)
    public Object bugDelete(BbsOnetoone onetoone, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            result.put("result",false);
            return result;
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            String deleteArray = onetoone.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                onetoone = bbsOnetooneMapper.findByOnetoone(params);
                onetoone.setDeleteDatetime(new java.util.Date());
                bbsOnetooneRepository.save(onetoone);
            }
            bbsOnetooneRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    @RequestMapping(value="/cs/userFileDownload")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response,
             @RequestParam(value = "fileUrl", required = false) String fileUrl,
             @RequestParam(value = "seq", required = false) Integer seq,
             ModelMap model) throws Exception
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        BbsFile fileInfo = bbsFileMapper.findByFile(params);
        String originalFileName = fileInfo.getOriginalFileName();
        String filePath = fileUrl;

        S3Object s3Object = amazonClient.downloadFile(filePath);
        String realFileName = fileStorageService.storeFile(s3Object, originalFileName);
        String realPath = String.valueOf(Paths.get("./temp").toAbsolutePath().normalize());

        File file = new File(realPath, realFileName);
        String userAgent = request.getHeader("User-Agent");
        boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
        String fileName = null;

        if (ie) {
            fileName = URLEncoder.encode(file.getName(), "utf-8");
        } else {
            fileName = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition","attachment;filename=\"" +fileName+"\";");

//        FileInputStream fis = new FileInputStream(file);
//        BufferedInputStream bis = new BufferedInputStream(fis);


        try(FileInputStream fis = new FileInputStream(file)){
            try(BufferedInputStream bis = new BufferedInputStream(fis)){
                ServletOutputStream so = response.getOutputStream();
                try(BufferedOutputStream bos = new BufferedOutputStream(so)){
                    byte[] data = new byte[2048];
                    int input = 0;
                    while ((input = bis.read(data)) != -1) {
                        bos.write(data, 0, input);
                        bos.flush();
                    }
                    file.delete();
                }
            }
        }
    }


    @GetMapping(value = "/cs/onetoone")
    public ModelAndView onetooneList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "bo.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){
        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(0);
        qnaType.add(1);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);

        // Order value Change
        setOrderValueChange(mav, params, order);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = bbsOnetooneMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<BbsOnetoone> results = bbsOnetooneMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("cs/onetoone");
        return mav;
    }

    // 1:1 문의 상세 정보 페이지 호출
    @GetMapping(value = "/cs/onetooneView")
    public ModelAndView onetooneView(ModelAndView mav,
                                     @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        BbsOnetoone onetoone = bbsOnetooneMapper.findByOnetoone(params);
        mav.addObject("onetoone", onetoone);

        params.put("bbsSeq", seq);
        params.put("bbsCode", "onetoone");
        List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
        mav.addObject("bbsFiles", bbsFiles);

        mav.setViewName("cs/onetooneView");
        return mav;
    }

    // 1:1 문의 등록, 수정 모달 호출
    @GetMapping(value = "/cs/onetooneModalView")
    public ModelAndView onetooneModalView(ModelAndView mav,
                                          @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsOnetoone onetoone = bbsOnetooneMapper.findByOnetoone(params);
            mav.addObject("onetoone", onetoone);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "onetoone");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            List<BbsFile> userFileList = new ArrayList<>();
            List<BbsFile> answerFileList = new ArrayList<>();
            System.out.println(bbsFiles.size());
            for(int i=0;i<bbsFiles.size();i++) {
                int fileType = bbsFiles.get(i).getFileType();
                if(fileType == 0) {
                    userFileList.add(bbsFiles.get(i));
                } else {
                    answerFileList.add(bbsFiles.get(i));
                }
            }
            mav.addObject("userFileList", userFileList);
            mav.addObject("answerFileList", answerFileList);
        }

        mav.setViewName("cs/onetooneModal");
        return mav;
    }

    @PostMapping(value = "/cs/onetooneModify")
    public Object save(
            @RequestParam(value="seq",required = false) Integer seq
            , @RequestParam(value = "title",required = false) String title
            , @RequestParam(value = "answerContent",required = false) String answerContent
            , @RequestParam(value = "directFile", required = false) MultipartFile[] directFile
    )
    {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        System.out.println(title);

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            BbsOnetoone onetoone = bbsOnetooneRepository.findOne(seq);
            // 첨부파일 임시 저장 리스트
            List<BbsFile> fileList = new ArrayList<>();

            // 수정


            onetoone.setTitle(title);
            onetoone.setAnswer("관리자");
            onetoone.setAnswerContent(answerContent);
            if(answerContent != null) {
                onetoone.setAnswerYn(1);
            } else {
                onetoone.setAnswerYn(0);
            }
            onetoone.setUpdateDatetime(new Date());
            bbsOnetooneRepository.save(onetoone);

            System.out.println(directFile);
            if(directFile != null) {
                if (directFile.length > 0) {
                    for (MultipartFile onefile : directFile) {
                        System.out.println(onefile);
                        if (!onefile.isEmpty()) {
//                                String fileName = file.getOriginalFilename();
                            String fileName = onefile.getOriginalFilename();
                            int startIndex = fileName.replaceAll("\\\\", "/").lastIndexOf("/");
                            fileName = fileName.substring(startIndex + 1);
                            if (fileName != null && !"".equals(fileName)) {
                                BbsFile bbsFile = new BbsFile();
                                bbsFile.setBbsSeq(seq);
                                bbsFile.setBbsCode("onetoone");
                                bbsFile.setFileType(1);
                                bbsFile.setCreateDatetime(new Date());
                                String fileUrl = amazonClient.uploadFile(onefile);
                                bbsFile.setOriginalFileName(fileName);
                                bbsFile.setFileName(fileUrl);
                                fileList.add(bbsFile);
                            }
                        }
                    }
                }
            }

            bbsFileRepository.save(fileList);

            bbsOnetooneRepository.flush();
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 1:1 문의 삭제 처리
    @RequestMapping(value = "/cs/onetooneDelete", method = RequestMethod.POST)
    public Object onetooneDelete(BbsOnetoone onetoone, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            String deleteArray = onetoone.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
//                params.put("seq", Integer.parseInt(seq));
                onetoone = bbsOnetooneRepository.findOne(Integer.parseInt(seq));
                onetoone.setDeleteDatetime(new java.util.Date());
                bbsOnetooneRepository.save(onetoone);
                bbsOnetooneRepository.flush();
            }

            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }


    @GetMapping(value = "/cs/ajax_notice")
    public Object noticeAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate

    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);


        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = bbsNoticeMapper.count(params);


        List<BbsNotice> results = bbsNoticeMapper.find(params);


        return responseService.getListResult(totalCount,results);
    }

    // 버그신고 리스트
    @GetMapping(value = "/cs/ajax_bug")
    public Object bugList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "bo.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ){
        Map<String,Object> result = new HashMap<>();

        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(2);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);
        params.put("order",order);


        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = bbsOnetooneMapper.count(params);


        List<BbsOnetoone> results = bbsOnetooneMapper.find(params);


        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value = "/cs/ajax_onetoone")
    public Object onetooneAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "bo.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ) {
        Map<String, Object> result = new HashMap<>();

        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(0);
        qnaType.add(1);
        qnaType.add(2);
        qnaType.add(3);
        qnaType.add(4);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);
        params.put("order", order);

        if (StringUtils.isEmpty(startDate)) {
            String sd = null;
            params.put("startDate", sd);
        } else {
//            params.put("startDate",startDate);
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (StringUtils.isEmpty(endDate)) {
            String ed = null;
            params.put("endDate", ed);
        } else {
//            params.put("startDate",startDate);
            params.put("endDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (searchWord != null) {
            params.put("searchWord", searchWord);
            params.put("searchType", searchType);
        }

        int totalCount = bbsOnetooneMapper.count(params);


        List<BbsOnetoone> results = bbsOnetooneMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }

    // 공지 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/cs/noticeExeclDownList")
    public Object getExeclDownList(BbsNotice bbsNotice) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = bbsNotice.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> noticeList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            noticeList.add(Integer.parseInt(seq));
        }
        params.put("noticeList", noticeList);

        List<BbsNotice> execlDownList = bbsNoticeMapper.getExeclDownList(params);
//        result.put("execlDownList", execlDownList);
        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    // 1:1 문의 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/cs/onetooneExeclDownList")
    public Object getOneToOneExeclDownList(
            BbsOnetoone bbsOnetoone
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
    ) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = bbsOnetoone.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> onetooneList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            onetooneList.add(Integer.parseInt(seq));
        }
        params.put("list", onetooneList);
        params.put("sort",sort);
        params.put("order",order);

        ArrayList<Integer> qnaType = new ArrayList<>();
        qnaType.add(0);
        qnaType.add(1);

        List<BbsOnetoone> execlDownList = bbsOnetooneMapper.getExeclDownList(params);
        result.put("execlDownList", execlDownList);
        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    // 버그신고 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/cs/bugExeclDownList")
    public Object getBugExeclDownList(BbsOnetoone bbsOnetoone) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = bbsOnetoone.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> bugList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            bugList.add(Integer.parseInt(seq));
        }
        params.put("list", bugList);

        ArrayList<Integer> qnaType = new ArrayList<>();
        qnaType.add(2);

        List<BbsOnetoone> execlDownList = bbsOnetooneMapper.getExeclDownList(params);
//        result.put("execlDownList", execlDownList);
        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    @GetMapping(value = "/cs/contactus")
    public ModelAndView contactusList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "bo.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);

        mav.addObject("row",10);
        int totalCount = contactusMapper.count(params);
        mav.addObject("total",totalCount);

        mav.setViewName("cs/contactus");
        return mav;
    }
    @GetMapping(value = "/cs/ajax_contactus")
    public Object contactusAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ) {
        Map<String, Object> result = new HashMap<>();

        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(0);
        qnaType.add(1);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);
        params.put("order", order);

        if (StringUtils.isEmpty(startDate)) {
            String sd = null;
            params.put("startDate", sd);
        } else {
//            params.put("startDate",startDate);
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (StringUtils.isEmpty(endDate)) {
            String ed = null;
            params.put("endDate", ed);
        } else {
//            params.put("startDate",startDate);
            params.put("endDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (searchWord != null) {
            params.put("searchWord", searchWord);
            params.put("searchType", searchType);
        }

        int totalCount = contactusMapper.count(params);


        List<Contactus> results = contactusMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }

    // contactus 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/cs/contactusExeclDownList")
    public Object getExeclDownListContactus(Contactus contactus) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = contactus.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> contactusList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            contactusList.add(Integer.parseInt(seq));
        }
        params.put("contactusList", contactusList);

        List<Contactus> execlDownList = contactusMapper.getExeclDownList(params);


        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    // 제휴문의 상세 정보 페이지 호출
    @GetMapping(value = "/cs/contactusView")
    public ModelAndView contactusView(ModelAndView mav,
                                     @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        Contactus contactus = contactusMapper.findByContactus(params);
        mav.addObject("contactus", contactus);

        mav.setViewName("cs/contactusView");
        return mav;
    }

    // contactus 삭제 처리
    @RequestMapping(value = "/cs/contactusDelete", method = RequestMethod.POST)
    public Object contactusDelete(Contactus contactus, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            String deleteArray = contactus.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                contactus = contactusMapper.findByContactus(params);
                contactus.setDeleteDatetime(new java.util.Date());
                contactusRepository.save(contactus);
            }
            contactusRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value = "/cs/newsroom")
    public ModelAndView newsRoomList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){


        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("cs/newsroom");
        return mav;
    }

    // 공지 상세 정보 페이지 호출
    @GetMapping(value = "/cs/newsroomView")
    public ModelAndView newsRoomView(ModelAndView mav,
                             @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsNewsroom newsroom = bbsNewsroomMapper.findByNewsroom(params);
            mav.addObject("newsroom", newsroom);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "newsroom");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            mav.addObject("bbsFiles", bbsFiles);
        }

        mav.setViewName("cs/newsroomView");
        return mav;
    }

    // 공지사항 등록, 수정 모달 호출
    @GetMapping(value = "/cs/newsroomModalView")
    public ModelAndView newsRoomModalView(ModelAndView mav,
                                  @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            BbsNewsroom newsroom = bbsNewsroomMapper.findByNewsroom(params);
            mav.addObject("newsroom", newsroom);

            params.put("bbsSeq", seq);
            params.put("bbsCode", "newsroom");
            List<BbsFile> bbsFiles = bbsFileMapper.findByFiles(params);
            mav.addObject("bbsFiles", bbsFiles);
        }

        mav.setViewName("cs/newsroomModal");
        return mav;
    }

    @GetMapping(value = "/cs/ajax_newsroom")
    public Object newsroomAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ) {
        Map<String, Object> result = new HashMap<>();

        List<Integer> qnaType = new ArrayList<>();
        qnaType.add(0);
        qnaType.add(1);

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("qnaType", qnaType);
        params.put("order", order);

        if (StringUtils.isEmpty(startDate)) {
            String sd = null;
            params.put("startDate", sd);
        } else {
//            params.put("startDate",startDate);
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (StringUtils.isEmpty(endDate)) {
            String ed = null;
            params.put("endDate", ed);
        } else {
//            params.put("startDate",startDate);
            params.put("endDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate, "yyyy-MM-dd"), Calendar.DATE, 0), "yyyy-MM-dd"));
        }

        if (searchWord != null) {
            params.put("searchWord", searchWord);
            params.put("searchType", searchType);
        }

        int totalCount = bbsNewsroomMapper.count(params);


        List<BbsNewsroom> results = bbsNewsroomMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }
    @PostMapping(value = "/cs/newsroomExeclDownList")
    public Object getExeclDownListNews(BbsNewsroom bbsNewsroom) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = bbsNewsroom.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> newsroomList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            newsroomList.add(Integer.parseInt(seq));
        }
        params.put("newsroomList", newsroomList);

        List<BbsNewsroom> execlDownList = bbsNewsroomMapper.getExeclDownList(params);

        return responseService.getListResult(execlDownList.size(),execlDownList);
    }

    @PostMapping(value = "/cs/newsroomSave")
    public Object save(BbsNewsroom newsroom, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            // 첨부파일 임시 저장 리스트
            List<BbsFile> fileList = new ArrayList<>();

            // 수정
            if(newsroom.getSeq() != null){
                BbsNewsroom old = bbsNewsroomRepository.findOne(newsroom.getSeq());
                old.setTitle(newsroom.getTitle());
                String notiContent = newsroom.getContent();
                notiContent = notiContent.substring(0, notiContent.length() -1);
                old.setContent(notiContent);
                old.setUpdateDatetime(new Date());
                old.setDisplayYn(newsroom.getDisplayYn());
                old.setViewDatetime(DateUtil.string2Date(newsroom.getViewDatetimeStr(), "yyyy-MM-dd"));
                bbsNewsroomRepository.save(old);

                MultipartFile file = newsroom.getFile();

//                String fileName = file.getOriginalFilename();
                String fileName = file.getOriginalFilename();
                int startIndex = fileName.replaceAll("\\\\", "/").lastIndexOf("/");
                fileName = fileName.substring(startIndex + 1);
                if(fileName != null && !"".equals(fileName)) {

                    params.put("bbsSeq", newsroom.getSeq());
                    params.put("bbsCode", "newsroom");
                    List<BbsFile> oldFiles = bbsFileMapper.findByFiles(params);
                    for (int i = 0; i < oldFiles.size(); i++) {
                        oldFiles.get(i).setDeleteDatetime(new Date());
                        bbsFileRepository.save(oldFiles);
                    }

                    BbsFile bbsFile = new BbsFile();
                    bbsFile.setBbsSeq(newsroom.getSeq());
                    bbsFile.setBbsCode("newsroom");
                    bbsFile.setFileType(1);
                    bbsFile.setCreateDatetime(new Date());
                    String fileUrl = amazonClient.uploadFile(file);
                    bbsFile.setOriginalFileName(fileName);
                    bbsFile.setFileName(fileUrl);
                    fileList.add(bbsFile);
                }

            }
            // 등록
            else {
                newsroom.setWriter("관리자");
                newsroom.setCreateDatetime(new Date());
                newsroom.setViewCnt(0);
                newsroom.setViewDatetime(DateUtil.string2Date(newsroom.getViewDatetimeStr(), "yyyy-MM-dd"));
                BbsNewsroom saveNewsroom = bbsNewsroomRepository.save(newsroom);

                MultipartFile file = newsroom.getFile();

                BbsFile bbsFile = new BbsFile();
                bbsFile.setBbsSeq(saveNewsroom.getSeq());
                bbsFile.setBbsCode("newsroom");
                bbsFile.setFileType(1);
                bbsFile.setCreateDatetime(new Date());
                String fileUrl = amazonClient.uploadFile(file);
                bbsFile.setOriginalFileName(file.getOriginalFilename());
                bbsFile.setFileName(fileUrl);
                fileList.add(bbsFile);

            }

            bbsNewsroomRepository.flush();
            bbsFileRepository.save(fileList);
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 공지 첨부파일 삭제
    @RequestMapping(value = "/cs/newsroomFileDelete", method = RequestMethod.POST)
    public Object newsroomFileDelete(BbsFile bbsFile, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            int fileSeq = bbsFile.getSeq();
            params.put("seq", fileSeq);
            params.put("bbsCode", "newsroom");
            BbsFile oldFiles = bbsFileMapper.findByFile(params);
            oldFiles.setDeleteDatetime(new Date());
            bbsFileRepository.save(oldFiles);
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }


    // 공지 삭제 처리
    @RequestMapping(value = "/cs/newsroomDelete", method = RequestMethod.POST)
    public Object noticeDelete(BbsNewsroom newsroom, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            String deleteArray = newsroom.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                newsroom = bbsNewsroomMapper.findByNewsroom(params);
                newsroom.setDeleteDatetime(new java.util.Date());
                bbsNewsroomRepository.save(newsroom);

                params.put("bbsSeq", Integer.parseInt(seq));
                params.put("bbsCode", "newsroom");
                List<BbsFile> oldFiles = bbsFileMapper.findByFiles(params);
                for (int i = 0; i < oldFiles.size(); i++) {
                    oldFiles.get(i).setDeleteDatetime(new Date());
                    bbsFileRepository.save(oldFiles);
                }
            }

            bbsNewsroomRepository.flush();
            bbsFileRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value = "/cs/div_one")
    public ModelAndView divOne(ModelAndView mav)
    {

        Map<String, Object> params = new HashMap<>();
        params.put("sort", "seq");
        params.put("order", 1);

//        int totalCount = bbsNewsroomMapper.count(params);
//        result.put("total", totalCount);

        List<DivOne> results = divOneMapper.find(params);
        mav.addObject("list", results);

        mav.setViewName("cs/divOne");
        return mav;
    }

    @PostMapping(value = "/cs/div_save")
    public Object divSave(
        DivOne divOne
    ){
        Map<String, Object> result = new HashMap<>();
        try {
            if (divOne.getSeq() == null) { // 신규등록
                divOne.setCreateDatetime(new java.util.Date());
                divOneRepository.save(divOne);

            } else { // 수정
                DivOne old = divOneRepository.findOne(divOne.getSeq());
                divOne.setCreateDatetime(old.getCreateDatetime());
                divOne.setUpdateDatetime(new java.util.Date());
                divOneRepository.save(divOne);
            }
            divOneRepository.flush();
            return responseService.getSuccessResult();
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }

    }

    @PutMapping(value = "/cs/div_del")
    public Object divDelete(
            @RequestParam(value = "seq") Integer seq
    ){
        Map<String, Object> result = new HashMap<>();
        try {
            DivOne divOne = divOneRepository.findOne(seq);
            divOne.setDeleteDatetime(new java.util.Date());
            divOneRepository.save(divOne);
            divOneRepository.flush();

            return responseService.getSuccessResult();
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }

    }

    @GetMapping(value = "/cs/release_note")
    public ModelAndView releaseNote(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){


        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("cs/releaseNote");
        return mav;
    }


    // 릴리즈노트 페이지 호출
    @GetMapping(value = "/cs/release_note/{seq}")
    public ModelAndView releaseNoteView(ModelAndView mav,
                                     @PathVariable(value = "seq") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            ReleaseNote releaseNote = releaseNoteRepository.findOne(seq);
            mav.addObject("releaseNote", releaseNote);
        }

        mav.setViewName("cs/releaseNoteView");
        return mav;
    }

    @PostMapping(value = "/cs/release_note")
    public Object releaseNoteSave(
            @RequestParam(value = "title") String title
            ,@RequestParam(value = "content") String content
            ,@RequestParam(value = "noteType") Integer noteType
    ){
        Map<String, Object> result = new HashMap<>();
        try {
            ReleaseNote releaseNote = new ReleaseNote();
            releaseNote.setContent(content);
            releaseNote.setTitle(title);
            releaseNote.setNoteType(noteType);
            releaseNote.setCreateDatetime(new java.util.Date());
            releaseNoteRepository.save(releaseNote);
            releaseNoteRepository.flush();
            return responseService.getSuccessResult();
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }

    }

    @PutMapping(value = "/cs/release_note")
    public Object releaseNoteUpdate(
            @RequestParam(value = "seq") Integer seq
            ,@RequestParam(value = "title") String title
            ,@RequestParam(value = "content") String content
            ,@RequestParam(value = "noteType") Integer noteType
    ){
        Map<String, Object> result = new HashMap<>();
        try {
            ReleaseNote releaseNote = releaseNoteRepository.findOne(seq);
            releaseNote.setContent(content);
            releaseNote.setTitle(title);
            releaseNote.setNoteType(noteType);
            releaseNote.setUpdateDatetime(new java.util.Date());
            releaseNoteRepository.save(releaseNote);
            releaseNoteRepository.flush();
            return responseService.getSuccessResult();
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }

    }

    @DeleteMapping(value = "/cs/release_note")
    public Object releaseNoteDelete(
            @RequestParam(value = "deleteArray") String deleteArray
    ){
        try {
            String[] seqs = deleteArray.split("\\|");
            for(int i = 0; i < seqs.length;i++){
                releaseNoteRepository.delete(Integer.parseInt(seqs[i]));
                releaseNoteRepository.flush();
            }

            return responseService.getSuccessResult();
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value = "/cs/ajax_release_note")
    public Object newsroomAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
    ) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order", order);

        if (searchWord != null) {
            params.put("searchWord", searchWord);
            params.put("searchType", searchType);
        }

        int totalCount = releaseNoteMapper.count(params);


        List<ReleaseNote> results = releaseNoteMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }

    // 비동기 릴리즈노트 페이지 호출
    @GetMapping(value = "/cs/ajax_release_note/{seq}")
    public Object ajaxReleaseNoteView(
                                        @PathVariable(value = "seq") Integer seq)
    {
        Map<String, Object> result = new HashMap<>();
        if(seq != 0) {
            ReleaseNote releaseNote = releaseNoteRepository.findOne(seq);
            result.put("info",releaseNote);
        }


        return result;
    }
}