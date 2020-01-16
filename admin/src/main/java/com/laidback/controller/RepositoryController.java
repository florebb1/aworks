package com.laidback.controller;

import com.amazonaws.services.s3.model.S3Object;
import com.laidback.mapper.RepositoryMediaMapper;
import com.laidback.mapper.RepositoryProcessMapper;
import com.laidback.mapper.RepositoryRecommMapper;
import com.laidback.model.*;
import com.laidback.repository.RepositoryMediaRepository;
import com.laidback.repository.RepositoryProcessRepository;
import com.laidback.repository.RepositoryRecommRepository;
import com.laidback.repository.RepositoryRepository;
import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;
import com.laidback.util.DateUtil;
import com.laidback.mapper.RepositoryMapper;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionFailedException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.util.*;

@RestController
public class RepositoryController extends RootController {
    @Autowired
    AmazonClient amazonClient;

    @Autowired
    RepositoryMapper repositoryMapper;

    @Autowired
    RepositoryRepository repositoryRepository;

    @Autowired
    RepositoryMediaMapper repositoryMediaMapper;

    @Autowired
    RepositoryMediaRepository repositoryMediaRepository;

    @Autowired
    RepositoryProcessMapper repositoryProcessMapper;

    @Autowired
    RepositoryProcessRepository repositoryProcessRepository;

    @Autowired
    RepositoryRecommMapper repositoryRecommMapper;

    @Autowired
    RepositoryRecommRepository repositoryRecommRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/repository/list")
    public ModelAndView repositoryList(
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
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = repositoryMapper.countBySuper(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<Repository> results = repositoryMapper.findBySuper(params);
        mav.addObject("results", results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);
        mav.addObject("sort", sort);

        mav.setViewName("repository/list");
        return mav;
    }

    // 레포지토리 상세 정보 페이지 호출
    @GetMapping(value = "/repository/repositoryView")
    public ModelAndView view(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            Repository repository = repositoryMapper.findByRepository(params);
            List<RepositoryMedia> repositoryMedia = repositoryMediaMapper.search(repository.getSeq());
            System.out.println(repositoryMedia.size());
            mav.addObject("repository", repository);
            mav.addObject("repositoryMedia",repositoryMedia);
        }

        mav.setViewName("repository/view");
        return mav;
    }

    // 레포지토리 등록, 수정 모달 호출
    @GetMapping(value = "/repository/repositoryModalView")
    public ModelAndView modalView(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            Repository repository = repositoryMapper.findByRepository(params);
            mav.addObject("repository", repository);

            List<RepositoryMedia> medias = repositoryMediaMapper.search(repository.getSeq());
            mav.addObject("medias", medias);
        }

