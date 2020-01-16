package com.laidback.mapper;

import com.laidback.model.Company;

import java.util.List;
import java.util.Map;

public interface CompanyMapper {
    int count(Map<String,Object> params);
    List<Company> find(Map<String,Object> params);
    List<Company> findAll();

    Company saveForCompanyInfo(Company company);

    Company findByCompany(Map<String, Object> params);

    List<Company> searchForCompanyList(Map<String, Object> params);

    List<Company> companyNameSearch(Map<String, Object> params);

    List<Company> getExeclDownList(Map<String, Object> params);

    Company findByCompanySeq(Map<String, Object> params);abstract
    int getAllUse(Integer seq);
    int dupleName(String comName);
}
