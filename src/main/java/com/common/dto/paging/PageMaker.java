package com.common.dto.paging;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class PageMaker {

    private int totalCount;
    private int incompleteCount;
    private int completeCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;

    private int displayPageNum = 10;

    private Criteria cri;

    public void setCri(Criteria cri) {
        this.cri = cri;
    }

    public void setIncompleteCount(int incompleteCount) {
        this.incompleteCount = incompleteCount;
        incompleteCalcData();
    }
    public void setCompleteCount(int completeCount) {
        this.completeCount = completeCount;
        completeCalcData();
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }

    public int getIncompleteCount() {
        return incompleteCount;
    }

    public int getCompleteCount() {
        return completeCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public int getStartPage() {
        return startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public boolean isNext() {
        return next;
    }

    public int getDisplayPageNum() {
        return displayPageNum;
    }

    public Criteria getCri() {
        return cri;
    }

    private void incompleteCalcData() {
        endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) + 1;

        int tempEndPage = (int) (Math.ceil(incompleteCount / (double)cri.getPerPageNum()));
        if (endPage > tempEndPage){
            endPage = tempEndPage;
        }
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() >= incompleteCount ? false : true;
    }
    private void completeCalcData() {
        endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) + 1;

        int tempEndPage = (int) (Math.ceil(completeCount / (double)cri.getPerPageNum()));
        if (endPage > tempEndPage){
            endPage = tempEndPage;
        }
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() >= completeCount ? false : true;
    }
    private void calcData() {
        endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) + 1;

        int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
        if (endPage > tempEndPage){
            endPage = tempEndPage;
        }
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
    }

    public String makeQuery(int page){
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
//				.queryParam("from",encoding(((DateSearchCommand)cri).getFrom()))
//				.queryParam("to", encoding(((DateSearchCommand)cri).getTo()))
                .build();
        return uriComponents.toUriString();
    }

    public String makeSearch(int page){
        System.out.println("오니?" + page);
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
                .build();
        ((SearchCriteria)cri).reset();
        return uriComponents.toUriString();
    }

    private String encoding(String keyword) {
        if(keyword == null || keyword.trim().length() == 0){
            return "";
        }
        try {
            return URLEncoder.encode(keyword, "UTF-8");
        }
        catch(UnsupportedEncodingException e){
            return ""; }
    }


}
