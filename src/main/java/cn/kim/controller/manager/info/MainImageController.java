package cn.kim.controller.manager.info;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.entity.Tree;
import cn.kim.service.MainImageService;
import cn.kim.service.MenuService;
import cn.kim.util.TextUtil;
import com.fasterxml.jackson.annotation.JsonAlias;
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
 * Created by 余庚鑫 on 2019/12/2
 */
@Controller
@RequestMapping("/admin/mainImage")
public class MainImageController extends BaseController {

    @Autowired
    private MainImageService mainImageService;

    @Autowired
    private MenuService menuService;

    @GetMapping("/add")
    @RequiresPermissions("MOBILE:MAINIMAGE_INSERT")
    @Token(save = true)
    public String addHtml(Model model) throws Exception {
        setInsertId(model);
        return "admin/info/mainImage/addAndEdit";
    }


    @PostMapping("/add")
    @RequiresPermissions("MOBILE:MAINIMAGE_INSERT")
    @SystemControllerLog(useType = UseType.USE, event = "添加主页图片")
    @Token(remove = true)
    @Validate(value = "BUS_MAINIMAGE", required = true)
    @ResponseBody
    public ResultState add(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = mainImageService.insertAndUpdateMainImage(mapParam);

        return resultState(resultMap);
    }


    @GetMapping("/update/{ID}")
    @RequiresPermissions("MOBILE:MAINIMAGE_UPDATE")
    public String updateHtml(Model model, @PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        model.addAttribute("mainImage", mainImageService.selectMainImage(mapParam));
        return "admin/info/mainImage/addAndEdit";
    }

    @PutMapping("/update")
    @RequiresPermissions("MOBILE:MAINIMAGE_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改主页图片")
    @Validate(value = "BUS_MAINIMAGE", required = true)
    @ResponseBody
    public ResultState update(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = mainImageService.insertAndUpdateMainImage(mapParam);
        return resultState(resultMap);
    }

    @PutMapping("/switchStatus")
    @RequiresPermissions("MOBILE:MAINIMAGE_UPDATE_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改主页图片状态")
    @ResponseBody
    public ResultState switchStatus(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = mainImageService.changeMainImageStatus(mapParam);

        return resultState(resultMap);
    }

    @DeleteMapping("/delete/{ID}")
    @RequiresPermissions("MOBILE:MAINIMAGE_DELETE")
    @SystemControllerLog(useType = UseType.USE, event = "删除主页图片")
    @ResponseBody
    public ResultState delete(@PathVariable("ID") String ID) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", ID);
        Map<String, Object> resultMap = mainImageService.deleteMainImage(mapParam);
        return resultState(resultMap);
    }

    /**
     * 区域管理
     *
     * @param model
     * @param mapParam
     * @return
     * @throws Exception
     */
    @GetMapping("/area")
    @RequiresPermissions("MOBILE:MAINIMAGE_AREA")
    public String updateAreaHtml(Model model, @RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> map = Maps.newHashMapWithExpectedSize(1);
        String SM_ID = toString(mapParam.get("SM_ID"));
        //查询菜单
        Map<String, Object> menu = menuService.queryMenuById(SM_ID);

        map.clear();
        map.put("ID", mapParam.get("BMI_ID"));
        Map<String, Object> mainImage = mainImageService.selectMainImage(map);

        //查询区域
        map.clear();
        map.put("BMI_ID", mapParam.get("BMI_ID"));
        List<Map<String, Object>> areaList = mainImageService.selectMainImageAreaList(map);
        List<Map<String, Object>> areaInfoList = new LinkedList<>();
        for (Map<String, Object> area : areaList) {
            Map<String, Object> areaMap = new HashMap<>();
            areaMap.put("id", area.get("ID"));
            areaMap.put("index", area.get("BIMA_INDEX"));
            areaMap.put("areaTitle", area.get("BIMA_TITLE"));
            areaMap.put("areaMapInfo", area.get("BIMA_MAPINFO"));
            areaInfoList.add(areaMap);
        }

        model.addAttribute("mainImage", mainImage);
        model.addAttribute("areaList", TextUtil.toJSONString(areaList));
        model.addAttribute("areaInfoList", TextUtil.toJSONString(areaInfoList));
        model.addAttribute("MENU", menu);
        model.addAttribute("EXTRA", mapParam);
        return "admin/info/mainImage/area/home";
    }

    @PutMapping("/area/update")
    @RequiresPermissions("MOBILE:MAINIMAGE_AREA_SAVE")
    @SystemControllerLog(useType = UseType.USE, event = "修改主页图片区域")
    @Validate(value = "BUS_MAINIMAGE", required = true)
    @ResponseBody
    public ResultState updateArea(@RequestParam Map<String, Object> mapParam) throws Exception {
        Map<String, Object> resultMap = mainImageService.insertAndUpdateMainImage(mapParam);
        return resultState(resultMap);
    }

}
