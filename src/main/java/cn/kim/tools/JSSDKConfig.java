package cn.kim.tools;

import cn.kim.common.attr.MobileConfig;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;

import java.security.MessageDigest;
import java.util.Formatter;
import java.util.Map;
import java.util.UUID;

/**
 * Created by 余庚鑫 on 2019/12/14
 * jssdk配置
 */
public class JSSDKConfig {

    /**
     * @param @return hashmap {appid,timestamp,nonceStr,signature}
     * @param @throws Exception
     * @Description: 前端jssdk页面配置需要用到的配置参数
     * @author gede
     */
    public static Map<String, String> jsSDKSign(String url) throws Exception {
        String nonce_str = create_nonce_str();
        String timestamp = TextUtil.toString(System.currentTimeMillis());
        String jsapi_ticket = MobileConfig.WECHAT_TICKET;
        // 注意这里参数名必须全部小写，且必须有序
        String string1 = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonce_str
                + "&timestamp=" + timestamp + "&url=" + url;
        MessageDigest crypt = MessageDigest.getInstance("SHA-1");
        crypt.reset();
        crypt.update(string1.getBytes("UTF-8"));
        String signature = byteToHex(crypt.digest());
        Map<String, String> jssdk = Maps.newHashMapWithExpectedSize(4);
        jssdk.put("appId", MobileConfig.WECHAT_CLIENT_ID);
        jssdk.put("timestamp", timestamp);
        jssdk.put("nonceStr", nonce_str);
        jssdk.put("signature", signature);
        return jssdk;

    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash) {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }
}
