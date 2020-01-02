package cn.kim.common.quartz;

import cn.kim.common.BaseData;
import cn.kim.common.attr.MagicValue;
import cn.kim.entity.WechatUser;
import cn.kim.service.WechatService;
import cn.kim.tools.HttpClient;
import cn.kim.util.AllocationUtil;
import cn.kim.util.DateUtil;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/27
 * 每10分钟更新排名
 */
@Component
public class WechatRankTask extends BaseData {

    @Autowired
    private WechatService wechatService;

    @Scheduled(cron = "0 0/1 * * * ?")
    public void rank() {
        wechatService.updateWechatRank();
    }
}
