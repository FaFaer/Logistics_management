package model.mapping;

import model.Clientele;
import model.Inventory;
import model.Warehouse;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface WarehouseMappingDAO {

    // 插入
    @Insert("insert into WAREHOUSE(WAREHOUSE_CODE,WAREHOUSE_NAME,PROVINCE,CITY,DISTRICT,WAREHOUSE_ADDRESS,WAREHOUSE_KEEPER,WAREHOUSE_TEL,CREATE_USER_ID,CREATE_TIME,UPDATE_TIME) " +
            "values (#{Warehouse_Code},#{Warehouse_Name},#{Province},#{City},#{District},#{Warehouse_Address},#{Warehouse_Keeper},#{Warehouse_Tel},#{Create_User_Id},now(),now())")
    public boolean savewarehouse(Warehouse warehouse);

    // 客户信息分页,查询所有符合条件的记录
    @SelectProvider(type = WarehouseDaoProvider.class, method = "queryW")
    public List<Warehouse> querywarehouse(Warehouse warehouse);

    // 客户信息分页，查询符合条件记录的数量
    @SelectProvider(type = WarehouseDaoProvider.class, method = "queryWN")
    public int querywarehousenumber(Warehouse warehouse);

    @Delete("DELETE FROM WAREHOUSE WHERE WAREHOUSE_CODE = #{Warehouse_Code}")
    public int deleteWarehouse(Warehouse warehouse);

    @Select("SELECT FROM INVENTORY WHERE INVENTORY_WAREHOUSE_ID = (SELECT WAREHOUSE_ID FROM WAREHOUSE WHERE WAREHOUSE_CODE = #{Warehouse_Code})")
    public int queryForDelwarehouse(Warehouse warehouse);

    @Select("SELECT WAREHOUSE_CODE,WAREHOUSE_NAME,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.PROVINCE) AS PROVINCE,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.CITY) AS CITY," +
            "(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.DISTRICT) AS DISTRICT,WAREHOUSE_ADDRESS,(SELECT USER_NAME FROM USERS WHERE USER_ID = W.WAREHOUSE_KEEPER) AS WAREHOUSE_KEEPER,WAREHOUSE_TEL,CREATE_USER_ID,CREATE_TIME,UPDATE_TIME" +
            " FROM WAREHOUSE W WHERE WAREHOUSE_CODE = #{Warehouse_Code}")
    public Warehouse selectWOnly(Warehouse warehouse);

    @UpdateProvider(type = WarehouseDaoProvider.class, method = "updateW")
    public int updatewarehouse(Warehouse warehouse);

    @Select("SELECT CLIENTELE_WAREHOUSE FROM CLIENTELE WHERE CLIENTELE_CODE = #{Clientele_Code}")
    public String AddorderTo(Clientele clientele);

    class WarehouseDaoProvider {
        public String updateW(Warehouse warehouse) {
            String sql = "UPDATE WAREHOUSE SET WAREHOUSE_NAME = #{Warehouse_Name},WAREHOUSE_TEL = #{Warehouse_Tel},WAREHOUSE_ADDRESS=#{Warehouse_Address}";
            if (!"null".equals(warehouse.getWarehouse_Keeper())) {
                sql += " ,WAREHOUSE_KEEPER = #{Warehouse_Keeper} ";
            }
            sql += " WHERE WAREHOUSE_CODE = #{Warehouse_Code}";
            return sql;
        }


        // 分页查询
        public String queryW(Warehouse warehouse) {
            String sql = "SELECT WAREHOUSE_CODE,WAREHOUSE_NAME,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.PROVINCE) AS PROVINCE,(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.CITY) AS CITY," +
                    "(SELECT CHINA_NAME FROM CHINA WHERE CHINA_ID = W.DISTRICT) AS DISTRICT,WAREHOUSE_ADDRESS,(SELECT USER_NAME FROM USERS WHERE USER_ID = W.WAREHOUSE_KEEPER) AS WAREHOUSE_KEEPER,WAREHOUSE_TEL,(SELECT USER_NAME FROM USERS WHERE USER_ID = W.CREATE_USER_ID) AS CREATE_USER_ID,CREATE_TIME,UPDATE_TIME " +
                    "FROM WAREHOUSE W WHERE WAREHOUSE_NAME LIKE #{Warehouse_Name} AND WAREHOUSE_ADDRESS LIKE #{Warehouse_Address}";
            if (!"".equals(warehouse.getProvince())) {
                sql += " AND PROVINCE = #{Province}";
            }
            if (!"".equals(warehouse.getCity())) {
                sql += " AND CITY=#{Ciy}";
            }
            if (!"".equals(warehouse.getDistrict())) {
                sql += " ADN DISTRICT = #{District}";
            }
            sql += " limit #{Warehouse_Id},10;";
            return sql;
        }

        // 分夜查数量
        public String queryWN(Warehouse warehouse) {
            String sql = "SELECT COUNT(*) FROM WAREHOUSE WHERE WAREHOUSE_NAME LIKE #{Warehouse_Name} AND WAREHOUSE_ADDRESS LIKE #{Warehouse_Address}";
            if (!"".equals(warehouse.getProvince())) {
                sql += " AND PROVINCE = #{Province}";
            }
            if (!"".equals(warehouse.getCity())) {
                sql += " AND CITY=#{Ciy}";
            }
            if (!"".equals(warehouse.getDistrict())) {
                sql += " ADN DISTRICT = #{District}";
            }
            return sql;
        }
    }
}
