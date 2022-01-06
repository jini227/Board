package com.common.dto.enter;

public class SignUpDto {
    private int seq;
    private String id;
    private String password;
    private String name;
    private String phone;
    private String email;
    private String pwdChk;
    private String passwordCurrentChk;
    private String passwordNew;
    private String passwordNewConfirm;
    private String salt;

    public SignUpDto() {

    }

    public SignUpDto(String id, String password, String name, String phone, String email, String salt) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.salt = salt;
    }

    public boolean isPasswordEqual() {
        return password.equals(pwdChk);
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getPwdChk() {
        return pwdChk;
    }

    public void setPwdChk(String pwdChk) {
        this.pwdChk = pwdChk;
    }

    public String getPasswordCurrentChk() {
        return passwordCurrentChk;
    }

    public void setPasswordCurrentChk(String passwordCurrentChk) {
        this.passwordCurrentChk = passwordCurrentChk;
    }

    public String getPasswordNew() {
        return passwordNew;
    }

    public void setPasswordNew(String passwordNew) {
        this.passwordNew = passwordNew;
    }

    public String getPasswordNewConfirm() {
        return passwordNewConfirm;
    }

    public void setPasswordNewConfirm(String passwordNewConfirm) {
        this.passwordNewConfirm = passwordNewConfirm;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
}
