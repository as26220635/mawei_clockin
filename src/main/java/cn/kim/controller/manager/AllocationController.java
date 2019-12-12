package cn.kim.controller.manager;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.MobileConfig;
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
    @SystemControllerLog(useType = UseType.USE, event = "查看邮箱配置", isSuccess = true)
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
    @SystemControllerLog(useType = UseType.USE, event = "查看网站配置", isSuccess = true)
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
        //百度地图（AK）
        model.addAttribute("WEBCONFIG_BAIDU_MAP_AK", AllocationUtil.get("WEBCONFIG_BAIDU_MAP_AK"));

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
            AllocationUtil.put("WEBCONFIG_BAIDU_MAP_AK", mapParam.get("WEBCONFIG_BAIDU_MAP_AK"));
            //刷新参数
            WebConfig.init();
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("网站配置修改成功!", "修改网站配置为:" + toString(mapParam));
    }

    /****************************   前端管理配置    *****************************/

    @GetMapping("/mobileBottomMenu")
    @RequiresPermissions("SYSTEM:ALLOCATION_MOBILE_BOTTOM_MENU")
    @SystemControllerLog(useType = UseType.USE, event = "查看前端管理", isSuccess = true)
    @Token(save = true)
    public String mobileBottomMenu(Model model) throws Exception {
        model.addAttribute("WECHAT_BASE_URL", AllocationUtil.get("WECHAT_BASE_URL"));
        model.addAttribute("WECHAT_SCOPE", AllocationUtil.get("WECHAT_SCOPE"));
        model.addAttribute("WECHAT_CLIENT_ID", AllocationUtil.get("WECHAT_CLIENT_ID"));
        model.addAttribute("WECHAT_CLIENT_SECRET", AllocationUtil.get("WECHAT_CLIENT_SECRET"));
        model.addAttribute("WECHAT_REDIRECT_URI", AllocationUtil.get("WECHAT_REDIRECT_URI"));

        //青春打卡
        model.addAttribute("MOBILE_BOTTOM_MENU_CLOCKIN", AllocationUtil.get("MOBILE_BOTTOM_MENU_CLOCKIN"));
        //活动
        model.addAttribute("MOBILE_BOTTOM_MENU_ACTIVITY", AllocationUtil.get("MOBILE_BOTTOM_MENU_ACTIVITY"));
        //排行榜
        model.addAttribute("MOBILE_BOTTOM_MENU_RANK", AllocationUtil.get("MOBILE_BOTTOM_MENU_RANK"));
        //成就墙
        model.addAttribute("MOBILE_BOTTOM_MENU_ACHIEVEMENT", AllocationUtil.get("MOBILE_BOTTOM_MENU_ACHIEVEMENT"));
        //个人中心
        model.addAttribute("MOBILE_BOTTOM_MENU_MY", AllocationUtil.get("MOBILE_BOTTOM_MENU_MY"));
        //打卡是否可以上传图片
        model.addAttribute("MOBILE_CLOCKIN_UPLOAD_IMG", AllocationUtil.get("MOBILE_CLOCKIN_UPLOAD_IMG"));
        //打卡是否可以上传视频
        model.addAttribute("MOBILE_CLOCKIN_UPLOAD_VIDEO", AllocationUtil.get("MOBILE_CLOCKIN_UPLOAD_VIDEO"));
        //青春打卡横幅内容
        model.addAttribute("MOBILE_CLOCKIN_BANNER_CONTENT", AllocationUtil.get("MOBILE_CLOCKIN_BANNER_CONTENT"));
        //点赞时间
        model.addAttribute("PRAISE_POINT_START_TIME", AllocationUtil.get("PRAISE_POINT_START_TIME"));
        model.addAttribute("PRAISE_POINT_END_TIME", AllocationUtil.get("PRAISE_POINT_END_TIME"));

        return "admin/system/allocation/mobile/bottomMenu";
    }

    @PutMapping("/mobileBottomMenu")
    @RequiresPermissions("SYSTEM:ALLOCATION_MOBILE_BOTTOM_MENU_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改前端管理")
    @Token(remove = true)
    @Validate("SYS_ALLOCATION")
    @ResponseBody
    public ResultState mobileBottomMenuUpdate(@RequestParam Map<String, Object> mapParam) throws Exception {
        try {
            AllocationUtil.put("WECHAT_BASE_URL", mapParam.get("WECHAT_BASE_URL"));
            AllocationUtil.put("WECHAT_SCOPE", mapParam.get("WECHAT_SCOPE"));
            AllocationUtil.put("WECHAT_CLIENT_ID", mapParam.get("WECHAT_CLIENT_ID"));
            AllocationUtil.put("WECHAT_CLIENT_SECRET", mapParam.get("WECHAT_CLIENT_SECRET"));
            AllocationUtil.put("WECHAT_REDIRECT_URI", mapParam.get("WECHAT_REDIRECT_URI"));

            AllocationUtil.put("MOBILE_BOTTOM_MENU_CLOCKIN", mapParam.get("MOBILE_BOTTOM_MENU_CLOCKIN"));
            AllocationUtil.put("MOBILE_BOTTOM_MENU_ACTIVITY", mapParam.get("MOBILE_BOTTOM_MENU_ACTIVITY"));
            AllocationUtil.put("MOBILE_BOTTOM_MENU_RANK", mapParam.get("MOBILE_BOTTOM_MENU_RANK"));
            AllocationUtil.put("MOBILE_BOTTOM_MENU_ACHIEVEMENT", mapParam.get("MOBILE_BOTTOM_MENU_ACHIEVEMENT"));
            AllocationUtil.put("MOBILE_BOTTOM_MENU_MY", unescapeHtml4(mapParam.get("MOBILE_BOTTOM_MENU_MY")));
            AllocationUtil.put("MOBILE_CLOCKIN_UPLOAD_IMG", unescapeHtml4(mapParam.get("MOBILE_CLOCKIN_UPLOAD_IMG")));
            AllocationUtil.put("MOBILE_CLOCKIN_UPLOAD_VIDEO", unescapeHtml4(mapParam.get("MOBILE_CLOCKIN_UPLOAD_VIDEO")));
            AllocationUtil.put("MOBILE_CLOCKIN_BANNER_CONTENT", unescapeHtml4(mapParam.get("MOBILE_CLOCKIN_BANNER_CONTENT")));

            AllocationUtil.put("PRAISE_POINT_START_TIME", mapParam.get("PRAISE_POINT_START_TIME"));
            AllocationUtil.put("PRAISE_POINT_END_TIME", mapParam.get("PRAISE_POINT_END_TIME"));
            //刷新参数
            MobileConfig.init();
        } catch (Exception e) {
            return resultError(e);
        }
        return resultSuccess("前端管理成功!", "修改前端管理为:" + toString(mapParam));
    }
}
