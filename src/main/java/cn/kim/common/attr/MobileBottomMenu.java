package cn.kim.common.attr;

import cn.kim.util.AllocationUtil;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/3
 * 前端底部菜单配置
 */
public class MobileBottomMenu {
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
     * 初始化
     */
    public static void init() {
        MOBILE_BOTTOM_MENU_CLOCKIN = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_CLOCKIN"));
        MOBILE_BOTTOM_MENU_ACTIVITY = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_ACTIVITY"));
        MOBILE_BOTTOM_MENU_RANK = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_RANK"));
        MOBILE_BOTTOM_MENU_ACHIEVEMENT = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_ACHIEVEMENT"));
        MOBILE_BOTTOM_MENU_MY = TextUtil.toInt(AllocationUtil.get("MOBILE_BOTTOM_MENU_MY"));
    }

    /**
     * 获取配置
     *
     * @return
     */
    public static Map<String, Integer> getConfig() {
        Map<String, Integer> config = Maps.newHashMapWithExpectedSize(5);
        config.put("MOBILE_BOTTOM_MENU_CLOCKIN", MOBILE_BOTTOM_MENU_CLOCKIN);
        config.put("MOBILE_BOTTOM_MENU_ACTIVITY", MOBILE_BOTTOM_MENU_ACTIVITY);
        config.put("MOBILE_BOTTOM_MENU_RANK", MOBILE_BOTTOM_MENU_RANK);
        config.put("MOBILE_BOTTOM_MENU_ACHIEVEMENT", MOBILE_BOTTOM_MENU_ACHIEVEMENT);
        config.put("MOBILE_BOTTOM_MENU_MY", MOBILE_BOTTOM_MENU_MY);
        return config;
    }
}
