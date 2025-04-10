package model;

public class OrderStatus {
    private int orderStatusId;
    private String status;

    // Getters, Setters, Construtor
    public OrderStatus(int orderStatusId, String status) {
        this.orderStatusId = orderStatusId;
        this.status = status;
    }

    public int getOrderStatusId() {
        return orderStatusId;
    }

    public void setOrderStatusId(int orderStatusId) {
        this.orderStatusId = orderStatusId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
