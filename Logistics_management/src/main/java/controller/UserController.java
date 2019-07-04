package controller;

import model.Users;
import model.mapping.UserMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.Element;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserMappingDAO userMappingDAO;
    private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";

    /**
     * 登陆
     *
     * @param users
     * @param request
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String userRegistController(Users users, HttpServletRequest request) {
        Users users1 = userMappingDAO.userLogin(users);
        JSONObject jsonObject = new JSONObject();
        if (users1 != null) {
            request.getSession().setAttribute("user", users1);
            jsonObject.put("result", "1");
        } else jsonObject.put("result", "2");
        return jsonObject.toString();
    }

    /**
     * 退出当前账户
     *
     * @return
     */
    @RequestMapping(value = "/loginout", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String loginout(HttpServletRequest request) {
        request.getSession().removeAttribute("user");
        return "login.jsp";
    }

    /**
     * 查询所有用户
     *
     * @return
     */
    @RequestMapping(value = "/selectusers", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String userRegistController(Users users) {
        List<Users> usersList = userMappingDAO.selectUser(users);
        JSONArray jsonArray = JSONArray.fromObject(usersList);
        return jsonArray.toString();
    }

    /**
     * 查询用户名是否已被使用
     *
     * @return
     */
    @RequestMapping(value = "/selectuser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String userController(Users users) {
        List<Users> usersList = userMappingDAO.selectU(users);
        JSONObject jsonObject = new JSONObject();
        int i = usersList.size();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }

    /**
     * 修改时查询查询用户名是否已被使用
     *
     * @return
     */
    @RequestMapping(value = "/selectuser1", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String userController1(Users users) {
        List<Users> usersList = userMappingDAO.selectU1(users);
        JSONObject jsonObject = new JSONObject();
        int i = usersList.size();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }

    /**
     * 修改状态
     *
     * @return
     */
    @RequestMapping(value = "/updateUserStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateUserStatus(Users users) {
        JSONObject jsonObject = new JSONObject();
        int j = userMappingDAO.updateStatus(users);
        jsonObject.put("j", j);
        return jsonObject.toString();
    }

    /**
     * 修改前查询用户信息
     *
     * @return
     */
    @RequestMapping(value = "/edituser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String edituser(Users users) {
        users = userMappingDAO.selectUserOnly(users);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("user",users);
        return jsonObject.toString();
    }

    /**
     * 删除用户
     *
     * @return
     */
    @RequestMapping(value = "/deleteUserStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteUserStatus(Users users) {
        JSONObject jsonObject = new JSONObject();
        int j = userMappingDAO.deleteuser(users);
        jsonObject.put("j", j);
        return jsonObject.toString();
    }

    /**
     * 添加用户
     *
     * @return
     */
    @RequestMapping(value = "/sveuser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String sveuser(Users users, HttpServletRequest request) {
        users.setUser_Status("A");
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        users.setUser_Code(timer.format(new Date()) + s);
        Users users1 = (Users) request.getSession().getAttribute("user");
        users.setCreate_User_Id(String.valueOf(users1.getUser_Id()));
        boolean b = userMappingDAO.sveuser(users);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result",b);
        return jsonObject.toString();
    }

    /**
     * 修改用户
     *
     * @return
     */
    @RequestMapping(value = "/updateuser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String updateuser(Users users, HttpServletRequest request) {
        int i = userMappingDAO.updateUser(users);
        if (i>0) {
            return SUCCESS;
        } else return ERROR;
    }


    /**
     * 分页查用户列表
     *
     * @param users
     * @return
     */
    @RequestMapping(value = "/listU", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listU(Users users) {
        users.setUser_Name("%" + users.getUser_Name().trim() + "%");
        int j = users.getUser_Id();
        users.setUser_Id(j * 10);
        List<Users> usersList = userMappingDAO.queryUsers(users);
        JSONArray jsonArray = JSONArray.fromObject(usersList);
        return jsonArray.toString();
    }


    /**
     * 分页查数量
     *
     * @param users
     * @return
     */
    @RequestMapping(value = "/listUnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryUnumber(Users users) {
        users.setUser_Name("%" + users.getUser_Name().trim() + "%");
        int i = userMappingDAO.queryUmber(users);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }
}
