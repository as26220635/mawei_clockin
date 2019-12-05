package cn.kim.common.justAuth;

import me.zhyd.oauth.config.AuthSource;

/**
 * Created by 余庚鑫 on 2019/12/5
 * 自定义微信授权
 */
public enum WechatSource implements AuthSource {
    /**
     * 微信
     */
    WECHAT {
        @Override
        public String authorize() {
//            return "https://open.weixin.qq.com/connect/qrconnect";
            return "https://open.weixin.qq.com/connect/oauth2/authorize";
        }

        @Override
        public String accessToken() {
            return "https://api.weixin.qq.com/sns/oauth2/access_token";
        }

        @Override
        public String userInfo() {
            return "https://api.weixin.qq.com/sns/userinfo";
        }

        @Override
        public String refresh() {
            return "https://api.weixin.qq.com/sns/oauth2/refresh_token";
        }
    },
}
