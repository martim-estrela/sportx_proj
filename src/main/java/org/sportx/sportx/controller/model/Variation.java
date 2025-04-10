package model;

public class Variation {
    private int variationId;
    private String name;

    // Getters, Setters, Construtor
    public Variation(int variationId, String name) {
        this.variationId = variationId;
        this.name = name;
    }

    public int getVariationId() {
        return variationId;
    }

    public void setVariationId(int variationId) {
        this.variationId = variationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
