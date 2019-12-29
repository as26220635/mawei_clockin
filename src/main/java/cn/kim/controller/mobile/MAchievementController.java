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
import cn.kim.util.FileUtil;
import cn.kim.util.GaussianBlurUtil;
import cn.kim.util.ImageUtil;
import cn.kim.util.TextUtil;
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

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MAchievementController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private FileService fileService;


    @GetMapping("/achievement")
    @WechaNotEmptyLogin
    public String achievement(Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        List<Map<String, Object>> list = achievementService.selectMAchievementListByWechat(wechatUser.getId());
//        IMG_PATH
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
                    //没有图片就生成一张
                    paramMap.clear();
                    paramMap.put("BA_ID", BA_ID);
                    List<Map<String, Object>> shareList = achievementService.selectAchievementShare(paramMap);

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

                    if (!isEmpty(shareList) && !isEmpty(achievement.get("SF_ID")) && !isEmpty(achievementDetail) && !isEmpty(clockinFileList)) {
                        //图片区域
                        Map<String, Object> imgShare = shareList.get(0);
                        //文本区域
                        Map<String, Object> textShare = null;
                        if (shareList.size() > 1) {
                            textShare = shareList.get(1);
                        }

                        //通过url获取
//                //获取背景图片
//                Map<String, Object> baseFileMap = fileService.selectFile(toString(achievement.get("SF_ID")));
//                BufferedImage  baseBufferedImage = ImageUtil.getRemoteBufferedImage(WebConfig.WEBCONFIG_FILE_SERVER_URL + Url.FILE_SERVER_PREVIEW_URL + toString(baseFileMap.get("FILE_PATH")));
//                //获取上传图片中的一张
//                Map<String, Object> clockinFileMap = clockinFileList.get(new Random().nextInt(clockinFileList.size()));
//                BufferedImage  clockinBufferedImage = ImageUtil.getRemoteBufferedImage(WebConfig.WEBCONFIG_FILE_SERVER_URL + Url.FILE_SERVER_PREVIEW_URL + toString(clockinFileMap.get("FILE_PATH")));
                        //获取背景图片
                        Map<String, Object> baseFileMap = fileService.selectFile(toString(achievement.get("SF_ID")));
                        CxfFileWrapper baseFileWrapper = FileUtil.getCxfFileWrapper(baseFileMap);
                        //获取上传图片中的一张
                        Map<String, Object> clockinFileMap = clockinFileList.get(new Random().nextInt(clockinFileList.size()));
                        CxfFileWrapper clockinFileWrapper = FileUtil.getCxfFileWrapper(clockinFileMap);

                        BufferedImage baseBufferedImage = null;
                        BufferedImage clockinBufferedImage = null;
                        BufferedImage backgroundImage = null;
                        InputStream baseInputStream = null;
                        InputStream clockinInputStream = null;
                        InputStream backgroundInputStream = null;
                        ByteArrayOutputStream clockinOut = null;
                        ByteArrayOutputStream backgroundOut = null;
                        ByteArrayOutputStream out = null;
                        try {
                            baseInputStream = baseFileWrapper.getFile().getInputStream();
                            clockinInputStream = clockinFileWrapper.getFile().getInputStream();
                            if (baseInputStream != null && clockinInputStream != null) {
                                baseBufferedImage = ImageIO.read(baseInputStream);
                                clockinBufferedImage = ImageIO.read(clockinInputStream);

                                int baseHeight = baseBufferedImage.getHeight();
                                int baseWidth = baseBufferedImage.getWidth();

                                int clockinHeight = clockinBufferedImage.getHeight();
                                int clockinWidth = clockinBufferedImage.getWidth();

                                int shareHeight = toBigDecimal(imgShare.get("BAS_HEIGHT")).intValue();
                                int shareWidth = toBigDecimal(imgShare.get("BAS_WIDTH")).intValue();
                                int x1 = toInt(imgShare.get("BAS_X1"));
                                int y1 = toInt(imgShare.get("BAS_Y1"));
                                int x2 = toInt(imgShare.get("BAS_X2"));
                                int y2 = toInt(imgShare.get("BAS_Y2"));

                                //计算 上传图片需要压缩到的大小
                                int maxHeight = Math.round((y2 - y1) * baseHeight / shareHeight);
                                int maxWidth = Math.round((x2 - x1) * baseWidth / shareWidth);

                                //左侧的偏移量
                                int x = Math.round(x1 * baseHeight / shareHeight);
                                //上侧的偏移量
                                int y = Math.round(y1 * baseWidth / shareWidth);

                                //水平居中
                                if ((clockinHeight / maxHeight > clockinWidth / maxWidth) || (clockinHeight / maxHeight >= clockinWidth / maxWidth && maxWidth > maxHeight)) {
                                    float scale = (float) maxHeight / clockinHeight;
                                    clockinWidth = (int) (clockinWidth * scale);
                                    clockinHeight = (int) (clockinHeight * scale);
                                    x = x + ((maxWidth - clockinWidth) / 2);
                                }
                                //垂直居中
                                if ((clockinWidth / maxWidth > clockinHeight / maxHeight) || (clockinWidth / maxWidth > clockinHeight / maxHeight && maxWidth < maxHeight)) {
                                    float scale = (float) maxWidth / clockinWidth;
                                    clockinHeight = (int) (clockinHeight * scale);
                                    clockinWidth = (int) (clockinWidth * scale);
                                    y = y + ((maxHeight - clockinHeight) / 2);
                                }

                                //获取背景模糊图片
                                backgroundOut = new ByteArrayOutputStream();
                                Thumbnails.of(clockinBufferedImage).scale(0.5f).outputQuality(0.5f).outputFormat("jpeg").toOutputStream(backgroundOut);
                                backgroundInputStream = FileUtil.parse(backgroundOut);
                                backgroundInputStream = FileUtil.parse(GaussianBlurUtil.blur(backgroundInputStream, 5));
                                backgroundImage = ImageIO.read(backgroundInputStream);

                                //计算背景模糊图片需要的宽高
                                float backgroudRate1 = (float) maxWidth / clockinWidth;
                                float backgroudRate2 = (float) maxHeight / clockinHeight;
                                float backgroudRate = Math.max(backgroudRate1, backgroudRate1);

                                int backgroundWidth = (int) (clockinWidth * backgroudRate);
                                int backgroundHeight = (int) (clockinHeight * backgroudRate);
                                int backgroundX = Math.round(x1 * baseHeight / shareHeight);
                                int backgroundY = Math.round(y1 * baseWidth / shareWidth);
                                if (backgroudRate1 > backgroudRate2) {
                                    backgroundY = y + ((maxHeight - backgroundHeight) / 2);
                                } else {
                                    backgroundX = x + ((maxWidth - backgroundWidth) / 2);
                                }

                                //合并图片
                                out = ImageUtil.addBackground(baseBufferedImage, clockinBufferedImage, backgroundImage, maxWidth, maxHeight, x, y, backgroundWidth, backgroundHeight, backgroundX, backgroundY);
                                //添加文字
//                                if (!isEmpty(textShare)) {
//                                    int fontSize = 35;
//                                    //获得文本偏移参数
//                                    shareHeight = toBigDecimal(textShare.get("BAS_HEIGHT")).intValue();
//                                    shareWidth = toBigDecimal(textShare.get("BAS_WIDTH")).intValue();
//                                    x1 = toInt(textShare.get("BAS_X1"));
//                                    y1 = toInt(textShare.get("BAS_Y1"));
//                                    x2 = toInt(textShare.get("BAS_X2"));
//                                    y2 = toInt(textShare.get("BAS_Y2"));
//
//                                    maxWidth = x2 - x1;
//                                    //左侧的偏移量
//                                    x1 = Math.round(x1 * baseHeight / shareHeight);
//                                    x2 = Math.round(x2 * baseHeight / shareHeight);
//                                    //上侧的偏移量
//                                    y1 = Math.round(y1 * baseWidth / shareWidth) + fontSize;
//                                    y2 = Math.round(y2 * baseWidth / shareWidth) + fontSize;
//
//                                    String waterMarkContent = "打算离开大陆撒开绿灯卡死了低级趣味科技萨达科技萨克来得及卡时间段卡死爱神的箭卡死了京东卡数据库大师啥打卡时间了";
//                                    out = ImageUtil.addWaterMarkText(FileUtil.parse(out), waterMarkContent, x1, y1, x2, y2);
//                                }

                                //转为base64
                                String base64 = " data:image/png;base64," + ImageUtil.imgToBase64(out);

                                //保存图片上传
                                Map<String, Object> configure = Maps.newHashMapWithExpectedSize(6);
                                configure.put("SF_TABLE_NAME", TableName.BUS_WECHAT);
                                configure.put("SF_TABLE_ID", BW_ID);
                                configure.put("SF_SDT_CODE", TableName.BUS_ACHIEVEMENT_SHARE);
                                configure.put("SF_SDI_CODE", BA_ID);
                                configure.put("SF_TYPE_CODE", TableName.BUS_ACHIEVEMENT_DETAIL);

                                Map<String, Object> result = FileUtil.saveImgFile(FileUtil.base64ToMultipart(base64), configure);

                                fileMap = Maps.newHashMapWithExpectedSize(1);
                                fileMap.put("IMG_PATH", result.get("location"));
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            IOUtils.closeQuietly(baseInputStream);
                            IOUtils.closeQuietly(clockinInputStream);
                            IOUtils.closeQuietly(backgroundInputStream);
                            IOUtils.closeQuietly(clockinOut);
                            IOUtils.closeQuietly(backgroundOut);
                            IOUtils.closeQuietly(out);
                            ImageUtil.closeQuietly(baseBufferedImage);
                            ImageUtil.closeQuietly(clockinBufferedImage);
                            ImageUtil.closeQuietly(backgroundImage);
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
