package model.mapping;

import model.Users;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMappingDAO {

    @Select("select USER_ID,USER_NAME,USER_PASSWORD,(SELECT ROLE_USER_PERMISSION FROM ROLE WHERE ROLE_CODE = USER_PERMISSION) AS USER_PERMISSION,(SELECT ROLE_RESOURCE_PERMISSION FROM ROLE WHERE ROLE_CODE = USER_PERMISSION) AS USER_TEL from users where USER_NAME=#{User_Name} and USER_PASSWORD=#{User_Password} AND USER_STATUS = 'A'")
    public Users userLogin(Users users);

    @Select("select USER_ID,USER_NAME,USER_PERMISSION from users WHERE USER_STATUS = 'A' AND USER_PERMISSION = #{User_Permission}")
    public List<Users> selectUser(Users users);

    @Select("select USER_CODE,USER_NAME,USER_TEL,USER_EMAIL,USER_PASSWORD,(SELECT ROLE_NAME FROM ROLE WHERE ROLE_CODE = U.USER_PERMISSION) AS USER_PERMISSION from USERS U WHERE USER_CODE = #{User_Code}")
    public Users selectUserOnly(Users users);

    // 修改状态：启用或停用
    @Update("UPDATE USERS SET USER_STATUS = #{User_Status},UPDATE_TIME = now() WHERE USER_CODE = #{User_Code}")
    public int updateStatus(Users users);

    // 删除用户
    @Delete("DELETE FROM USERS WHERE USER_CODE = #{User_Code}")
    public int deleteuser(Users users);

    // 客户信息分页,查询所有符合条件的记录
    @SelectProvider(type = UsersDaoProvider.class, method = "queryU")
    public List<Users> queryUsers(Users users);

    // 客户信息分页，查询符合条件记录的数量
    @SelectProvider(type = UsersDaoProvider.class, method = "queryUN")
    public int queryUmber(Users users);

    // 修改
    @UpdateProvider(type = UsersDaoProvider.class, method = "updateU")
    public int updateUser(Users users);

    // 判断是用户是否存在
    @Select("SELECT * FROM USERS WHERE USER_NAME=#{User_Name}")
    public List<Users> selectU(Users users);

    // 修改时判断是用户是否存在
    @Select("SELECT * FROM USERS WHERE USER_NAME=#{User_Name} AND USER_CODE!=#{User_Code}")
    public List<Users> selectU1(Users users);

    @Insert("INSERT INTO USERS(USER_CODE,USER_NAME,USER_TEL,USER_EMAIL,USER_PASSWORD,USER_PERMISSION,USER_STATUS,CREATE_USER_ID,CREATE_TIME,UPDATE_TIME) " +
            "VALUES(#{User_Code},#{User_Name},#{User_Tel},#{User_Email},#{User_Password},#{User_Permission},#{User_Status},#{Create_User_Id},now(),now())")
    public boolean sveuser(Users users);

    class UsersDaoProvider {
        public String queryU(Users users) {
            String sql = "SELECT USER_CODE,USER_NAME,USER_TEL,USER_EMAIL,USER_PASSWORD,(SELECT ROLE_NAME FROM ROLE WHERE ROLE_CODE = U.USER_PERMISSION) AS USER_PERMISSION,U.USER_STATUS,(SELECT U1.USER_NAME FROM USERS U1 WHERE U1.USER_ID = U.CREATE_USER_ID) AS CREATE_USER_ID,U.CREATE_TIME,U.UPDATE_TIME" +
                    " FROM USERS U WHERE U.USER_NAME LIKE #{User_Name}";
            if (!"".equals(users.getUser_Status())) {
                sql += " AND USER_STATUS = #{User_Status}";
            }
            if (!"".equals(users.getUser_Permission())) {
                sql += " AND USER_PERMISSION =#{User_Permission}";
            }
            sql += "limit #{User_Id},10;";
            return sql;
        }

        public String queryUN(Users users) {
            String sql = "SELECT COUNT(*) FROM USERS WHERE USER_NAME LIKE #{User_Name}";
            if (!"".equals(users.getUser_Status())) {
                sql += " AND USER_STATUS = #{User_Status}";
            }
            if (!"".equals(users.getUser_Permission())) {
                sql += " AND USER_PERMISSION =#{User_Permission}";
            }
            return sql;
        }
        public String updateU(Users users) {
            String sql = "UPDATE USERS SET USER_NAME=#{User_Name},USER_TEL=#{User_Tel},USER_EMAIL=#{User_Email}";
            if(users.getUser_Permission()!=null){
                sql+=",USER_PERMISSION=#{User_Permission}";
            }
            sql+="where USER_CODE=#{User_Code}";
            return sql;
        }
    }

}
