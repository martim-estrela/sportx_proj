package org.sportx.sportx.model;

public class VariationOption {
    private int variationOptionId;
    private String value;
    private int variationTypeId;
    private String variationName; // "Color" ou "Size"

    // Getters, Setters, Construtor
    public VariationOption(int variationOptionId, String value, int variationTypeId,  String variationName) {
        this.variationOptionId = variationOptionId;
        this.value = value;
        this.variationTypeId = variationTypeId;
        this.variationName = variationName;
    }

    public int getVariationOptionId() {
        return variationOptionId;
    }

    public void setVariationOptionId(int variationOptionId) {
        this.variationOptionId = variationOptionId;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    public int getVariationTypeId() {
        return variationTypeId;
    }
    public void setVariationTypeId(int variationTypeId) {
        this.variationTypeId = variationTypeId;
    }
    public String getVariationName() {
        return variationName;
    }
    public void setVariationName(String variationName) {
        this.variationName = variationName;
    }
}
