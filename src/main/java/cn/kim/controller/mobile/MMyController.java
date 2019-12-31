package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.MagicValue;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.ResultState;
import cn.kim.entity.WechatUser;
import cn.kim.service.AchievementService;
import cn.kim.service.WechatService;
import cn.kim.util.CommonUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/26
 * 我的
 */
@Controller
public class MMyController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private WechatService wechatService;

    @GetMapping("/my")
    @WechaNotEmptyLogin
    public String my(Model model) throws Exception{
        model.addAttribute(MagicValue.SESSION_WECHAT_USER, getWechatUser());
        model.addAttribute("CONTACT_SERVICE_IMG_PATH",wechatService.selectContactServiceFile());
        return "mobile/my";
    }

    /**
     * 打卡列表
     *
     * @param model
     * @return
     */
    @GetMapping("/my/clockin")
    @WechaNotEmptyLogin
    public String clockinList(Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        int clockinCount = achievementService.selectAchievementDetailListCountByWechatId(wechatUser.getId());
        model.addAttribute("clockinCount", clockinCount);
        setHeaderTitle(model, "打卡记录");
        return "mobile/my/clockin_list";
    }

    /**
     * 打卡列表记录
     *
     * @param model
     * @return
     */
    @GetMapping("/my/clockin/{pageSize}/{page}")
    @WechaNotEmptyLogin
    public String clockinItemList(@PathVariable("pageSize") int pageSize, @PathVariable("page") int page, Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        DataTablesView<?> dataTablesView = achievementService.selectMAchievementDetailList(toInt(CommonUtil.getStrat(page, pageSize)), pageSize, wechatUser.getId());

        model.addAttribute("detailList", dataTablesView.getData());
        return "mobile/my/clockin_data";
    }

    /**
     * 查看打卡详细记录
     *
     * @param ID
     * @param model
     * @return
     */
    @GetMapping("/my/clockin/{ID}")
    @WechaNotEmptyLogin
    public String clockinItem(@PathVariable("ID") String ID, Model model) throws Exception {
        Map<String, Object> detail = achievementService.selectMAchievementDetailById(ID);

        List<String> fileIds = Lists.newArrayList(toString(detail.get("FILE_PATH")).split(","));

        model.addAttribute("detail", detail);
        model.addAttribute("fileIds", fileIds);
        setHeaderTitle(model, "打卡记录");
        return "mobile/my/clockin_item";
    }

    @DeleteMapping("/my/clockin/delete/{ID}")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = achievementService.deleteAchievementDetail(mapParam);
        return resultState(resultMap);
    }
}
