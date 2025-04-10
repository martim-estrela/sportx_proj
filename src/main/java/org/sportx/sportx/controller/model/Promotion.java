package model;
import java.time.*;

public class Promotion {
    private int promotionId;
    private String name;
    private String description;
    private double discountRate;
    private LocalDate startDate;
    private LocalDate endDate;

    // Getters, Setters, Construtor
    public Promotion(int promotionId, String name, String description, double discountRate, LocalDate startDate, LocalDate endDate) {
        this.promotionId = promotionId;
        this.name = name;
        this.description = description;
        this.discountRate = discountRate;
        this.startDate = startDate;
        this.endDate = endDate;
    }


    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(double discountRate) {
        this.discountRate = discountRate;
    }


    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    // Método para verificar se a promoção está ativa
    public boolean isActive() {
        LocalDate today = LocalDate.now();
        return today.isAfter(startDate) && today.isBefore(endDate);
    }

    // Método para aplicar o desconto ao preço
    public double applyDiscount(double originalPrice) {
        if (isActive()) {
            return originalPrice - (originalPrice * discountRate / 100);  // Desconto em porcentagem
        }
        return originalPrice;  // Se a promoção não está ativa, retorna o preço original
    }
}


