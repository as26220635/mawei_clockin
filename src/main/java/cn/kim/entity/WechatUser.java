package cn.kim.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by 余庚鑫 on 2019/11/28
 * 微信用户登录参数
 */
@Data
public class WechatUser implements Serializable {
    /**
     * 唯一id
     */
    private String id;
    /**
     * id
     */
    private String uuid;
    /**
     * 用户名
     */
    private String username;
    /**
     * 别名
     */
    private String nickname;
    /**
     * 性别
     */
    private String gender;
    /**
     * 头像地址
     */
    private String avatar;
    /**
     * 来源
     */
    private String source;
    /**
     *
     */
    private String location;
    /**
     * 授权token
     */
    private String accessToken;
    /**
     * 超时时间
     */
    private int expireIn;
    /**
     * openId
     */
    private String openId;
    /**
     * refreshToken
     */
    private String refreshToken;
    private String ip;
}
