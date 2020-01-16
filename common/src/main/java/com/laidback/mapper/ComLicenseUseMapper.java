package com.laidback.mapper;

import java.util.Map;

public interface ComLicenseUseMapper {
    int getMacAddress(Map<String,Object> params);
    int dupleName(Map<String,Object> params);
}
