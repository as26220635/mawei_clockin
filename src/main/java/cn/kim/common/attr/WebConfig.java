package cn.kim.common.attr;

import cn.kim.util.AllocationUtil;
import cn.kim.util.CacheUtil;
import cn.kim.util.TextUtil;

import java.awt.*;

/**
 * Created by 余庚鑫 on 2019/12/1
 * 网站配置参数
 */
public class WebConfig {
    /**
     * 网站头标题
     */
    public static String WEBCONFIG_HEAD_TITLE;
    /**
     * 登录标题
     */
    public static String WEBCONFIG_LOGIN_TITLE;
    /**
     * 后台菜单标题
     */
    public static String WEBCONFIG_MENU_TITLE;
    /**
     * 后台菜单小标题
     */
    public static String WEBCONFIG_MENU_SMALL_TITLE;
    /**
     * 文件服务器地址
     */
    public static String WEBCONFIG_FILE_SERVER_URL;
    /**
     * 百度地图（AK）
     */
    public static String WEBCONFIG_BAIDU_MAP_AK;


    /**
     * 初始化
     */
    public static void init() {
        WEBCONFIG_HEAD_TITLE = TextUtil.toString(AllocationUtil.get("WEBCONFIG_HEAD_TITLE"));
        WEBCONFIG_LOGIN_TITLE = TextUtil.toString(AllocationUtil.get("WEBCONFIG_LOGIN_TITLE"));
        WEBCONFIG_MENU_TITLE = TextUtil.toString(AllocationUtil.get("WEBCONFIG_MENU_TITLE"));
        WEBCONFIG_MENU_SMALL_TITLE = TextUtil.toString(AllocationUtil.get("WEBCONFIG_MENU_SMALL_TITLE"));
        WEBCONFIG_FILE_SERVER_URL = TextUtil.toString(AllocationUtil.get("WEBCONFIG_FILE_SERVER_URL"));
        WEBCONFIG_BAIDU_MAP_AK = TextUtil.toString(AllocationUtil.get("WEBCONFIG_BAIDU_MAP_AK"));
    }
}
