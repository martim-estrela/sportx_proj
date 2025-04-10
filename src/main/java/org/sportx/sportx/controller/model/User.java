package model;

import java.time.LocalDate;

public class User {
    private int userId;
    private String email;
    private String password;
    private String phoneNumber;
    private String name;
    private String userType;
    private LocalDate registerDate;

    // Construtor
    public User(int userId, String email, String password, String phoneNumber, String name, String userType, LocalDate registerDate) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.name = name;
        this.userType = userType;
        this.registerDate = registerDate;
    }

    // Getters e Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public LocalDate getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(LocalDate registerDate) {
        this.registerDate = registerDate;
    }

    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.userType);
    }

    public void changePassword(String newPassword) {
        this.password = newPassword;
    }

    public void updateProfile(String newEmail, String newPhoneNumber) {
        this.email = newEmail;
        this.phoneNumber = newPhoneNumber;
    }
}

