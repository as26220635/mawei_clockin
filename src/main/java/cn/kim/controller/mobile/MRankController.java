package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.MagicValue;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.ResultState;
import cn.kim.entity.WechatUser;
import cn.kim.service.WechatService;
import cn.kim.util.AllocationUtil;
import cn.kim.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MRankController extends BaseController {

    @Autowired
    private WechatService wechatService;

    @GetMapping("/rank")
    @WechaNotEmptyLogin
    public String rank(Model model) {
        WechatUser wechatUser = getWechatUser();

        Map<String, Object> resultMap = wechatService.selectWechatRank(wechatUser.getId());
        int count = wechatService.selectRankCount();

        model.addAttribute("count", count);
        model.addAttribute("myRank", resultMap.get("myRank"));
        model.addAttribute("updateDate", AllocationUtil.get(MagicValue.WECHAT_RANK_UPDATE_DATE));
        setWechatUserToModel(model);
        return "mobile/rank";
    }

    /**
     * 打卡列表记录
     *
     * @param model
     * @return
     */
    @GetMapping("/rank/{pageSize}/{page}")
    @WechaNotEmptyLogin
    public String clockinItemList(@PathVariable("pageSize") int pageSize, @PathVariable("page") int page, String BW_USERNAME, Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        DataTablesView<?> dataTablesView = wechatService.selectRank(toInt(CommonUtil.getStrat(page, pageSize)), pageSize, BW_USERNAME);

        model.addAttribute("detailList", dataTablesView.getData());
        model.addAttribute("total",dataTablesView.getRecordsTotal());
        return "mobile/rank/rank_data";
    }

    /**
     * 点赞
     *
     * @param fromId 谁点的
     * @param toId   给谁的
     * @param action 动作 1点赞 0 取消
     * @param model
     * @return
     */
    @PostMapping("/rank/praise/{fromId}/{toId}/{action}")
    @WechaNotEmptyLogin
    @ResponseBody
    public ResultState praisePoint(@PathVariable("fromId") String fromId, @PathVariable("toId") String toId, @PathVariable("action") int action) throws Exception {
        //公平锁
        return fairLock("praisePoint" + toId, () -> {
            Map<String, Object> resultMap = wechatService.wechatPraisePoint(fromId, toId, action);
            return resultState(resultMap);
        });
    }
}
