package cn.kim.common.attr;

import cn.kim.common.DaoSession;
import cn.kim.common.eu.NameSpace;
import cn.kim.dao.BaseDao;
import cn.kim.util.*;
import com.google.common.collect.Maps;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/3
 * 前端管理配置
 */
public class MobileConfig {

    /**
     * 微信access_token
     */
    public static String WECHAT_ACCESS_TOKEN;
    public static Integer WECHAT_ACCESS_TOKEN_EXPIRES_IN;
    public static String WECHAT_TICKET;
    /**
     * 微信
     */
    public static String WECHAT_BASE_URL;
    /**
     * 微信
     */
    public static String WECHAT_SCOPE;
    /**
     * 微信
     */
    public static String WECHAT_CLIENT_ID;
    /**
     * 微信
     */
    public static String WECHAT_CLIENT_SECRET;
    /**
     * 微信回调内容
     */
    public static String WECHAT_REDIRECT_URI;
    /**
     * 公众号用户名
     */
    public static String MOBILE_OFFICIAL_USERNAME;
    /**
     * 青春打卡
     */
    public static Integer MOBILE_BOTTOM_MENU_CLOCKIN;
    /**
     * 活动
     */
    public static Integer MOBILE_BOTTOM_MENU_ACTIVITY;
    /**
     * 排行榜
     */
    public static Integer MOBILE_BOTTOM_MENU_RANK;
    /**
     * 成就墙
     */
    public static Integer MOBILE_BOTTOM_MENU_ACHIEVEMENT;
    /**
     * 个人中心
     */
    public static Integer MOBILE_BOTTOM_MENU_MY;
    /**
     * 打卡是否可以上传图片
     */
    public static Integer MOBILE_CLOCKIN_UPLOAD_IMG;
    /**
     * 打卡是否可以上传视频
     */
    public static Integer MOBILE_CLOCKIN_UPLOAD_VIDEO;
    /**
     * 青春打卡横幅内容
     */
    public static String MOBILE_CLOCKIN_BANNER_CONTENT;
    /**
     * 点赞开始时间
     */
    public static Long PRAISE_POINT_START_TIME;
    public static String PRAISE_POINT_START_TIME_STR;
    /**
     * 点赞结束时间
     */
    public static Long PRAISE_POINT_END_TIME;
    public static String PRAISE_POINT_END_TIME_STR;
    /**
     * 配置MAP
     */
    public static Map<String, Object> config = Maps.newHashMapWithExpectedSize(8);

    /**
     * 初始化
     */
    public static void init() {
        BaseDao baseDao = DaoSession.daoSession.baseDao;
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);

        WECHAT_ACCESS_TOKEN = TextUtil.toString(AllocationUtil.get("WECHAT_ACCESS_TOKEN"));
        WECHAT_ACCESS_TOKEN_EXPIRES_IN = TextUtil.toInt(AllocationUtil.get("WECHAT_ACCESS_TOKEN_EXPIRES_IN"));
        WECHAT_TICKET = TextUtil.toString(AllocationUtil.get("WECHAT_TICKET"));

        WECHAT_BASE_URL = TextUtil.toString(AllocationUtil.get("WECHAT_BASE_URL"));
        WECHAT_SCOPE = TextUtil.toString(AllocationUtil.get("WECHAT_SCOPE"));
        WECHAT_CLIENT_ID = TextUtil.toString(AllocationUtil.get("WECHAT_CLIENT_ID"));
        WECHAT_CLIENT_SECRET = TextUtil.toString(AllocationUtil.get("WECHAT_CLIENT_SECRET"));
        WECHAT_REDIRECT_URI = TextUtil.toString(AllocationUtil.get("WECHAT_REDIRECT_URI"));

