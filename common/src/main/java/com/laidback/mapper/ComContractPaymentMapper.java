package com.laidback.mapper;

import com.laidback.model.ComContractPayment;

import java.util.List;
import java.util.Map;

public interface ComContractPaymentMapper {

    int count(Map<String, Object> params);

    List<ComContractPayment> find(Map<String, Object> params);

    void updatePayment(ComContractPayment ccp);

    ComContractPayment findBySeq(Map<String, Object> params);
}
