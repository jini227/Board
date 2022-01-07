package com.common.dto.board;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class BoardDto {
    private int seq;
    private int member_seq;
    private String contents_type;
    private String title;
    private String pet_location;
    private String pet_time;
    private String pet_type;
    private String pet_name;
    private String pet_gender;
    private String pet_memo;
    private int pet_meet;
    private String phone_public;
    private String email_public;
    private String writer;
    private String phone;
    private String email;
    private String review;
    private int hit;
    private String reg_date;
    private String thumbnail_file_name;
    private String term;
    private int commentNum;

    private String state;
    private String searchKeyword;
    private String searchOption;

    private String keyword;
    private int rowStart;
    private int rowEnd;
    private boolean isPrev;
    private boolean isNext;
    private int startPage;
    private int endPage;

    private MultipartFile[] img;
    private List<BoardImgDto> images;
    private List<BoardCommentDto> comments;
    private String[] modifyFile;

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public int getMember_seq() {
        return member_seq;
    }

    public void setMember_seq(int member_seq) {
        this.member_seq = member_seq;
    }

    public String getContents_type() {
        return contents_type;
    }

    public void setContents_type(String contents_type) {
        this.contents_type = contents_type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPet_location() {
        return pet_location;
    }

    public void setPet_location(String pet_location) {
        this.pet_location = pet_location;
    }

    public String getPet_time() {
        return pet_time;
    }

    public void setPet_time(String pet_time) {
        this.pet_time = pet_time;
    }

    public String getPet_type() {
        return pet_type;
    }

    public void setPet_type(String pet_type) {
        this.pet_type = pet_type;
    }

    public String getPet_name() {
        return pet_name;
    }

    public void setPet_name(String pet_name) {
        this.pet_name = pet_name;
    }

    public String getPet_gender() {
        return pet_gender;
    }

    public void setPet_gender(String pet_gender) {
        this.pet_gender = pet_gender;
    }

    public String getPet_memo() {
        return pet_memo;
    }

    public void setPet_memo(String pet_memo) {
        this.pet_memo = pet_memo;
    }

    public int getPet_meet() {
        return pet_meet;
    }

    public void setPet_meet(int pet_meet) {
        this.pet_meet = pet_meet;
    }

    public String getPhone_public() {
        return phone_public;
    }

    public void setPhone_public(String phone_public) {
        this.phone_public = phone_public;
    }

    public String getEmail_public() {
        return email_public;
    }

    public void setEmail_public(String email_public) {
        this.email_public = email_public;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public String getReg_date() {
        return reg_date;
    }

    public void setReg_date(String reg_date) {
        this.reg_date = reg_date;
    }

    public String getThumbnail_file_name() {
        return thumbnail_file_name;
    }

    public void setThumbnail_file_name(String thumbnail_file_name) {
        this.thumbnail_file_name = thumbnail_file_name;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchOption() {
        return searchOption;
    }

    public void setSearchOption(String searchOption) {
        this.searchOption = searchOption;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getRowStart() {
        return rowStart;
    }

    public void setRowStart(int rowStart) {
        this.rowStart = rowStart;
    }

    public int getRowEnd() {
        return rowEnd;
    }

    public void setRowEnd(int rowEnd) {
        this.rowEnd = rowEnd;
    }

    public boolean isPrev() {
        return isPrev;
    }

    public void setPrev(boolean prev) {
        isPrev = prev;
    }

    public boolean isNext() {
        return isNext;
    }

    public void setNext(boolean next) {
        isNext = next;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public MultipartFile[] getImg() {
        return img;
    }

    public void setImg(MultipartFile[] img) {
        this.img = img;
    }

    public List<BoardImgDto> getImages() {
        return images;
    }

    public void setImages(List<BoardImgDto> images) {
        this.images = images;
    }

    public List<BoardCommentDto> getComments() {
        return comments;
    }

    public void setComments(List<BoardCommentDto> comments) {
        this.comments = comments;
    }

    public String[] getModifyFile() {
        return modifyFile;
    }

    public void setModifyFile(String[] modifyFile) {
        this.modifyFile = modifyFile;
    }
}
