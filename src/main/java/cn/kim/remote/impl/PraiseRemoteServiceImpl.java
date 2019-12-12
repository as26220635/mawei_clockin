package cn.kim.remote.impl;

import cn.kim.common.BaseData;
import cn.kim.common.DaoSession;
import cn.kim.common.eu.NameSpace;
import cn.kim.dao.BaseDao;
import cn.kim.remote.PraiseRemoteInterface;
import com.google.common.collect.Maps;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/12
 * 点赞实现
 */
public class PraiseRemoteServiceImpl extends BaseData implements PraiseRemoteInterface {

    @Override
    public void praise(String fromId, String toId, int action, String date) {
        //存入点赞
        try {
            BaseDao baseDao = DaoSession.daoSession.baseDao;
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(4);

            if (action == 1) {
                //点赞
                paramMap.clear();
                paramMap.put("BW_ID", toId);
                Map<String, Object> praise = baseDao.selectOne(NameSpace.WechatMapper, "selectWechatPraise", paramMap);
                if (isEmpty(praise)) {
                    //插入
                    praise = Maps.newHashMapWithExpectedSize(3);
                    praise.put("ID", getId());
                    praise.put("BW_ID", toId);
                    praise.put("BWP_NUMBER", 1);
                    baseDao.insert(NameSpace.WechatMapper, "insertWechatPraise", praise);
                } else {
                    //更新
                    paramMap.clear();
                    paramMap.put("ID", praise.get("ID"));
                    paramMap.put("BWP_NUMBER", toInt(praise.get("BWP_NUMBER")) + 1);
                    baseDao.update(NameSpace.WechatMapper, "updateWechatPraise", paramMap);
                }
                //插入详细表
                paramMap.clear();
                paramMap.put("ID", getId());
                paramMap.put("BWPP_FROM_ID", fromId);
                paramMap.put("BWPP_TO_ID", toId);
                paramMap.put("BWPP_ENTRY_TIME", date);
                baseDao.insert(NameSpace.WechatMapper, "insertWechatPraisePoint", paramMap);
            } else {
                //取消
                paramMap.clear();
                paramMap.put("BW_ID", toId);
                Map<String, Object> praise = baseDao.selectOne(NameSpace.WechatMapper, "selectWechatPraise", paramMap);
                if (isEmpty(praise)) {
                    //插入
                    praise = Maps.newHashMapWithExpectedSize(3);
                    praise.put("ID", getId());
                    praise.put("BW_ID", toId);
                    praise.put("BWP_NUMBER", 0);
                    baseDao.insert(NameSpace.WechatMapper, "insertWechatPraise", praise);
                } else {
                    //更新
                    paramMap.clear();
                    paramMap.put("ID", praise.get("ID"));
                    paramMap.put("BWP_NUMBER", toInt(praise.get("BWP_NUMBER")) - 1);
                    baseDao.update(NameSpace.WechatMapper, "updateWechatPraise", paramMap);
                }

                //删除详细表
                paramMap.clear();
                paramMap.put("BWPP_FROM_ID", fromId);
                paramMap.put("BWPP_TO_ID", toId);
                baseDao.delete(NameSpace.WechatMapper, "deleteWechatPraisePoint", paramMap);
            }
        } catch (Exception e) {
        }
    }
}
