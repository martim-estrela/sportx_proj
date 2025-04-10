package model;

public class PaymentType {
    private int paymentTypeId;
    private double value;

    // Getters, Setters, Construtor
    public PaymentType(int paymentTypeId, double value) {
        this.paymentTypeId = paymentTypeId;
        this.value = value;
    }

    public int getPaymentTypeId() {
        return paymentTypeId;
    }

    public void setPaymentTypeId(int paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
}
