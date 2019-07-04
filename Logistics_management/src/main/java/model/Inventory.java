package model;

public class Inventory {
    private int Inventory_Id;
    private String Inventory_Code;
    private String Inventory_Goods_Code;
    private String Inventory_Goods_Name;
    private String Inventory_Warehouse_Id;
    private int Inventory_Amount;

    public Inventory() {

    }

    public int getInventory_Id() {
        return Inventory_Id;
    }

    public void setInventory_Id(int inventory_Id) {
        Inventory_Id = inventory_Id;
    }

    public String getInventory_Code() {
        return Inventory_Code;
    }

    public void setInventory_Code(String inventory_Code) {
        Inventory_Code = inventory_Code;
    }

    public String getInventory_Goods_Code() {
        return Inventory_Goods_Code;
    }

    public void setInventory_Goods_Code(String inventory_Goods_Code) {
        Inventory_Goods_Code = inventory_Goods_Code;
    }

    public String getInventory_Warehouse_Id() {
        return Inventory_Warehouse_Id;
    }

    public void setInventory_Warehouse_Id(String inventory_Warehouse_Id) {
        Inventory_Warehouse_Id = inventory_Warehouse_Id;
    }

    public String getInventory_Goods_Name() {
        return Inventory_Goods_Name;
    }

    public void setInventory_Goods_Name(String inventory_Goods_Name) {
        Inventory_Goods_Name = inventory_Goods_Name;
    }

    public int getInventory_Amount() {
        return Inventory_Amount;
    }

    public void setInventory_Amount(int inventory_Amount) {
        Inventory_Amount = inventory_Amount;
    }
}