package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.WebConfig;
import cn.kim.common.eu.UseType;
import cn.kim.entity.ResultState;
import cn.kim.service.AllocationService;
import cn.kim.util.AllocationUtil;
import cn.kim.util.EmailUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/5/22
 * 系统配置
 */
@Controller
@RequestMapping("/admin/allocation")
public class AllocationController extends BaseController {

    @Autowired
    private AllocationService allocationService;


    /****************************   邮箱管理    *****************************/

    @GetMapping("/email")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL")
    @SystemControllerLog(useType = UseType.USE, event = "查看邮箱配置")
    @Token(save = true)
    public String emailHome(Model model) throws Exception {
        //邮箱登录名
        model.addAttribute("EMAIL_USER", AllocationUtil.get("EMAIL_USER"));
        //邮箱授权码不是登录密码
        model.addAttribute("EMAIL_PASSWORD", AllocationUtil.get("EMAIL_PASSWORD"));
        //邮箱协议
        model.addAttribute("EMAIL_PROTOCOL", AllocationUtil.get("EMAIL_PROTOCOL"));
        //邮箱服务器地址
        model.addAttribute("EMAIL_HOST", AllocationUtil.get("EMAIL_HOST"));
        //邮箱服务器端口
        model.addAttribute("EMAIL_PORT", AllocationUtil.get("EMAIL_PORT"));
        //是否需要是否验证
        model.addAttribute("EMAIL_AUTH", AllocationUtil.get("EMAIL_AUTH"));
        //是否启用
        model.addAttribute("EMAIL_STATUS", AllocationUtil.get("EMAIL_STATUS"));
        //是否开启SSL加密
        model.addAttribute("EMAIL_SSL_ENABLE", AllocationUtil.get("EMAIL_SSL_ENABLE"));

        return "admin/system/allocation/email/home";
    }

    @PutMapping("/email")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改邮箱配置")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState emailUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("EMAIL_USER", mapParam.get("EMAIL_USER"));
            AllocationUtil.put("EMAIL_PASSWORD", mapParam.get("EMAIL_PASSWORD"));
            AllocationUtil.put("EMAIL_PROTOCOL", mapParam.get("EMAIL_PROTOCOL"));
            AllocationUtil.put("EMAIL_HOST", mapParam.get("EMAIL_HOST"));
            AllocationUtil.put("EMAIL_PORT", mapParam.get("EMAIL_PORT"));
            AllocationUtil.put("EMAIL_AUTH", mapParam.get("EMAIL_AUTH"));
            AllocationUtil.put("EMAIL_STATUS", mapParam.get("EMAIL_STATUS"));
            AllocationUtil.put("EMAIL_SSL_ENABLE", mapParam.get("EMAIL_SSL_ENABLE"));
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("邮箱配置修改成功!", "修改邮箱配置为:" + toString(mapParam));
    }

    @PostMapping("/email/cache")
    @RequiresPermissions("SYSTEM:ALLOCATION_EMAIL_CACHE")
    @SystemControllerLog(useType = UseType.USE, event = "刷新邮箱配置缓存")
    @ResponseBody
    public ResultState emailCache() throws Exception {
        try {
            EmailUtil.init();
            return resultSuccess("刷新缓存成功!");
        } catch (Exception e) {
            return resultError("刷新缓存失败");
        }
    }

    @GetMapping("/fileInputTest")
    public String fileInputTest(Model model) throws Exception {
        model.addAttribute("tableId", "fileInputTest");
        return "admin/system/allocation/fileInputTest";
    }

    /****************************   网站信息配置    *****************************/

    @GetMapping("/webConfig")
    @RequiresPermissions("SYSTEM:ALLOCATION_WEBCONFIG")
    @SystemControllerLog(useType = UseType.USE, event = "查看网站配置")
    @Token(save = true)
    public String webConfig(Model model) throws Exception {
        //网站头标题
        model.addAttribute("WEBCONFIG_HEAD_TITLE", AllocationUtil.get("WEBCONFIG_HEAD_TITLE"));
        //登录标题
        model.addAttribute("WEBCONFIG_LOGIN_TITLE", AllocationUtil.get("WEBCONFIG_LOGIN_TITLE"));
        //后台菜单标题
        model.addAttribute("WEBCONFIG_MENU_TITLE", AllocationUtil.get("WEBCONFIG_MENU_TITLE"));
        //后台菜单小标题
        model.addAttribute("WEBCONFIG_MENU_SMALL_TITLE", AllocationUtil.get("WEBCONFIG_MENU_SMALL_TITLE"));
        //文件服务器地址
        model.addAttribute("WEBCONFIG_FILE_SERVER_URL", AllocationUtil.get("WEBCONFIG_FILE_SERVER_URL"));

        return "admin/system/allocation/webconfig/home";
    }

    @PutMapping("/webConfig")
    @RequiresPermissions("SYSTEM:ALLOCATION_WEBCONFIG_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改网站配置")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState webConfigUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("WEBCONFIG_HEAD_TITLE", mapParam.get("WEBCONFIG_HEAD_TITLE"));
            AllocationUtil.put("WEBCONFIG_LOGIN_TITLE", mapParam.get("WEBCONFIG_LOGIN_TITLE"));
            AllocationUtil.put("WEBCONFIG_MENU_TITLE", mapParam.get("WEBCONFIG_MENU_TITLE"));
            AllocationUtil.put("WEBCONFIG_MENU_SMALL_TITLE", mapParam.get("WEBCONFIG_MENU_SMALL_TITLE"));
            AllocationUtil.put("WEBCONFIG_FILE_SERVER_URL", unescapeHtml4(mapParam.get("WEBCONFIG_FILE_SERVER_URL")));
            //刷新参数
            WebConfig.init();
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("网站配置修改成功!", "修改网站配置为:" + toString(mapParam));
    }
}
