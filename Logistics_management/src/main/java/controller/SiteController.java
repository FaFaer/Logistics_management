package controller;

import model.China;
import model.Clientele;
import model.Users;
import model.Warehouse;
import model.mapping.ClienteleMappingDAO;
import model.mapping.SiteMappingDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class SiteController {
    @Autowired
    private SiteMappingDAO siteMappingDAO;
    @Autowired
    private ClienteleMappingDAO clienteleMappingDAO;


    private SimpleDateFormat timer = new SimpleDateFormat("YYmmssSSSS");
    private static final String SUCCESS = "/JSP/success.jsp";
    private static final String ERROR = "/JSP/error.jsp";

    /**
     * 查省市区 传入ID
     *
     * @param china
     * @return
     */
    @RequestMapping(value = "/searchP", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String SiteP(China china) {
        String Pid = china.getChina_Pid();
        if (Pid == "" || "".equals(Pid) || Pid == null) {
            Pid = "0";
        }
        List<China> chinas = siteMappingDAO.SitP(Pid);
        JSONArray jsonArray = JSONArray.fromObject(chinas);
        return jsonArray.toString();
    }

    /**
     * 查客户列表
     *
     * @return
     */
    @RequestMapping(value = "/searchCForOrder", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String searchCForOrder() {
        List<Clientele> clienteleList = clienteleMappingDAO.searchCForOrder();
        JSONArray jsonArray = JSONArray.fromObject(clienteleList);
        return jsonArray.toString();
    }

    /**
     * 查仓库列表
     *
     * @return
     */
    @RequestMapping(value = "/searchW", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String Whare() {
        List<Warehouse> warehouses = clienteleMappingDAO.querywharehouse();
        JSONArray jsonArray = JSONArray.fromObject(warehouses);
        return jsonArray.toString();
    }

    /**
     * 添加客户
     *
     * @param clientele
     * @param request
     * @return
     */
    @RequestMapping(value = "/addclientele", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addclientele(Clientele clientele, HttpServletRequest request) {
        clientele.setClientele_Name(clientele.getClientele_Name().trim());
        clientele.setClientele_Principal(clientele.getClientele_Principal().trim());
        clientele.setClientele_Address(clientele.getClientele_Address().trim());
        clientele.setClientele_Status("A");
        String s = String.valueOf((int) (Math.random() * 10000) / 1);
        clientele.setClientele_Code(timer.format(new Date()) + s);
        Users users = (Users) request.getSession().getAttribute("user");
        clientele.setUser_Id(String.valueOf(users.getUser_Id()));
        boolean b = clienteleMappingDAO.savecliente(clientele);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", b);
        return jsonObject.toString();
    }

    /**
     * 首页图表查询
     *
     * @return
     */
    @RequestMapping(value = "/searchforIndex", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String searchforIndex() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyM");
        String[] tables = {"USERS", "VEHICLE", "CLIENTELE"};
        Date date = new Date();
        String[] dates = new String[6];
        int j = 0;
        for (int i = 5; i >= 0; i--) {
            Date temp = new Date();
            temp.setMonth(date.getMonth() - j++);
            dates[i] = sdf.format(temp);
        }
        JSONObject jsonObject = new JSONObject();
        for (int i = 0; i < tables.length; i++) {
            for (int k = 0; k < dates.length; k++) {
                int q = siteMappingDAO.queryUser(tables[i], dates[k]);
                String name = tables[i] + "" + k;
                jsonObject.put(name, q);
            }
        }
        return jsonObject.toString();
    }


    @RequestMapping(value = "/searchorderforIndex", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String searchorderforIndex() {
        int i = siteMappingDAO.searchorderforIndex();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("i", i);
        return jsonObject.toString();
    }


    /**
     * 查用户列表
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/listC", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listC(Clientele clientele) {
        clientele.setClientele_Name(clientele.getClientele_Name().trim());
        clientele.setClientele_Address(clientele.getClientele_Address().trim());
        int j = clientele.getClientele_Id();
        clientele.setClientele_Id(j * 10);
        List<Clientele> clienteles = clienteleMappingDAO.queryclientele(clientele);
        JSONArray jsonArray = JSONArray.fromObject(clienteles);
        return jsonArray.toString();
    }

    /**
     * 删除用户,删除前看订单里有没有该客户
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/deleteC", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteC(Clientele clientele) {
        // 先查询库存表里还有没有该种商品
        JSONObject jsonObject = new JSONObject();
        int j = clienteleMappingDAO.queryForDelclientele(clientele);
        if (j > 0) {
            jsonObject.put("j", j);
        } else {
            jsonObject.put("j", 0);
            int i = clienteleMappingDAO.delete(clientele);
            jsonObject.put("i", i);
        }
        return jsonObject.toString();
    }

    /**
     * 分页查数量
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/listCnumber", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listCnumber(Clientele clientele) {
        int i = clienteleMappingDAO.queryclientelenumber(clientele);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sum", i);
        return jsonObject.toString();
    }

    /**
     * 修改前查询需要修改的原信息
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/editcliente", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String editcliente(Clientele clientele) {
        clientele = clienteleMappingDAO.querycli(clientele);
        JSONObject jsonObject = JSONObject.fromObject(clientele);
        return jsonObject.toString();
    }

    /**
     * 修改用户信息
     *
     * @param clientele
     * @return
     */
    @RequestMapping(value = "/editcliente1", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String editcliente1(Clientele clientele) {
        int i = clienteleMappingDAO.editclientele(clientele);
        if (i > 0) {
            return SUCCESS;
        } else return ERROR;
    }
}