        MOBILE_OFFICIAL_USERNAME = TextUtil.toString(AllocationUtil.get("MOBILE_OFFICIAL_USERNAME"));
        MOBILE_BOTTOM_MENU_CLOCKIN = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_CLOCKIN"));
        MOBILE_BOTTOM_MENU_ACTIVITY = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_ACTIVITY"));
        MOBILE_BOTTOM_MENU_RANK = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_RANK"));
        MOBILE_BOTTOM_MENU_ACHIEVEMENT = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_ACHIEVEMENT"));
        MOBILE_BOTTOM_MENU_MY = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_MY"));
        MOBILE_CLOCKIN_UPLOAD_IMG = TextUtil.toInt(AllocationUtil.get("MOBILE_CLOCKIN_UPLOAD_IMG"));
        MOBILE_CLOCKIN_UPLOAD_VIDEO = TextUtil.toInt(AllocationUtil.get("MOBILE_CLOCKIN_UPLOAD_VIDEO"));
        MOBILE_CLOCKIN_BANNER_CONTENT = TextUtil.toString(AllocationUtil.get("MOBILE_CLOCKIN_BANNER_CONTENT"));

        //点赞时间范围
        PRAISE_POINT_START_TIME_STR = TextUtil.toString(AllocationUtil.get("PRAISE_POINT_START_TIME"));
        if (!ValidateUtil.isEmpty(PRAISE_POINT_START_TIME_STR)) {
            PRAISE_POINT_START_TIME = DateUtil.getDateTime(DateUtil.FORMAT, PRAISE_POINT_START_TIME_STR).getTime();
        }
        PRAISE_POINT_END_TIME_STR = TextUtil.toString(AllocationUtil.get("PRAISE_POINT_END_TIME"));
        if (!ValidateUtil.isEmpty(PRAISE_POINT_END_TIME_STR)) {
            PRAISE_POINT_END_TIME = DateUtil.getDateTime(DateUtil.FORMAT, PRAISE_POINT_END_TIME_STR).getTime();
        }

        //刷新参数
        config.clear();
        config.put("MOBILE_BOTTOM_MENU_CLOCKIN", MOBILE_BOTTOM_MENU_CLOCKIN);
        config.put("MOBILE_BOTTOM_MENU_ACTIVITY", MOBILE_BOTTOM_MENU_ACTIVITY);
        config.put("MOBILE_BOTTOM_MENU_RANK", MOBILE_BOTTOM_MENU_RANK);
        config.put("MOBILE_BOTTOM_MENU_ACHIEVEMENT", MOBILE_BOTTOM_MENU_ACHIEVEMENT);
        config.put("MOBILE_BOTTOM_MENU_MY", MOBILE_BOTTOM_MENU_MY);
        //图标地址
        paramMap.put("SF_SDT_CODE", "MOBILE_BOTTOM_MENU");

        paramMap.put("SF_TABLE_ID", "1");
        Map<String, Object> icon = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
        FileUtil.filePathTobase64(icon, "FILE_PATH");
        config.put("MOBILE_BOTTOM_MENU_CLOCKIN_ICON", icon.get("FILE_PATH"));

        paramMap.put("SF_TABLE_ID", "2");
        icon = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
        FileUtil.filePathTobase64(icon, "FILE_PATH");
        config.put("MOBILE_BOTTOM_MENU_ACTIVITY_ICON", icon.get("FILE_PATH"));

        paramMap.put("SF_TABLE_ID", "3");
        icon = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
        FileUtil.filePathTobase64(icon, "FILE_PATH");
        config.put("MOBILE_BOTTOM_MENU_RANK_ICON", icon.get("FILE_PATH"));

        paramMap.put("SF_TABLE_ID", "4");
        icon = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
        FileUtil.filePathTobase64(icon, "FILE_PATH");
        config.put("MOBILE_BOTTOM_MENU_ACHIEVEMENT_ICON", icon.get("FILE_PATH"));

        paramMap.put("SF_TABLE_ID", "5");
        icon = baseDao.selectOne(NameSpace.FileMapper, "selectFile", paramMap);
        FileUtil.filePathTobase64(icon, "FILE_PATH");
        config.put("MOBILE_BOTTOM_MENU_MY_ICON", icon.get("FILE_PATH"));

        config.put("MOBILE_CLOCKIN_UPLOAD_IMG", MOBILE_CLOCKIN_UPLOAD_IMG);
        config.put("MOBILE_CLOCKIN_UPLOAD_VIDEO", MOBILE_CLOCKIN_UPLOAD_VIDEO);
        config.put("MOBILE_CLOCKIN_BANNER_CONTENT", MOBILE_CLOCKIN_BANNER_CONTENT);
    }

    /**
     * 获取配置
     *
     * @return
     */
    public static Map<String, Object> getConfig() {
        return config;
    }
}
