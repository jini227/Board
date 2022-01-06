package com.common.dto.board;

public class BoardCommentDto {
    private int seq;
    private int board_seq;
    private int member_seq;
    private String memo;
    private String writer;
    private String reg_date;

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public int getBoard_seq() {
        return board_seq;
    }

    public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }

    public int getMember_seq() {
        return member_seq;
    }

    public void setMember_seq(int member_seq) {
        this.member_seq = member_seq;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getReg_date() {
        return reg_date;
    }

    public void setReg_date(String reg_date) {
        this.reg_date = reg_date;
    }
}
