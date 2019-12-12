package cn.kim.service;

import cn.kim.entity.DataTablesView;
import cn.kim.entity.WechatUser;

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

    /**
     * 查询排名
     *
     * @param BW_ID
     * @return
     */
    Map<String, Object> selectWechatRank(String BW_ID);

    /**
     * 变更状态
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeWechatStatus(Map<String, Object> mapParam);

    /**
     * 查询联系客服图片
     *
     * @return
     */
    String selectContactServiceFile();

    /**
     * 查询排名数
     *
     * @return
     */
    Integer selectRankCount();

    /**
     * 查询列表
     *
     * @param BW_USERNAME
     * @return
     */
    DataTablesView<?> selectRank(int offset, int limit, String BW_USERNAME);

    /**
     * 微信点赞
     *
     * @param fromId
     * @param toId
     * @param action
     * @return
     */
    Map<String, Object> wechatPraisePoint(String fromId, String toId, int action);
}
