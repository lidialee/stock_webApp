package store;

public class Store {

    private int ownerId;
    private String ownerLoginId;
    private String ownerPass;
    private String ownerName;
    private String ownerPhone;


    public String getOwnerLoginId() {
        return ownerLoginId;
    }

    public void setOwnerLoginId(String ownerLoginId) {
        this.ownerLoginId = ownerLoginId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getOwnerPass() {
        return ownerPass;
    }

    public void setOwnerPass(String ownerPass) {
        this.ownerPass = ownerPass;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerPhone() {
        return ownerPhone;
    }

    public void setOwnerPhone(String ownerPhone) {
        this.ownerPhone = ownerPhone;
    }
}
