package model;

public class AddressInfo {
    private int addressId;
    private String street;
    private String country;
    private String city;
    private String postalCode;

    // Getters, Setters, Construtor
    public AddressInfo(int addressId, String street, String country, String city, String postalCode) {
        this.addressId = addressId;
        this.street = street;
        this.country = country;
        this.city = city;
        this.postalCode = postalCode;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }
}
