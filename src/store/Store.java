package store;

public class Store {
    private int storeId;
    private String name;
    private String addre1;
    private String addre2;
    private String addre3;
    private String phone;
    private String website;
    private String ownerId;

    public Store() {
    }

    public Store(String name, String addre1, String addre2, String addre3, String phone, String website) {
        this.name = name;
        this.addre1 = addre1;
        this.addre2 = addre2;
        this.addre3 = addre3;
        this.phone = phone;
        this.website = website;
    }

    public Store(int storeId, String name, String addre1, String addre2, String addre3, String phone, String website, String ownerId) {
        this.storeId = storeId;
        this.name = name;
        this.addre1 = addre1;
        this.addre2 = addre2;
        this.addre3 = addre3;
        this.phone = phone;
        this.website = website;
        this.ownerId = ownerId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddre1() {
        return addre1;
    }

    public void setAddre1(String addre1) {
        this.addre1 = addre1;
    }

    public String getAddre2() {
        return addre2;
    }

    public void setAddre2(String addre2) {
        this.addre2 = addre2;
    }

    public String getAddre3() {
        return addre3;
    }

    public void setAddre3(String addre3) {
        this.addre3 = addre3;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }
}
