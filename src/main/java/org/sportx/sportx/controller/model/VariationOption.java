package model;

public class VariationOption {
    private int variationOptionId;
    private String value;

    // Getters, Setters, Construtor
    public VariationOption(int variationOptionId, String value) {
        this.variationOptionId = variationOptionId;
        this.value = value;
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
}
