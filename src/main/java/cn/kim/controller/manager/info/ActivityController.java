package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.ActivityService;
import cn.kim.service.MenuService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/12
 */
@Controller
@RequestMapping("/admin/activity")
public class ActivityController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private ActivityService activityService;

    @GetMapping("/add")
    @RequiresPermissions("MOBILE:ACTIVITY_INSERT")
    @Token(save = true)
    public String addHtml(@RequestParam Map<String, Object> extra, Model model) throws Exception {

        model.addAttribute("action", 1);
        model.addAttribute("MENU", menuService.queryMenuById(toString(extra.get("SM_ID"))));
        model.addAttribute("EXTRA", extra);
        setInsertId(model);
        return "admin/info/activity/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("MOBILE:ACTIVITY_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加活动")
    @Token(remove = true)
    @Validate(value = "BUS_ACTIVITY", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = activityService.insertAndUpdateActivity(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("MOBILE:ACTIVITY_UPDATE")
    public String updateHtml(@RequestParam Map<String, Object> extra, Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("activity", activityService.selectActivity(mapParam));

        model.addAttribute("action", 0);
        model.addAttribute("MENU", menuService.queryMenuById(toString(extra.get("SM_ID"))));
        model.addAttribute("EXTRA", extra);
        return "admin/info/activity/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("MOBILE:ACTIVITY_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改活动")
    @Validate(value = "BUS_ACTIVITY", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = activityService.insertAndUpdateActivity(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/switchStatus")
    @RequiresPermissions("MOBILE:ACTIVITY_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改活动状态")
    @ResponseBody
    public ResultState switchStatus(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = activityService.changeActivityStatus(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("MOBILE:ACTIVITY_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除活动")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = activityService.deleteActivity(mapParam);
        return resultState(resultMap);
    }

}
