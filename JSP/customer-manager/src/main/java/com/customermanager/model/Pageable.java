package com.customermanager.model;

public class Pageable {
    private int page = 1;
    private int limit = 5;
    private String keyword = "";
    private String sortField = "name";
    private String order = "asc";
    private int type = -1;
    private int totalPage;

    public Pageable() {
    }

    public Pageable(int page, int limit, String keyword, String sortField, String order, int type, int totalPage) {
        this.page = page;
        this.limit = limit;
        this.keyword = keyword;
        this.sortField = sortField;
        this.order = order;
        this.type = type;
        this.totalPage = totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
}
