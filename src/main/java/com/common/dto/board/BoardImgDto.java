package com.common.dto.board;

public class BoardImgDto {

    private int seq;
    private int board_seq;
    private String original_file;
    private String original_file_extension;
    private String stored_file_name;

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

    public String getOriginal_file() {
        return original_file;
    }

    public void setOriginal_file(String original_file) {
        this.original_file = original_file;
    }

    public String getOriginal_file_extension() {
        return original_file_extension;
    }

    public void setOriginal_file_extension(String original_file_extension) {
        this.original_file_extension = original_file_extension;
    }

    public String getStored_file_name() {
        return stored_file_name;
    }

    public void setStored_file_name(String stored_file_name) {
        this.stored_file_name = stored_file_name;
    }
}
