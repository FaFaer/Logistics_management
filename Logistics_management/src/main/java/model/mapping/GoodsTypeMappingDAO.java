package model.mapping;

import model.Goods_type;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GoodsTypeMappingDAO {

    @Select("SELECT * FROM GOODS_TYPE")
    public List<Goods_type> GOODS_TYPE_LIST();
    
    //商品类型信息分页,查询所有符合条件的记录
    @SelectProvider(type = GoodsTypeMappingDAO.Doods_typeDaoProvider.class, method = "queryG")
    public List<Goods_type> queryDoods_type(Goods_type goods_type);

    //商品类型信息分页，查询符合条件记录的数量
    @SelectProvider(type = GoodsTypeMappingDAO.Doods_typeDaoProvider.class, method = "queryGN")
    public int queryGnumbers(Goods_type goods_type);

    @Insert("INSERT INTO GOODS_TYPE(GOODS_CODE,GOODS_NAME) VALUES(#{Goods_Code},#{Goods_Name})")
    public boolean addGoodsType(Goods_type goods_type);

    @Delete("DELETE FROM GOODS_TYPE WHERE GOODS_ID=#{Goods_Id}")
    public int delGoodsType(Goods_type goods_type);

    @Select("SELECT COUNT(*) FROM GOODS WHERE GOODS_TYPE_ID = #{Goods_Id}")
    public int queryForDelGoodsType(Goods_type goods_type);

    class Doods_typeDaoProvider {
        public String queryG(Goods_type goods_type) {
            String sql = "SELECT * FROM GOODS_TYPE WHERE GOODS_NAME LIKE #{Goods_Name}";
            sql += "limit #{Goods_Id},10;";
            return sql;
        }

        public String queryGN(Goods_type goods_type) {
            String sql = "SELECT COUNT(*) FROM GOODS_TYPE WHERE GOODS_NAME LIKE #{Goods_Name}";
            return sql;
        }
    }
}
