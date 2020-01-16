package com.laidback.mapper;

import com.laidback.model.ComLicense;
import com.laidback.model.ComLicenseUse;


import java.util.List;
import java.util.Map;

public interface ComLicenseMapper {
    int count(Map<String,Object> params);
    List<ComLicense> find(Map<String,Object> params);
    ComLicense getComLicense(Integer seq);

    ComLicense findByLicense(Map<String, Object> params);

    List<ComLicenseUse> getComLicenseUses(Map<String, Object> params);
    List<ComLicenseUse> getComLicenseUsesTotal(Integer seq);
    List<ComLicense> getExeclDownList(Map<String, Object> params);
    int getComLicenseUsesCount(Integer comLicense);

}
