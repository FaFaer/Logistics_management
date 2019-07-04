package model.mapping;

import model.Goods;
import model.Role;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GoodsMappingDAO {

    @Select("SELECT COUNT(*) FROM INVENTORY WHERE INVENTORY_GOODS_CODE = (SELECT GOODS_CODE FROM GOODS WHERE GOODS_ID = #{Goods_Id})")
    public int queryForDelGoods(Goods goods);

    /**
     * 根据仓库编码查询商品库存
     * @param goods
     * @return
     */
    @Select("SELECT * FROM GOODS WHERE DOODS_WAREHOUSE = #{Doods_Warehouse}")
    public List<Goods> goodsList(Goods goods);

    /**
     * 根据商品类型查询商品
     * @param goods
     * @return
     */
    @Select("SELECT * FROM GOODS WHERE GOODS_TYPE_ID = #{Goods_Type_Id}")
    public List<Goods> goodsListforType(Goods goods);

    //商品分页,查询所有符合条件的记录
    @SelectProvider(type = GoodsMappingDAO.DoodsDaoProvider.class, method = "queryG")
    public List<Goods> queryDoods(Goods goods);

    //商品分页，查询符合条件记录的数量
    @SelectProvider(type = GoodsMappingDAO.DoodsDaoProvider.class, method = "queryGN")
    public int queryGnumbers(Goods goods);

    @Insert("INSERT INTO GOODS(GOODS_CODE,GOODS_PRICE,GOODS_NAME,GOODS_TYPE_ID) VALUES(#{Goods_Code},#{Goods_Price},#{Goods_Name},#{Goods_Type_Id})")
    public boolean addGoods(Goods goods);

    @Delete("DELETE FROM GOODS WHERE GOODS_ID=#{Goods_Id}")
    public int delGoods(Goods goods);

    class DoodsDaoProvider {
        public String queryG(Goods goods) {
            String sql = "SELECT GOODS_ID,GOODS_CODE,GOODS_PRICE,GOODS_NAME,(SELECT GOODS_NAME FROM GOODS_TYPE GT WHERE GT.GOODS_ID = G.GOODS_TYPE_ID) AS GOODS_TYPE_ID FROM GOODS G WHERE GOODS_NAME LIKE #{Goods_Name}";
            if (!"".equals(goods.getGoods_Type_Id())){
                sql+=" AND GOODS_TYPE_ID = #{Goods_Type_Id}";
            }
            sql += "limit #{Goods_Id},10;";
            return sql;
        }

        public String queryGN(Goods goods) {
            String sql = "SELECT COUNT(*) FROM GOODS WHERE GOODS_NAME LIKE #{Goods_Name}";
            if (!"".equals(goods.getGoods_Type_Id())){
                sql+=" AND GOODS_TYPE_ID = #{Goods_Type_Id}";
            }
            return sql;
        }
    }
}
