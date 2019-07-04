package model.mapping;

import model.Goods;
import model.Inventory;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface InventoryMappingDAO {

    // 库存信息分页,查询所有符合条件的记录
    @SelectProvider(type = InventoryMappingDAO.InventoryDaoProvider.class, method = "queryI")
    public List<Inventory> queryInventoryL(Inventory inventory);

    // 库存信息分页，查询符合条件记录的数量
    @SelectProvider(type = InventoryMappingDAO.InventoryDaoProvider.class, method = "queryIN")
    public int queryInventoryN(Inventory inventory);

    // 查看该仓库中是否已经有改样商品，如果有跟新，反之则新增
    @Select("SELECT * FROM INVENTORY WHERE INVENTORY_GOODS_CODE = #{Inventory_Goods_Code} AND INVENTORY_WAREHOUSE_ID = #{Inventory_Warehouse_Id}")
    public List<Inventory> queryPreAdd(Inventory inventory);

    @Update("UPDATE INVENTORY SET INVENTORY_AMOUNT = #{Inventory_Amount} WHERE INVENTORY_CODE = #{Inventory_Code}")
    public boolean updateInventory(Inventory inventory);

    // 入库，在入库表添加记录
    @Insert("INSERT INTO INVENTORY(INVENTORY_CODE,INVENTORY_GOODS_CODE,INVENTORY_GOODS_NAME,INVENTORY_WAREHOUSE_ID,INVENTORY_AMOUNT) VALUES(#{Inventory_Code},#{Inventory_Goods_Code},(SELECT GOODS_NAME FROM GOODS WHERE GOODS_CODE = #{Inventory_Goods_Code}),#{Inventory_Warehouse_Id},#{Inventory_Amount})")
    public boolean addInventory(Inventory inventory);

    @Delete("DELETE FROM GOODS WHERE GOODS_ID=#{Goods_Id}")
    public int delGoodsType(Inventory inventory);

    class InventoryDaoProvider {
        public String queryI(Inventory inventory) {
            String sql = "SELECT INVENTORY_CODE,INVENTORY_GOODS_CODE,INVENTORY_GOODS_NAME,(SELECT WAREHOUSE_NAME FROM WAREHOUSE WHERE WAREHOUSE_ID = INVENTORY_WAREHOUSE_ID) AS INVENTORY_WAREHOUSE_ID,INVENTORY_AMOUNT FROM  INVENTORY WHERE INVENTORY_GOODS_NAME LIKE #{Inventory_Goods_Name}";
            if (!"".equals(inventory.getInventory_Warehouse_Id())) {
                sql += " AND INVENTORY_WAREHOUSE_ID = #{Inventory_Warehouse_Id}";
            }
            sql += "limit #{Inventory_Id},10;";
            return sql;
        }

        public String queryIN(Inventory inventory) {
            String sql = "SELECT COUNT(*) FROM  INVENTORY WHERE INVENTORY_GOODS_NAME LIKE #{Inventory_Goods_Name}";
            if (!"".equals(inventory.getInventory_Warehouse_Id())) {
                sql += " AND INVENTORY_WAREHOUSE_ID = #{Inventory_Warehouse_Id}";
            }
            return sql;
        }
    }
}
