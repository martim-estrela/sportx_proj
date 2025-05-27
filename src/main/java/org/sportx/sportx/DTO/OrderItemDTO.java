package org.sportx.sportx.DTO;

public class OrderItemDTO {
    private int orderLineId;
    private String productName;
    private String productImage;
    private int quantity;
    private double productPrice;
    private double subtotal;
    private String variationPairs;

    // Constructor
    public OrderItemDTO() {
    }

    public OrderItemDTO(int orderLineId, String productName, String productImage,
                        int quantity, double productPrice, double subtotal, String variationPairs) {
        this.orderLineId = orderLineId;
        this.productName = productName;
        this.productImage = productImage;
        this.quantity = quantity;
        this.productPrice = productPrice;
        this.subtotal = subtotal;
        this.variationPairs = variationPairs;
    }

    // Getters and Setters
    public int getOrderLineId() {
        return orderLineId;
    }

    public void setOrderLineId(int orderLineId) {
        this.orderLineId = orderLineId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public String getVariationPairs() {
        return variationPairs;
    }

    public void setVariationPairs(String variationPairs) {
        this.variationPairs = variationPairs;
    }
}