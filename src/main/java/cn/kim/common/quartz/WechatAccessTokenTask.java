package cn.kim.common.quartz;

import cn.kim.common.BaseData;
import cn.kim.common.attr.MagicValue;
import cn.kim.tools.HttpClient;
import cn.kim.util.AllocationUtil;
import cn.kim.util.DateUtil;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/13
 * 微信AccessToken 定时刷新
 */
@Component
public class WechatAccessTokenTask extends BaseData {

    @Scheduled(cron = "0 0 0/1 * * ?")
    public void getAccessToken() {
        //判断是否授权过期需要重新获取
        Long WECHAT_ACCESS_TOKEN_EXPIRES_STAMP = toLong(AllocationUtil.get("WECHAT_ACCESS_TOKEN_EXPIRES_STAMP"));
        if (!isEmpty(WECHAT_ACCESS_TOKEN_EXPIRES_STAMP)) {
            //偏移20分钟
            if (DateUtil.moveDate(Calendar.MINUTE, true, new Date(), 20).getTime() < WECHAT_ACCESS_TOKEN_EXPIRES_STAMP) {
                return;
            }
        }

//        https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";

        Map<String, String> params = Maps.newHashMapWithExpectedSize(2);
        params.put("appid", toString(AllocationUtil.get("WECHAT_CLIENT_ID")));
        params.put("secret", toString(AllocationUtil.get("WECHAT_CLIENT_SECRET")));
        HttpClient httpClient = new HttpClient();
        Map<String, Object> resultMap = httpClient.get(url, params);
        if (isSuccess(resultMap)) {
            JSONObject object = JSONObject.parseObject(toString(resultMap.get(MagicValue.DESC)));

            String access_token = object.getString("access_token");
            int expires_in = object.getInteger("expires_in");
            //缓存参数
            AllocationUtil.put("WECHAT_ACCESS_TOKEN", access_token);
            AllocationUtil.put("WECHAT_ACCESS_TOKEN_EXPIRES_IN", expires_in);
            //过期时间戳
            AllocationUtil.put("WECHAT_ACCESS_TOKEN_EXPIRES_STAMP", DateUtil.moveDate(Calendar.SECOND, true, new Date(), expires_in).getTime());

            //获取ticket
            url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi";
            params.clear();
            params.put("access_token", access_token);
            resultMap = httpClient.get(url, params);
            if (isSuccess(resultMap)) {
                object = JSONObject.parseObject(toString(resultMap.get(MagicValue.DESC)));
                String ticket = object.getString("ticket");
                //缓存参数
                AllocationUtil.put("WECHAT_TICKET", ticket);
            }
        }
    }
}
