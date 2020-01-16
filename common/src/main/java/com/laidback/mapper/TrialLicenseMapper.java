package com.laidback.mapper;

import com.laidback.model.TrialLicense;

import java.util.Map;

public interface TrialLicenseMapper {
    int count(int trialUserSeq);
    TrialLicense find(Map<String, Object> params);
    TrialLicense findByLicense(Map<String, Object> params);
    int findByCount(Map<String, Object> params);
    int findBySeq(int trialUserSeq);
}
