package com.laidback.response;

import java.util.List;

public class ListResult<T> extends CommonListResult {
    private List<T> list;

    public List<T> getList() {
        return list;
    }
    public void setList(List<T> list) {
        this.list = list;
    }
}
