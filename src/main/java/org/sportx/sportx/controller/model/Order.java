package model;
import java.time.LocalDate;

public class Order {
    private int orderId;
    private LocalDate orderDate;
    private double orderTotal;
    private String country;
    private String city;
    private String postalCode;
    private AddressInfo address;
    private OrderStatus orderStatus;

    // Getters, Setters, Construtor
    public Order(int orderId, LocalDate orderDate, double orderTotal, AddressInfo address, OrderStatus orderStatus) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.orderTotal = orderTotal;
        this.address = address;
        this.orderStatus = orderStatus;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public double getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(double orderTotal) {
        this.orderTotal = orderTotal;
    }

    public AddressInfo getAddress() {
        return address;
    }

    public void setAddress(AddressInfo address) {
        this.address = address;
    }


    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public boolean isShipped() {
        return "shipped".equalsIgnoreCase(orderStatus.getStatus());
    }

    public void updateStatus(OrderStatus newStatus) {
        this.orderStatus = newStatus;
    }

    public double calculateTotalWithShipping(double shippingCost) {
        return this.orderTotal + shippingCost;
    }
}
