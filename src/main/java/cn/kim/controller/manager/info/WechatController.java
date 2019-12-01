package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.WechatService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/1
 */
@Controller
@RequestMapping("/admin/wechat")
public class WechatController extends BaseController {

    @Autowired
    private WechatService wechatService;


    @PutMapping("/switchStatus")
    @RequiresPermissions("MOBILE:WECHAT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改微信用户状态")
    @ResponseBody
    public ResultState switchStatus(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = wechatService.changeWechatStatus(mapParam);

        return resultState(resultMap);
    }

}
