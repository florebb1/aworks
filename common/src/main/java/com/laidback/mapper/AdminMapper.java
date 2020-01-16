package com.laidback.mapper;


import com.laidback.model.Admin;

import java.util.List;
import java.util.Map;

public interface AdminMapper {
    int count(Map<String,Object> params);
    List<Admin> find(Map<String,Object> params);
    Admin getAdmin(Integer adminId);
    Admin findInfo(Map<String, Object> params);
    Admin findByAdminInfo(String adminId);

    void save(Admin old);
}
