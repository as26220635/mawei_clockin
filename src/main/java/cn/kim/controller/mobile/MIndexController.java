package cn.kim.controller.mobile;

import cn.kim.common.annotation.SystemControllerLog;
import cn.kim.common.annotation.Token;
import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.MobileConfig;
import cn.kim.common.attr.TableName;
import cn.kim.common.eu.UseType;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.entity.WechatUser;
import cn.kim.service.AchievementSearchService;
import cn.kim.service.AchievementService;
import cn.kim.service.MainImageService;
import cn.kim.util.FileUtil;
import cn.kim.util.TokenUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/4/10
 * 主页
 */
@Controller
public class MIndexController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private AchievementSearchService achievementSearchService;

    @Autowired
    private MainImageService mainImageService;

    /**
     * 搜索
     *
     * @param queryWord
     * @return
     * @throws Exception
     */
    @GetMapping("/clockin/search")
    @WechaNotEmptyLogin
    @ResponseBody
    public ResultState search(@RequestParam("queryWord") String queryWord) throws Exception {
        JSONArray searchList = achievementSearchService.search(queryWord);

        idEncrypt(searchList);

        ResultState resultState = new ResultState();
        resultState.setCode(STATUS_SUCCESS);
        resultState.setData(searchList);
        return resultState;
    }

    /**
     * 切换主页图片
     *
     * @param BMI_RELATIONID
     * @return
     * @throws Exception
     */
    @GetMapping("/clockin/mainImage/{BMI_RELATIONID}")
    @WechaNotEmptyLogin
    @ResponseBody
    public ResultState mainImage(@PathVariable("BMI_RELATIONID") String BMI_RELATIONID) throws Exception {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(2);
        resultMap.put("ID", getId());
        //首页图片热区域
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", BMI_RELATIONID);
        paramMap.put("IS_STATUS", STATUS_SUCCESS);
        Map<String, Object> mainImage = mainImageService.selectMainImage(paramMap);
        mainImage.put("IS_TOP", "0".equals(toString(mainImage.get("BMI_PARENTID"))) ? 1 : 0);

        paramMap.clear();
        paramMap.put("BMI_ID", mainImage.get("ID"));
        List<Map<String, Object>> areaList = mainImageService.selectMainImageAreaList(paramMap);

        idEncrypt(mainImage);
        idEncrypt(areaList);

        //设置参数
        JSONObject data = new JSONObject();
        data.put("mainImage", mainImage);
        data.put("areaList", areaList);

        resultMap.put(MagicValue.STATUS, STATUS_SUCCESS);
        resultMap.put(MagicValue.DATA, data);
        return resultState(resultMap);
    }

    /**
     * 打卡页面
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/clockin")
    @WechaNotEmptyLogin
    public String clockin(HttpServletRequest request, Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        //设置打卡地点
        List<Map<String, Object>> list = achievementService.selectMAchievementList(wechatUser.getId());
        //首页图片热区域
        paramMap.put("IS_STATUS", STATUS_SUCCESS);
        paramMap.put("BMI_PARENTID", 0);
        Map<String, Object> mainImage = mainImageService.selectMainImage(paramMap);

        paramMap.clear();
        paramMap.put("BMI_ID", mainImage.get("ID"));
        List<Map<String, Object>> areaList = mainImageService.selectMainImageAreaList(paramMap);

        model.addAttribute("achievementList", list);
        model.addAttribute("mainImage", mainImage);
        model.addAttribute("areaList", areaList);
        model.addAttribute("wechatUser", getWechatUser());
        model.addAttribute("mobileConfig", MobileConfig.getConfig());
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
    @WechaNotEmptyLogin
    public String in(@PathVariable("BW_ID") String BW_ID, @PathVariable("BA_ID") String BA_ID, @RequestParam Map<String, Object> extraMap, Model model) throws Exception {
        Map<String, Object> mapParam = Maps.newHashMapWithExpectedSize(1);
        mapParam.put("ID", BA_ID);
        Map<String, Object> achievement = achievementService.selectAchievement(mapParam);

        //判断是否已经打卡
        mapParam.clear();
        mapParam.put("BA_ID", BA_ID);
        mapParam.put("BW_ID", BW_ID);
        Map<String, Object> detail = achievementService.selectAchievementDetail(mapParam);
        if (!isEmpty(detail)) {
            model.addAttribute("isClockin", 1);
            return "mobile/clockin/in";
        }

        //获取9个ID给图片和视频使用
        List<String> fileIds = Lists.newArrayList();
        for (int i = 0; i < 9; i++) {
            fileIds.add(getId());
        }
        model.addAttribute("FILE_NAMES", fileIds);
        model.addAttribute("UPLOAD_TOKEN", TokenUtil.createJWT(BW_ID, BA_ID, 600000));
        model.addAttribute("BW_ID", BW_ID);
        model.addAttribute("BA_ID", BA_ID);
        model.addAttribute("achievement", achievement);
        model.addAttribute("mobileConfig", MobileConfig.getConfig());
        model.addAttribute("clockinAddress", extraMap.get("clockinAddress"));
        setHeaderTitle(model, "青春打卡");
        return "mobile/clockin/in";
    }

    /**
     * 打卡
     *
     * @param mapParam
     * @param request
     * @return
     * @throws Exception
     */
    @PostMapping("/clockin/in/upload")
    @SystemControllerLog(useType = UseType.USE, event = "添加打卡信息")
    @Token(remove = true)
    @WechaNotEmptyLogin
    @ResponseBody
    public ResultState upload(@RequestParam Map<String, Object> mapParam, HttpServletRequest request) throws Exception {
        WechatUser wechatUser = getWechatUser();

        return fairLock("clockin" + wechatUser.getId(), () -> {
            Map<String, Object> resultMap = achievementService.insertAndUpdateAchievementDetail(mapParam);
            if (isSuccess(resultMap)) {
                //文件服务器上传的信息
                String uploadInfo = unescapeHtml4(toString(mapParam.get("uploadInfo")));

                int BAD_FILETYPE = toInt(mapParam.get("BAD_FILETYPE"));
                //上传文件
                String ID = toString(resultMap.get("ID"));

                Map<String, Object> configure = Maps.newHashMapWithExpectedSize(6);
                configure.put("SF_TABLE_ID", ID);
                configure.put("SF_TABLE_NAME", TableName.BUS_ACHIEVEMENT_DETAIL);
                configure.put("SF_TYPE_CODE", Attribute.BUS_FILE_DEFAULT);
                configure.put("SF_SDT_CODE", Attribute.BUS_FILE_DEFAULT);
                configure.put("SF_SDI_CODE", Attribute.DEFAULT);
                configure.put("SF_SEE_TYPE", STATUS_SUCCESS);

                if (BAD_FILETYPE == 1) {
                    //保存图片信息
                    JSONArray jsonArray = JSONArray.parseArray(uploadInfo);
                    for (int i = 0; i < jsonArray.size(); i++) {
                        JSONObject info = jsonArray.getJSONObject(i);
                        configure.put("SF_NAME_NO", info.get("SF_NAME_NO"));
                        configure.put("SF_PATH", info.get("SF_PATH"));
                        configure.put("SF_SUFFIX", info.get("SF_SUFFIX"));
                        configure.put("SF_NAME", info.get("SF_NAME"));
                        configure.put("SF_ORIGINAL_NAME", info.get("SF_ORIGINAL_NAME"));
                        configure.put("SF_SIZE", info.get("SF_SIZE"));
                        FileUtil.saveFileInfo(configure);
                    }
                } else if (BAD_FILETYPE == 2) {
                    //保存视频信息
                    JSONObject jsonObject = JSONObject.parseObject(uploadInfo);
                    configure.put("SF_NAME_NO", jsonObject.get("SF_NAME_NO"));
                    configure.put("SF_PATH", jsonObject.get("SF_PATH"));
                    configure.put("SF_SUFFIX", jsonObject.get("SF_SUFFIX"));
                    configure.put("SF_NAME", jsonObject.get("SF_NAME"));
                    configure.put("SF_ORIGINAL_NAME", jsonObject.get("SF_ORIGINAL_NAME"));
                    configure.put("SF_SIZE", jsonObject.get("SF_SIZE"));
                    FileUtil.saveFileInfo(configure);
                }
            }

            return resultState(resultMap);
        });
    }
}
