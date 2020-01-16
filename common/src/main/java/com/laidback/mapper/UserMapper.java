package com.laidback.mapper;

import com.laidback.model.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int count(Map<String,Object> params);
    List<User> find(Map<String,Object> params);
    int loginIdChk(Map<String, Object> params);
    int loginPwChk(Map<String, Object> params);
    List<User> getUserList();

    User findByContractPerson(Integer contractPerson);
    User findPw(Map<String, Object> params);
    User findByUser(Map<String, Object> params);
    int findBySeq(String loginId);

    User getTotalUserCnt();

    List<User> userNameSearch(Map<String, Object> params);

    List<User> getExeclDownList(Map<String, Object> params);
}
