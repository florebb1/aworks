package com.laidback.mapper;


import com.laidback.model.ComContract;
import com.laidback.model.ComLicense;
import com.laidback.model.Company;

import java.util.List;
import java.util.Map;

public interface ComContractMapper {
    List<Company> searchForContHistory(Map<String, Object> params);

    ComContract findByContractCompanyInfo(Map<String, Object> params);
    ComContract findOne(Map<String, Object> params);

    List<ComContract> findByCompany(Integer comSeq);
    int count(Map<String,Object> params);
    List<ComContract> find(Map<String,Object> params);

    int getLast(String dateStr);
    int findByContractNumber(String contractNumber);

    int getAllUse(Integer seq);
    List<ComLicense> getExeclDownList(Map<String, Object> params);

    int userCount(Integer userSeq);
}
