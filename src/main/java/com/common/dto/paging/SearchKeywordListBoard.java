package com.common.dto.paging;

public class SearchKeywordListBoard extends CriteriaMainBoard {

    private String searchKeyword = "";

    public String getSearchKeyword() {
        return searchKeyword;
    }
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    @Override
    public String toString() {
        return super.toString() + " SearchCriteria [searchKeyword=" + searchKeyword + "]";
    }
    public String reset() {
        searchKeyword = "";
        return searchKeyword;
    }
}
