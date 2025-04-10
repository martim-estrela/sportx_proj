package model;

public class PaymentInfo {
    private int paymentInfoId;
    private String cardNumber;
    private String expDate;

    // Getters, Setters, Construtor
    public PaymentInfo(int paymentInfoId, String cardNumber, String expDate) {
        this.paymentInfoId = paymentInfoId;
        this.cardNumber = cardNumber;
        this.expDate = expDate;
    }

    public int getPaymentInfoId() {
        return paymentInfoId;
    }

    public void setPaymentInfoId(int paymentInfoId) {
        this.paymentInfoId = paymentInfoId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpDate() {
        return expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public boolean isCardValid() {
        return expDate.compareTo("2025-01") > 0;
    }

    public String maskCardNumber() {
        return "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
    }

    public boolean validateExpiryDate() {
        String[] dateParts = expDate.split("-");
        int year = Integer.parseInt(dateParts[0]);
        int month = Integer.parseInt(dateParts[1]);
        return (year > 2025) || (year == 2025 && month > 1);
    }
}
