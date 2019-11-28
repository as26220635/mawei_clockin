package cn.kim.controller.mobile;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.Validate;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.service.AchievementService;
import cn.kim.util.CommonUtil;
import cn.kim.util.FileUtil;
import cn.kim.util.TokenUtil;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by 余庚鑫 on 2018/4/10
 * 主页
 */
@Controller
public class MIndexController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @GetMapping("/clockin")
    public String clockin(HttpServletRequest request, Model model) {
        //设置打卡地点
        List<Map<String, Object>> list = achievementService.selectMAchievementList();
        model.addAttribute("achievementList", list);
        setWechatUserToModel(model);
        return "mobile/clockin";
    }

    /**
     * 打卡页面
     *
     * @param BW_ID
     * @param BA_ID
     * @param model
     * @return
     */
    @GetMapping("/clockin/in/{BW_ID}/{BA_ID}")
    @Token(save = true)
    public String in(@PathVariable("BW_ID") String BW_ID, @PathVariable("BA_ID") String BA_ID, Model model) {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", BA_ID);
        Map<String, Object> achievement = achievementService.selectAchievement(mapParam);

        model.addAttribute("BW_ID", BW_ID);
        model.addAttribute("BA_ID", BA_ID);
        model.addAttribute("achievement", achievement);
        setHeaderTitle(model, "青春打卡");
        return "mobile/clockin/in";
    }

    /**
     * 打卡
     *
     * @param uploadImg 多上传的图片
     * @param mapParam
     * @param request
     * @return
     * @throws Exception
     */
    @PostMapping("/clockin/in/upload")
    @SystemControllerLog(useType = UseType.USE, event = "添加打卡信息")
    @Token(remove = true)
    @ResponseBody
    public ResultState upload(String[] uploadImg, @RequestParam Map<String, Object> mapParam, HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = achievementService.insertAndUpdateAchievementDetail(mapParam);
        if (isSuccess(resultMap)) {
            int BAD_FILETYPE = toInt(mapParam.get("BAD_FILETYPE"));
            //上传文件
            String ID = toString(resultMap.get("ID"));

            Map<String, Object> configure = Maps.newHashMapWithExpectedSize(6);
            configure.put("SF_TABLE_ID", ID);
            configure.put("SF_TABLE_NAME", TableName.BUS_ACHIEVEMENT_DETAIL);
            configure.put("SF_TYPE_CODE", Attribute.BUS_FILE_DEFAULT);
            configure.put("SF_SDT_CODE", TableName.BUS_ACHIEVEMENT_DETAIL);
            configure.put("SF_SDI_CODE", Attribute.DEFAULT);
            configure.put("SF_SEE_TYPE", STATUS_SUCCESS);

            if (BAD_FILETYPE == 1) {
                //图片 多张上传
                for (String base64 : uploadImg) {
                    FileUtil.saveImgFile(FileUtil.base64ToMultipart(base64), configure);
                }
            } else if (BAD_FILETYPE == 2) {
                MultipartFile uploadVideo = CommonUtil.getMultipartFile(request);
                FileUtil.saveFile(uploadVideo, configure);
            }
        }

        return resultState(resultMap);
    }
}
