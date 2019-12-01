package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.AchievementService;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/1
 * 打卡记录
 */
@Controller
@RequestMapping("/admin/clockin")
public class ClockinController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @GetMapping("/add")
    @RequiresPermissions("MOBILE:CLOCKIN_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        setInsertId(model);
        return "admin/info/clockin/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("MOBILE:CLOCKIN_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加打卡记录")
    @Token(remove = true)
    @Validate(value = "BUS_ACHIEVEMENT_DETAIL", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.insertAndUpdateAchievementDetail(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("MOBILE:CLOCKIN_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("detail", achievementService.selectAchievementDetail(mapParam));
        return "admin/info/clockin/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("MOBILE:CLOCKIN_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改打卡记录")
    @Validate(value = "BUS_ACHIEVEMENT_DETAIL", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.insertAndUpdateAchievementDetail(mapParam);
        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("MOBILE:CLOCKIN_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除打卡记录")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = achievementService.deleteAchievementDetail(mapParam);
        return resultState(resultMap);
    }

}
