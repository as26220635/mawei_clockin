package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.Attribute;
import cn.kim.common.attr.AttributePath;
import cn.kim.common.attr.TableName;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.CxfFileWrapper;
import cn.kim.entity.WechatUser;
import cn.kim.service.AchievementService;
import cn.kim.service.FileService;
import cn.kim.service.WechatService;
import cn.kim.util.FileUtil;
import cn.kim.util.GaussianBlurUtil;
import cn.kim.util.ImageUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.poi.util.IOUtils;
import org.redisson.api.RLock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MAchievementController extends BaseController {

    @Autowired
    private WechatService wechatService;

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private FileService fileService;


    @GetMapping("/achievement")
    @WechaNotEmptyLogin
    public String achievement(Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        List<Map<String, Object>> list = achievementService.selectMAchievementListByWechat(wechatUser.getId());
        int clockinCount = (int) list.stream().filter(m -> toInt(m.get("BAD_COUNT")) > 0).count();

        model.addAttribute("achievementList", list);
        model.addAttribute("clockinCount", clockinCount);
        setWechatUserToModel(model);
        return "mobile/achievement";
    }


    /**
     * 分享页面
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/achievement/share/{BA_ID}/{BW_ID}")
    @WechaNotEmptyLogin
    public String share(@PathVariable("BA_ID") String BA_ID, @PathVariable("BW_ID") String BW_ID, @RequestParam Map<String, Object> extraMap, Model model) throws Exception {

        RLock lock = redissonClient.getFairLock("share" + BW_ID);
        try {
            //尝试加锁，最多等待60秒，上锁以后30秒自动解锁
            boolean res = lock.tryLock(60, 30, TimeUnit.SECONDS);

            if (res) {
                Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);

                paramMap.put("SF_TABLE_NAME", TableName.BUS_WECHAT);
                paramMap.put("SF_TABLE_ID", BW_ID);
                paramMap.put("SF_SDT_CODE", TableName.BUS_ACHIEVEMENT_SHARE);
                paramMap.put("SF_SDI_CODE", BA_ID);
                Map<String, Object> fileMap = fileService.selectFile(paramMap);

                paramMap.clear();
                paramMap.put("ID", BA_ID);
                Map<String, Object> achievement = achievementService.selectAchievement(paramMap);

                if (isEmpty(fileMap)) {
                    paramMap.clear();
                    paramMap.put("ID", BW_ID);
                    Map<String, Object> wechat = wechatService.selectWechat(paramMap);
                    //没有图片就生成一张
                    paramMap.clear();
                    paramMap.put("BA_ID", BA_ID);
                    paramMap.put("BAS_PARENTID", "0");
                    paramMap.put("BAS_TYPE", "1");
                    Map<String, Object> avatarShare = achievementService.selectAchievementShare(paramMap);

                    paramMap.clear();
                    paramMap.put("BA_ID", BA_ID);
                    paramMap.put("BAS_PARENTID", "0");
                    paramMap.put("BAS_TYPE", "3");
                    Map<String, Object> imgShare = achievementService.selectAchievementShare(paramMap);

                    paramMap.clear();
                    paramMap.put("BA_ID", BA_ID);
                    paramMap.put("BW_ID", BW_ID);
                    Map<String, Object> achievementDetail = achievementService.selectAchievementDetail(paramMap);

                    paramMap.clear();
                    paramMap.put("SF_TABLE_ID", achievementDetail.get("ID"));
                    paramMap.put("SF_TABLE_NAME", TableName.BUS_ACHIEVEMENT_DETAIL);
                    paramMap.put("SF_SDT_CODE", Attribute.BUS_FILE_DEFAULT);
                    paramMap.put("SF_SDI_CODE", Attribute.DEFAULT);
                    List<Map<String, Object>> clockinFileList = fileService.selectFileList(paramMap);

                    if (!isEmpty(achievement.get("SF_ID")) && !isEmpty(achievementDetail) && !isEmpty(clockinFileList)) {

                        //获取背景图片
                        Map<String, Object> baseFileMap = fileService.selectFile(toString(achievement.get("SF_ID")));
                        CxfFileWrapper baseFileWrapper = FileUtil.getCxfFileWrapper(baseFileMap);
                        //获取头像
                        BufferedImage avatarImage = ImageUtil.getRemoteBufferedImage(toString(wechat.get("BW_AVATAR")));
                        //获取上传图片中的一张
                        Map<String, Object> clockinFileMap = clockinFileList.get(new Random().nextInt(clockinFileList.size()));
                        CxfFileWrapper clockinFileWrapper = FileUtil.getCxfFileWrapper(clockinFileMap);

                        //生成分享图片
                        MultipartFile shareFile = ImageUtil.addShareImage(baseFileWrapper.getFile().getInputStream(), avatarImage, clockinFileWrapper.getFile().getInputStream(), imgShare, avatarShare);
                        if (!isEmpty(shareFile)) {
                            //保存图片上传
                            Map<String, Object> configure = Maps.newHashMapWithExpectedSize(6);
                            configure.put("SF_TABLE_NAME", TableName.BUS_WECHAT);
                            configure.put("SF_TABLE_ID", BW_ID);
                            configure.put("SF_SDT_CODE", TableName.BUS_ACHIEVEMENT_SHARE);
                            configure.put("SF_SDI_CODE", BA_ID);
                            configure.put("SF_TYPE_CODE", TableName.BUS_ACHIEVEMENT_DETAIL);

                            Map<String, Object> result = FileUtil.saveImgFile(shareFile, configure);

                            fileMap = Maps.newHashMapWithExpectedSize(1);
                            fileMap.put("IMG_PATH", result.get("location"));
                        }
                    }
                } else {
                    //读取生成的图片
                    fileMap.put("IMG_PATH", toString(fileMap.get("SF_PATH") + "@@@" + toString(fileMap.get("SF_NAME"))));
                    FileUtil.filePathTobase64(fileMap, "IMG_PATH");
                }

                if (!isEmpty(fileMap)) {
                    model.addAttribute("IMG_PATH", fileMap.get("IMG_PATH"));
                }

                model.addAttribute("achievement", achievement);
                model.addAttribute("shareFeedbackParam", TextUtil.base64Encrypt(BA_ID + "@@@" + BW_ID));

                int action = toInt(extraMap.get("action"));
                if (action == 1) {
                    setHeaderTitle(model, "打卡成功");
                } else {
                    setHeaderTitle(model, "分享");
                }
                model.addAttribute("action", action);

                return "mobile/achievement/share";
            } else {
                return "mobile/achievement/share";
            }
        } catch (Exception e) {
            return "mobile/achievement/share";
        } finally {
            lock.unlock();
        }
    }

    /**
     * 分享回调页面
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/share/{param}")
    public String shareFeedback(@PathVariable("param") String param, @RequestParam Map<String, Object> extraMap, Model model) throws Exception {
        String[] params = TextUtil.base64Decrypt(param).split("@@@");
        String BA_ID = params[0];
        String BW_ID = params[1];

        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);
        paramMap.put("SF_TABLE_NAME", TableName.BUS_WECHAT);
        paramMap.put("SF_TABLE_ID", BW_ID);
        paramMap.put("SF_SDT_CODE", TableName.BUS_ACHIEVEMENT_SHARE);
        paramMap.put("SF_SDI_CODE", BA_ID);
        Map<String, Object> fileMap = fileService.selectFile(paramMap);

        paramMap.clear();
        paramMap.put("ID", BA_ID);
        Map<String, Object> achievement = achievementService.selectAchievement(paramMap);

        model.addAttribute("IMG_PATH", fileMap.get("FILE_PATH"));
        return "mobile/achievement/shareFeedback";
    }
}
