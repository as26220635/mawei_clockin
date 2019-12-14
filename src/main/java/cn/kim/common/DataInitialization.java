package cn.kim.common;

import cn.kim.common.attr.CacheName;
import cn.kim.common.attr.MobileConfig;
import cn.kim.common.attr.WebConfig;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.quartz.WechatAccessTokenTask;
import cn.kim.dao.BaseDao;
import cn.kim.service.AchievementSearchService;
import cn.kim.util.CacheUtil;
import cn.kim.util.DictUtil;
import cn.kim.util.EmailUtil;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import java.security.Security;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/7/3.
 * spring/mvc 启动完成后初始化数据
 */
@Component("DataInitialization")
public class DataInitialization extends BaseData implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    public BaseDao baseDao;

    @Autowired
    private RedissonClient redisson;

    @Autowired
    private AchievementSearchService achievementSearchService;

    @Autowired
    private WechatAccessTokenTask wechatAccessTokenTask;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        if (contextRefreshedEvent.getApplicationContext().getParent() == null) {
            //设置AES加密包
            Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
            //加载字典
            DictUtil.initDictToCache();

            //加载邮箱配置
            EmailUtil.init();

            //加载网站参数
            WebConfig.init();

            //获取微信access_token
            wechatAccessTokenTask.getAccessToken();

            //前端管理配置
            MobileConfig.init();

            //初始化搜索数据
            try {
                achievementSearchService.init();
            } catch (Exception e) {
            }

            //初始化点赞数据
            CacheUtil.clear(CacheName.WECHAT_PRAISE);
            CacheUtil.clear(CacheName.WECHAT_PRAISE_POINTS);

            List<Map<String, Object>> praiseList = baseDao.selectList(NameSpace.WechatMapper, "selectWechatPraise");
            for (Map<String, Object> praise : praiseList) {
                CacheUtil.put(CacheName.WECHAT_PRAISE, toString(praise.get("BW_ID")), praise.get("BWP_NUMBER"));
            }

            List<Map<String, Object>> pointList = baseDao.selectList(NameSpace.WechatMapper, "selectWechatPraisePoint");
            for (Map<String, Object> point : pointList) {
                String fromId = toString(point.get("BWPP_FROM_ID"));
                String toId = toString(point.get("BWPP_TO_ID"));
                CacheUtil.put(CacheName.WECHAT_PRAISE_POINTS, fromId + "@@@" + toId, fromId + "@@@" + toId);
            }
        }
    }
}
