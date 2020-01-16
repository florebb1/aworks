package com.laidback.mapper;

import com.laidback.model.ComContractAccruedPayment;
import com.laidback.model.ComContractPayment;

import java.util.List;
import java.util.Map;

public interface ComContractAccruedPaymentMapper {

    int count(Map<String, Object> params);

    List<ComContractAccruedPayment> find(Map<String, Object> params);

    void updateAccruedPayment(ComContractAccruedPayment ccap);

    ComContractAccruedPayment findBySeq(Map<String, Object> params);
}
