package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.DictTypeCode;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.AchievementService;
import cn.kim.service.FileService;
import cn.kim.service.MenuService;
import cn.kim.util.DictUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 */
@Controller
@RequestMapping("/admin/achievement")
public class AchievementController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private FileService fileService;


    @GetMapping("/add")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        setInsertId(model);
        return "admin/info/achievement/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加成就墙")
    @Token(remove = true)
    @Validate(value = "BUS_ACHIEVEMENT", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.insertAndUpdateAchievement(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("achievement", achievementService.selectAchievement(mapParam));
        return "admin/info/achievement/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改成就墙")
    @Validate(value = "BUS_ACHIEVEMENT", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.insertAndUpdateAchievement(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/switchStatus")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改成就墙状态")
    @ResponseBody
    public ResultState switchStatus(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.changeAchievementStatus(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除成就墙")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = achievementService.deleteAchievement(mapParam);
        return resultState(resultMap);
    }

    /**
     * 成就墙分享
     *
     * @param model
     * @param mapParam
     * @return
     * @throws Exception
     */
    @GetMapping("/share")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_SHARE")
    public String updateShareHtml(Model model, @RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> map = Maps.newHashMapWithExpectedSize(1);
        String SM_ID = toString(mapParam.get("SM_ID"));
        //查询菜单
        Map<String, Object> menu = menuService.queryMenuById(SM_ID);

        map.clear();
        map.put("ID", mapParam.get("BA_ID"));
        Map<String, Object> achievement = achievementService.selectAchievement(map);

        String BAS_PARENTID = toString(mapParam.get("BAS_PARENTID"));
        //查询区域
        map.clear();
        map.put("BA_ID", mapParam.get("BA_ID"));
        map.put("BAS_PARENTID", isEmpty(BAS_PARENTID) ? "0" : BAS_PARENTID);
        List<Map<String, Object>> shareList = achievementService.selectAchievementShareList(map);

        List<Map<String, Object>> areaInfoList = new LinkedList<>();
        for (Map<String, Object> share : shareList) {
            Map<String, Object> areaMap = new HashMap<>();
            areaMap.put("id", share.get("ID"));
            areaMap.put("ID", share.get("ID"));
            areaMap.put("index", share.get("BAS_INDEX"));
            areaMap.put("BAS_INDEX", share.get("BAS_INDEX"));
            areaMap.put("BAS_PARENTID", share.get("BAS_PARENTID"));
            areaMap.put("BAS_TYPE", toString(DictUtil.getDictName(DictTypeCode.BUS_ACHIEVEMENT_SHARE_TYPE, share.get("BAS_TYPE"))));
            areaMap.put("BAS_TEXT", toString(share.get("BAS_TEXT")));
            areaMap.put("areaTitle", "区域" + share.get("BAS_INDEX"));
            areaMap.put("areaMapInfo", TextUtil.joinValue(",", share.get("BAS_X1"), share.get("BAS_Y1"), share.get("BAS_X2"), share.get("BAS_Y2")));
            areaInfoList.add(areaMap);
        }

        idEncrypt(areaInfoList);

        //子类
        if (!isEmpty(BAS_PARENTID)){
            map.clear();
            map.put("SF_TABLE_ID", BAS_PARENTID);
            map.put("SF_TABLE_NAME", TableName.BUS_ACHIEVEMENT_SHARE);
            Map<String, Object> file = fileService.selectFile(map);
            if (!isEmpty(file)){
                achievement.put("SF_ID", file.get("ID"));
            }else{
                achievement.remove("SF_ID");
            }
        }

        model.addAttribute("achievement", achievement);
        model.addAttribute("areaInfoList", TextUtil.toJSONString(areaInfoList));
        model.addAttribute("BAS_PARENTID", mapParam.get("BAS_PARENTID"));
        model.addAttribute("MENU", menu);
        model.addAttribute("EXTRA", mapParam);
        return "admin/info/achievement/share/home";
    }

    /**
     * 分享图片详细
     *
     * @param ID
     * @param mapParam
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/share/updateHtml/{ID}")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_SHARE")
    public String updateShareHtmlDetail(@PathVariable("ID") String ID, @RequestParam Map<String, Object> mapParam, Model model) throws Exception {
        mapParam.put("BAS_TYPE", DictUtil.getDictCode(DictTypeCode.BUS_ACHIEVEMENT_SHARE_TYPE, mapParam.get("BAS_TYPE")));
        model.addAttribute("share", mapParam);
        model.addAttribute("ID", ID);
        return "admin/info/achievement/share/detail";
    }

    @PutMapping("/share/update")
    @RequiresPermissions("MOBILE:ACHIEVEMENT_SHARE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "成就墙分享图片管理")
    @ResponseBody
    public ResultState updateShare(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = achievementService.changeAchievementShare(mapParam);
        return resultState(resultMap);
    }
}
