package org.sportx.sportx.DTO;

public class ProductItemDTO {
    private int productItemId;
    private double price;
    private int qtyInStock;
    private String imageUrl;
    private String variationPairs;

    private double discountRate;      // taxa de desconto em %
    private double discountedPrice;   // preço com desconto aplicado

    public ProductItemDTO() {
    }

    public int getProductItemId() {
        return productItemId;
    }

    public void setProductItemId(int productItemId) {
        this.productItemId = productItemId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQtyInStock() {
        return qtyInStock;
    }

    public void setQtyInStock(int qtyInStock) {
        this.qtyInStock = qtyInStock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getVariationPairs() {
        return variationPairs;
    }

    public void setVariationPairs(String variationPairs) {
        this.variationPairs = variationPairs;
    }

    public double getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(double discountRate) {
        this.discountRate = discountRate;
    }

    public double getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(double discountedPrice) {
        this.discountedPrice = discountedPrice;
    }
}