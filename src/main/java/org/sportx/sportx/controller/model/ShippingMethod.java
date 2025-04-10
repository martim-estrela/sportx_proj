package model;

public class ShippingMethod {
    private int shippingId;
    private String name;
    private double price;

    // Getters, Setters, Construtor
    public ShippingMethod(int shippingId, String name, double price) {
        this.shippingId = shippingId;
        this.name = name;
        this.price = price;
    }

    public int getShippingId() {
        return shippingId;
    }

    public void setShippingId(int shippingId) {
        this.shippingId = shippingId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
