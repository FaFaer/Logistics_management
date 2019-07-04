package model;

public class Warehouse {
    private int Warehouse_Id;
    private String Warehouse_Code;
    private String Warehouse_Name;
    private String Province;
    private String City;
    private String District;
    private String Warehouse_Address;
    private String Warehouse_Keeper;
    private String Warehouse_Tel;
    private String Create_User_Id;
    private String Create_Time;
    private String Update_Time;

    public Warehouse() {

    }

    public String getWarehouse_Code() {
        return Warehouse_Code;
    }

    public void setWarehouse_Code(String warehouse_Code) {
        Warehouse_Code = warehouse_Code;
    }

    public int getWarehouse_Id() {
        return Warehouse_Id;
    }

    public void setWarehouse_Id(int warehouse_Id) {
        Warehouse_Id = warehouse_Id;
    }

    public String getWarehouse_Name() {
        return Warehouse_Name;
    }

    public void setWarehouse_Name(String warehouse_Name) {
        Warehouse_Name = warehouse_Name;
    }

    public String getProvince() {
        return Province;
    }

    public void setProvince(String province) {
        Province = province;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String city) {
        City = city;
    }

    public String getDistrict() {
        return District;
    }

    public void setDistrict(String district) {
        District = district;
    }

    public String getWarehouse_Address() {
        return Warehouse_Address;
    }

    public void setWarehouse_Address(String warehouse_Address) {
        Warehouse_Address = warehouse_Address;
    }

    public String getWarehouse_Keeper() {
        return Warehouse_Keeper;
    }

    public void setWarehouse_Keeper(String warehouse_Keeper) {
        Warehouse_Keeper = warehouse_Keeper;
    }

    public String getWarehouse_Tel() {
        return Warehouse_Tel;
    }

    public void setWarehouse_Tel(String warehouse_Tel) {
        Warehouse_Tel = warehouse_Tel;
    }

    public String getCreate_User_Id() {
        return Create_User_Id;
    }

    public void setCreate_User_Id(String create_User_Id) {
        Create_User_Id = create_User_Id;
    }

    public String getCreate_Time() {
        return Create_Time;
    }

    public void setCreate_Time(String create_Time) {
        Create_Time = create_Time;
    }

    public String getUpdate_Time() {
        return Update_Time;
    }

    public void setUpdate_Time(String update_Time) {
        Update_Time = update_Time;
    }
}