        mav.setViewName("repository/repositoryModal");
        return mav;
    }

    @PostMapping(value = "/repository/save")
    public Object save(Repository repository, BindingResult bindingResult)
    {
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
            // 수정
            if(repository.getSeq() != null){
                Repository old = repositoryRepository.findOne(repository.getSeq());
                old.setAppName(repository.getAppName());    // 콘텐츠 이름
                old.setSummary(repository.getSummary());    // 콘텐츠 요약
                old.setDescription(repository.getDescription());    // 콘텐츠 설명
                old.setAppType(repository.getAppType());    // 타입
                old.setSecurity(repository.getSecurity());
                // 업무분류 >  기존 value 삭제  처리 후 신규 value SAVE
                List<RepositoryProcess> processTypes = repositoryProcessMapper.findByProcessTypes(repository.getSeq());
                for(int i=0; i<processTypes.size(); i++) {
                    repositoryProcessRepository.delete(processTypes.get(i).getSeq());
                    repositoryProcessRepository.flush();
                }
                String processTypeArray = repository.getProcessType();
                String[] processTypeList = processTypeArray.split("\\|");
                for(String processType : processTypeList) {
                    RepositoryProcess process = new RepositoryProcess();
                    process.setProcessType(Integer.parseInt(processType));
                    process.setRepository(repository);
                    repositoryProcessRepository.save(process);
                    repositoryProcessRepository.flush();
                }
                // 태그
//                try {
//                    JSONArray tags = repository.getTagValues();
//                    if (tags != null && tags.length() > 0) {
//                        String tagString = "";
//                        int tagsLength = tags.length();
//                        for (int i = 0; i < tags.length(); i++) {
//                            JSONObject value = tags.getJSONObject(i);
//                            tagString += value.getString("value");
//                            tagString += ",";
//                        }
//                        tagString = tagString.substring(0, tagString.length() - 1);
//                        old.setTags(tagString);
//                    }
//                }catch(ConversionFailedException e){
//
//                }
                old.setBenefit(repository.getBenefit());    // 기대효과
                old.setAppDependencies(repository.getAppDependencies());    // 의존
                old.setComponent(repository.getComponent());    // 호환
                old.setVersion(repository.getVersion());    // 버전 정보
                old.setVersionNote(repository.getVersionNote());    // 버전 설명
                old.setTags(repository.getTags());
                // 영상
                old.setMovieFileUrl(repository.getMovieFileUrl());

                // 매뉴얼
                if(repository.getManual() != null && !"".equals(repository.getManual().getOriginalFilename())){
                    String manualUrl = amazonClient.uploadFile(repository.getManual());
                    old.setManualFileOriginalName(repository.getManual().getOriginalFilename());
                    old.setManualFileUrl(manualUrl);
                }
                // 이미지
                if(repository.getImgArrValue() != null && repository.getImgArrValue().length > 0) {
                    String[] imgArrValue = repository.getImgArrValue();
                    for (int i = 0; i < imgArrValue.length; i++) {
                        String fileUrl = amazonClient.uploadFileBase64(imgArrValue[i]);
                        System.out.println(fileUrl);
                        RepositoryMedia repositoryMedia = new RepositoryMedia();
                        repositoryMedia.setMediaType(1);
                        repositoryMedia.setMediaValue(fileUrl);
                        repositoryMedia.setRepository(repository);
                        repositoryMediaRepository.save(repositoryMedia);
                        repositoryMediaRepository.flush();
                    }
                }
                // 라이센스
                if(repository.getLicenseFile() != null && !"".equals(repository.getLicenseFile().getOriginalFilename())){
                    String licenceUrl = amazonClient.uploadFile(repository.getLicenseFile());
                    old.setLicenseFileOriginalName(repository.getLicenseFile().getOriginalFilename());
                    old.setLicenseFileUrl(licenceUrl);
                }
                // 첨부파일
                if(repository.getAppFile() != null && !"".equals(repository.getAppFile().getOriginalFilename())){
                    String appUrl = amazonClient.uploadFile(repository.getAppFile());
                    old.setAppFileOriginalName(repository.getAppFile().getOriginalFilename());
                    old.setAppFileUrl(appUrl);
                }

                old.setLastUpdate(new Date());
                repositoryRepository.save(old);
            }
            // 등록
            else {
                // 업무분류


                // 태그 세팅
//                try {
//                    JSONArray tags = repository.getTagValues();
//
//                    String tagString = "";
//                    int tagsLength = tags.length();
//                    for (int i = 0; i < tags.length(); i++) {
//                        JSONObject value = tags.getJSONObject(i);
//                        tagString += value.getString("value");
//                        tagString += ",";
//                    }
//                    tagString = tagString.substring(0, tagString.length() - 1);
//                    repository.setTags(tagString);
//                }catch(ConversionFailedException e){
//
//                }

                // 매뉴얼
                if(repository.getManual() != null){
                    String manualUrl = amazonClient.uploadFile(repository.getManual());
                    repository.setManualFileOriginalName(repository.getManual().getOriginalFilename());
                    repository.setManualFileUrl(manualUrl);
                }
                // 이미지


                // 라이센스
                if(repository.getLicenseFile() != null){
                    String licenceUrl = amazonClient.uploadFile(repository.getLicenseFile());
                    repository.setLicenseFileOriginalName(repository.getLicenseFile().getOriginalFilename());
                    repository.setLicenseFileUrl(licenceUrl);
                }
                // 첨부파일
                if(repository.getAppFile() != null){
                    String appUrl = amazonClient.uploadFile(repository.getAppFile());
                    repository.setAppFileOriginalName(repository.getAppFile().getOriginalFilename());
                    repository.setAppFileUrl(appUrl);
                }

                repository.setStatus(0);
//                repository.setSecurity(0);
                repository.setDownloadCnt(0);
                repository.setViewCnt(0);
                repository.setCreateDatetime(new Date());
                repository.setUserSeq(null);
                repositoryRepository.save(repository);

                String processTypeArray = repository.getProcessType();
                String[] processTypeList = processTypeArray.split("\\|");
                for(String processType : processTypeList) {
                    RepositoryProcess process = new RepositoryProcess();
                    process.setProcessType(Integer.parseInt(processType));
                    process.setRepository(repository);
                    repositoryProcessRepository.save(process);
                    repositoryProcessRepository.flush();
                }

                if(repository.getImgArrValue() != null) {
                    String[] imgArrValue = repository.getImgArrValue();
                    for (int i = 0; i < imgArrValue.length; i++) {
                        String fileUrl = amazonClient.uploadFileBase64(imgArrValue[i]);
                        System.out.println(fileUrl);
                        RepositoryMedia repositoryMedia = new RepositoryMedia();
                        repositoryMedia.setMediaType(1);
                        repositoryMedia.setMediaValue(fileUrl);
                        repositoryMedia.setRepository(repository);
                        repositoryMediaRepository.save(repositoryMedia);
                        repositoryMediaRepository.flush();
                    }
                }
            }

            repositoryRepository.flush();


            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 레포지토리 삭제 처리
    @RequestMapping(value = "/repository/repositoryDelete", method = RequestMethod.POST)
    public Object repositoryDelete(Repository repository, BindingResult bindingResult) {

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
            String deleteArray = repository.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                repository = repositoryMapper.findByRepository(params);
                repository.setSeq(Integer.parseInt(seq));
                repository.setDeleteDatetime(new java.util.Date());
                repositoryRepository.save(repository);
            }
            repositoryRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    // 레포지토리 활성화 처리
    @RequestMapping(value = "/repository/activateRepository", method = RequestMethod.POST)
    public Object activateRepository(Repository repository, BindingResult bindingResult) {

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
            String chkArray = repository.getChkArray();
            String[] chkArrayList = chkArray.split("\\|");
            for(String seq : chkArrayList) {
                params.put("seq", Integer.parseInt(seq));
                repository = repositoryMapper.findByRepository(params);
                repository.setSeq(Integer.parseInt(seq));
                repository.setLastUpdate(new java.util.Date());
                repository.setStatus(0);
                repositoryRepository.save(repository);
            }
            repositoryRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 레포지토리 비활성화 처리
    @RequestMapping(value = "/repository/unActivateRepository", method = RequestMethod.POST)
    public Object unActivateRepository(Repository repository, BindingResult bindingResult) {

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
            String chkArray = repository.getChkArray();
            String[] chkArrayList = chkArray.split("\\|");
            for(String seq : chkArrayList) {
                params.put("seq", Integer.parseInt(seq));
                repository = repositoryMapper.findByRepository(params);
                repository.setSeq(Integer.parseInt(seq));
                repository.setLastUpdate(new java.util.Date());
                repository.setStatus(1);
                repositoryRepository.save(repository);
            }
            repositoryRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value = "/repository/recomm")
    public ModelAndView recommList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,ModelAndView mav
    ){

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);

        // Order value Change
        setOrderValueChange(mav, params, order);

        int totalCount = repositoryRecommMapper.countByRecomm(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<Repository> results = repositoryRecommMapper.findByRecomm(params);
        mav.addObject("results", results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);
        mav.addObject("sort", sort);

        mav.setViewName("repository/recomm");
        return mav;
    }

    // 레포지토리 삭제 처리
    @RequestMapping(value = "/repository/recommDelete", method = RequestMethod.POST)
    public Object recommDelete(RepositoryRecomm recomm, BindingResult bindingResult) {

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
            String deleteArray = recomm.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                repositoryRecommRepository.delete(Integer.parseInt(seq));
            }
            repositoryRecommRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    // 레포지토리 추천아이템 검색
    @RequestMapping(value = "/repository/recommSearch", method = RequestMethod.POST)
    public Object recommSearch(RepositoryRecomm recomm, BindingResult bindingResult) {

        Map<String, Object> map = new HashMap<>();
        List<Repository> recommList = repositoryRecommMapper.findByRecomm(map);
        ArrayList<Integer> recommSeqs = new ArrayList<>();
        for(int i=0; i<recommList.size(); i++) {
            recommSeqs.add(recommList.get(i).getSeq());
        }
        Map<String, Object> params = new HashMap<>();
        params.put("sort", recomm.getSort());
        params.put("offset", (recomm.getPage() - 1) * recomm.getRow() );
        params.put("count", recomm.getRow());

        // 추천아이템이 등록 되있는 경우에만 조회목록에서 제거
        if(recommSeqs.size() > 0) {
            params.put("recommSeqs", recommSeqs);
        }

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            result.put("result",false);
            return result;
        }

        // Order value Change
        setOrderValueChangeModal(result, params, recomm.getOrder());

        if(StringUtils.isEmpty(recomm.getStartDate())){
            String sd = null;
            params.put("startDate", sd);
        }else{
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(recomm.getStartDate(),"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(recomm.getEndDate())){
            String ed = null;
            params.put("endDate", ed);
        }else{
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(recomm.getEndDate(),"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(recomm.getSearchWord() != null && !"".equals(recomm.getSearchWord())){
            params.put("searchWord", recomm.getSearchWord());
            params.put("searchType", recomm.getSearchType());
        }

        // 비활성화된 레포지토리 미노출 처리
        params.put("activate", 0);

        int totalCount = repositoryMapper.countBySuper(params);
        result.put("no", (int) Math.ceil((double) totalCount / recomm.getRow()));
        result.put("row", recomm.getRow());

        List<Repository> results = repositoryMapper.findBySuper(params);
        result.put("resultsList", results);

        setPaginationDataModal(result, totalCount, recomm.getPage(), recomm.getRow());
        result.put("total", totalCount);
        result.put("sort", recomm.getSort());

        return result;
    }

    // 추천 아이템 등록
    @RequestMapping(value = "/repository/recommInsert", method = RequestMethod.POST)
    public Object recommInsert(RepositoryRecomm recomm, BindingResult bindingResult) {

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
            String chkArray = recomm.getChkArray();
            String[] chkArrayList = chkArray.split("\\|");
            for(String seq : chkArrayList) {
                RepositoryRecomm recommModel = new RepositoryRecomm();
                Repository repository = new Repository();
                repository.setSeq(Integer.parseInt(seq));
                recommModel.setRepository(repository);
                recommModel.setCreateDatetime(new Date());
                repositoryRecommRepository.save(recommModel);
            }
            repositoryRecommRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }
    @RequestMapping(value = "/repository/saveTest", method = RequestMethod.POST)
    public Object savetest(
            @RequestParam(value="imgArrValue") String[] imgArrValue
    ) {
//        String[] imgArrValue = repository.getImgArrValue();
        for(int i =0;i<imgArrValue.length;i++){
            String fileUrl = amazonClient.uploadFileBase64(imgArrValue[i]);
            System.out.println(fileUrl);
        }
        return true;
    }

//    @RequestMapping(value="/repository/fileDownload")
//    public void fileDownload(HttpServletRequest request, HttpServletResponse response,
//                             @RequestParam(value = "fileUrl", required = false) String fileUrl,
//                             ModelMap model) throws Exception
//    {
//        String filePath = fileUrl;
//
//        S3Object s3Object = amazonClient.downloadFile(filePath);
//        String fileNameSetting = filePath.substring(filePath.lastIndexOf("/") + 1);
//
//        String realFileName = fileStorageService.storeFile(s3Object, fileNameSetting);
//        String realPath = String.valueOf(Paths.get("./temp").toAbsolutePath().normalize());
//
//        File file = new File(realPath, realFileName);
//        String userAgent = request.getHeader("User-Agent");
//        boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
//        String fileName = null;
//
//        if (ie) {
//            fileName = URLEncoder.encode(file.getName(), "utf-8");
//        } else {
//            fileName = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
//        }
//
//        response.setContentType("application/octet-stream");
//        response.setHeader("Content-Disposition","attachment;filename=\"" +fileName+"\";");
//
//        FileInputStream fis = new FileInputStream(file);
//        BufferedInputStream bis = new BufferedInputStream(fis);
//        ServletOutputStream so = response.getOutputStream();
//        BufferedOutputStream bos = new BufferedOutputStream(so);
//
//        byte[] data = new byte[2048];
//        int input = 0;
//        while((input = bis.read(data)) != -1){
//            bos.write(data,0, input);
//            bos.flush();
//        }
//
//        if(bos != null) bos.close();
//        if(bis != null) bis.close();
//        if(so != null) so.close();
//        if(fis != null) fis.close();
//
//        file.delete();
//    }

    // 이미지 삭제 처리
    @RequestMapping(value = "/repository/imageDelete", method = RequestMethod.POST)
    public Object repositoryDelete(
            @RequestParam(value="seq") Integer seq
    ) {


        Map<String,Object> result = new HashMap<>();
        RepositoryMedia old = repositoryMediaRepository.findOne(seq);

        amazonClient.deleteFileFromS3BucketAsync(old.getMediaValue());

        repositoryMediaRepository.delete(seq);
        return responseService.getSuccessResult();

    }

    // 레포지토리 파일 삭제 처리
    @RequestMapping(value = "/repository/fileDelete", method = RequestMethod.POST)
    public Object repositoryFileDelete(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value="dType") Integer dType
    ) {


        Map<String,Object> result = new HashMap<>();
        Repository old = repositoryRepository.findOne(seq);
        if(dType == 0) { // 메뉴얼
            amazonClient.deleteFileFromS3BucketAsync(old.getManualFileUrl());
            old.setManualFileUrl("");
        }else if(dType == 1){ // 라이센스
            amazonClient.deleteFileFromS3BucketAsync(old.getLicenseFileUrl());
            old.setLicenseFileUrl("");
        }else if(dType == 2){ // 첨부파일
            amazonClient.deleteFileFromS3BucketAsync(old.getAppFileUrl());
            old.setAppFileUrl("");
        }


        repositoryRepository.save(old);
        repositoryRepository.flush();

        return responseService.getSuccessResult();

    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/repository/execlDownList")
    public Object getExeclDownList(Repository repository) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = repository.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> repositoryList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            repositoryList.add(Integer.parseInt(seq));
        }
        params.put("repositoryList", repositoryList);

        List<Repository> execlDownList = repositoryMapper.getExeclDownList(params);
        return responseService.getListResult(execlDownList.size(),execlDownList);
    }

    @GetMapping(value = "/repository/ajax_list")
    public Object repositoryAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "r.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
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
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }


        // 비활성화된 레포지토리 미노출 처리
        params.put("activate", 0);

        int totalCount = repositoryMapper.countBySuper(params);

        List<Repository> results = repositoryMapper.findBySuper(params);

        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value = "/repository/ajax_recomm")
    public Object recommAjaxList(RepositoryRecomm recomm)
    {
        Map<String, Object> map = new HashMap<>();
        List<Repository> recommList = repositoryRecommMapper.findByRecomm(map);
        ArrayList<Integer> recommSeqs = new ArrayList<>();
        for(int i=0; i<recommList.size(); i++) {
            recommSeqs.add(recommList.get(i).getSeq());
        }
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", recomm.getSort());
        params.put("offset", recomm.getPage() * recomm.getRow());
        params.put("count", recomm.getRow());
        params.put("order", recomm.getOrder());
        // 추천아이템이 등록 되있는 경우에만 조회목록에서 제거
        if(recommSeqs.size() > 0) {
            params.put("recommSeqs", recommSeqs);
        }

        int totalCount = repositoryRecommMapper.countByRecomm(params);


        List<Repository> results = repositoryRecommMapper.findByRecomm(params);


        return responseService.getListResult(totalCount,results);
    }
}
