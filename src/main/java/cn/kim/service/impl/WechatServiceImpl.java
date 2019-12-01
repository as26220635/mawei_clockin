package cn.kim.service.impl;

import cn.kim.common.attr.*;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.common.eu.UseType;
import cn.kim.entity.WechatUser;
import cn.kim.exception.CustomException;
import cn.kim.remote.LogRemoteInterfaceAsync;
import cn.kim.service.WechatService;
import cn.kim.service.WechatService;
import cn.kim.util.DateUtil;
import cn.kim.util.LogUtil;
import cn.kim.util.TextUtil;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/28
 * 成就墙管理
 */
@Service
public class WechatServiceImpl extends BaseServiceImpl implements WechatService {

    @Autowired
    private LogRemoteInterfaceAsync logRemoteInterfaceAsync;

    @Override
    @Transactional
    public Map<String, Object> wechatLogin(WechatUser wechatUser) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            //查询是否已经登录过
            paramMap.put("BW_OPENID", wechatUser.getOpenId());
            Map<String, Object> wechat = selectWechat(paramMap);

            String ID;
            String operatorId;

            paramMap.clear();
            paramMap.put("BW_UUID", wechatUser.getUuid());
            paramMap.put("BW_USERNAME", wechatUser.getUsername());
            paramMap.put("BW_NICKNAME", wechatUser.getNickname());
            paramMap.put("BW_GENDER", wechatUser.getGender());
            paramMap.put("BW_AVATAR", wechatUser.getAvatar());
            paramMap.put("BW_LOCATION", wechatUser.getLocation());
            paramMap.put("BW_SOURCE", wechatUser.getSource());
            paramMap.put("BW_ACCESSTOKEN", wechatUser.getAccessToken());
            paramMap.put("BW_EXPIREIN", wechatUser.getExpireIn());
            paramMap.put("BW_REFRESHTOKEN", wechatUser.getRefreshToken());
            paramMap.put("BW_LOGINTIME", getDate());

            //没有登陆过插入信息
            if (isEmpty(wechat)) {
                ID = getId();
                //插入操作员表
                operatorId = insertOperator(baseDao, SystemEnum.WECHAT.getType(), ID, wechatUser.getUsername());

                paramMap.put("ID", ID);
                paramMap.put("SO_ID", operatorId);
                paramMap.put("BW_OPENID", wechatUser.getOpenId());
                paramMap.put("BW_ENTRYTIME", getDate());
                paramMap.put("IS_STATUS", STATUS_SUCCESS);
                baseDao.insert(NameSpace.WechatMapper, "insertWechat", paramMap);
            } else {
                ID = toString(wechat.get("ID"));
                operatorId = toString(wechat.get("SO_ID"));
                //更新登录记录
                paramMap.put("ID", ID);
                baseDao.update(NameSpace.WechatMapper, "updateWechat", paramMap);
                //更新账号信息表
                paramMap.clear();
                paramMap.put("SEARCH_SO_ID", operatorId);
                paramMap.put("SAI_NAME", wechatUser.getUsername());
                baseDao.insert(NameSpace.OperatorMapper, "updateAccountInfo", paramMap);
            }

            resultMap.put(MagicValue.ID, ID);
            //记录日志
            logRemoteInterfaceAsync.recordLoginLog(wechatUser.getIp(), operatorId, MagicValue.LOG_LOGIN_EVENT, JSON.toJSONString(wechatUser), UseType.WECHAT.getType(), Attribute.STATUS_SUCCESS);

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public Map<String, Object> selectWechat(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BW_OPENID", mapParam.get("BW_OPENID"));
        return baseDao.selectOne(NameSpace.WechatMapper, "selectWechat", paramMap);
    }

    @Override
    public Map<String, Object> selectWechatRank(String BW_ID) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(2);

        List<Map<String, Object>> rankList = baseDao.selectList(NameSpace.WechatMapper, "selectWechatRank");

        resultMap.put("ID", BW_ID);
        Map<String, Object> myRank = baseDao.selectOne(NameSpace.WechatMapper, "selectWechatRankByWechatId", resultMap);

        resultMap.clear();
        resultMap.put("rankList", rankList);
        resultMap.put("myRank", myRank);
        return resultMap;
    }

    @Override
    @Transactional
    public Map<String, Object> changeWechatStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            String id = toString(mapParam.get("ID"));

            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectWechat(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_WECHAT);
            baseDao.update(NameSpace.WechatMapper, "updateWechat", paramMap);
            resultMap.put(MagicValue.LOG, "更新微信用户状态,名称:" + toString(oldMap.get("BW_USERNAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;

            resultMap.put("ID", id);
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }
}
