package org.sportx.sportx.DTO;

import java.util.Date; // Changed from java.time.LocalDate
import java.util.List;

public class OrderHistoryDTO {
    private int orderId;
    private Date orderDate; // Changed from LocalDate to Date
    private double orderTotal;
    private String orderStatus;
    private String shippingMethod;
    private String shippingAddress;
    private String firstProductImage;
    private int totalItems;
    private List<OrderItemDTO> orderItems;

    // Constructor
    public OrderHistoryDTO() {
    }

    public OrderHistoryDTO(int orderId, Date orderDate, double orderTotal,
                           String orderStatus, String shippingMethod, String shippingAddress,
                           String firstProductImage, int totalItems) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.orderTotal = orderTotal;
        this.orderStatus = orderStatus;
        this.shippingMethod = shippingMethod;
        this.shippingAddress = shippingAddress;
        this.firstProductImage = firstProductImage;
        this.totalItems = totalItems;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(double orderTotal) {
        this.orderTotal = orderTotal;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getFirstProductImage() {
        return firstProductImage;
    }

    public void setFirstProductImage(String firstProductImage) {
        this.firstProductImage = firstProductImage;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public List<OrderItemDTO> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemDTO> orderItems) {
        this.orderItems = orderItems;
    }
}