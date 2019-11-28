package cn.kim.service;

import cn.kim.entity.WechatUser;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 微信账号管理
 */
public interface WechatService extends BaseService {

    /**
     * 用户登录记录
     *
     * @param wechatUser
     * @return
     */
    Map<String, Object> wechatLogin(WechatUser wechatUser);

    /**
     * 查询用户
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectWechat(Map<String, Object> mapParam);
}
