package cn.kim.common.justAuth;

import cn.kim.common.attr.MobileConfig;
import cn.kim.util.ValidateUtil;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.request.AuthWeChatRequest;
import me.zhyd.oauth.utils.UrlBuilder;

/**
 * Created by 余庚鑫 on 2019/12/5
 * 更改微信接口参数
 */
public class MyAuthWeChatRequest extends AuthWeChatRequest {

    public MyAuthWeChatRequest(AuthConfig config) {
        super(config);
    }

    /**
     * 更改scope
     *
     * @param state
     * @return
     */
    @Override
    public String authorize(String state) {
        //基础URL
        String baseUrl = MobileConfig.WECHAT_BASE_URL;
        //scope
        String scope = MobileConfig.WECHAT_SCOPE;
        return UrlBuilder.fromBaseUrl(ValidateUtil.isEmpty(baseUrl) ? WechatSource.WECHAT.authorize() : baseUrl)
                .queryParam("response_type", "code")
                .queryParam("appid", config.getClientId())
                .queryParam("redirect_uri", config.getRedirectUri())
                .queryParam("scope", ValidateUtil.isEmpty(baseUrl) ? "snsapi_userinfo" : scope)
                .queryParam("state", getRealState(state))
                .build();
    }
}
