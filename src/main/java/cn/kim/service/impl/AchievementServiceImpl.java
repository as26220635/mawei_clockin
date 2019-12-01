package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.AchievementService;
import cn.kim.service.AchievementService;
import cn.kim.util.CommonUtil;
import cn.kim.util.DictUtil;
import cn.kim.util.FileUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 成就墙管理
 */
@Service
public class AchievementServiceImpl extends BaseServiceImpl implements AchievementService {

    @Override
    public Map<String, Object> selectAchievement(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.AchievementMapper, "selectAchievement", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMAchievementList() {
        return baseDao.selectList(NameSpace.AchievementMapper, "selectMAchievement");
    }

    @Override
    public List<Map<String, Object>> selectMAchievementListByWechat(String ID) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", ID);
        List<Map<String, Object>> list = baseDao.selectList(NameSpace.AchievementMapper, "selectMAchievementListByWechat", paramMap);

        //文件路径加密
        FileUtil.filePathTobase64(list, "IMG_PATH");
        return list;
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateAchievement(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT);

            paramMap.put("ID", id);
            paramMap.put("BA_NAME", mapParam.get("BA_NAME"));
            paramMap.put("BA_LONGITUDE", mapParam.get("BA_LONGITUDE"));
            paramMap.put("BA_LATITUDE", mapParam.get("BA_LATITUDE"));
            paramMap.put("BA_RANGE", mapParam.get("BA_RANGE"));
            paramMap.put("BA_ENTRYTIME", mapParam.get("BA_ENTRYTIME"));

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BD_ENTER_TIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("IS_STATUS", STATUS_SUCCESS);

                baseDao.insert(NameSpace.AchievementMapper, "insertAchievement", paramMap);
                resultMap.put(MagicValue.LOG, "添加成就墙:" + formatColumnName(TableName.BUS_ACHIEVEMENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectAchievement(oldMap);

                baseDao.update(NameSpace.AchievementMapper, "updateAchievement", paramMap);
                resultMap.put(MagicValue.LOG, "更新成就墙,更新前:" + formatColumnName(TableName.BUS_ACHIEVEMENT, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_ACHIEVEMENT, paramMap));
            }
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

    @Override
    @Transactional
    public Map<String, Object> changeAchievementStatus(Map<String, Object> mapParam) {
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
            oldMap = selectAchievement(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT);
            baseDao.update(NameSpace.AchievementMapper, "updateAchievement", paramMap);
            resultMap.put(MagicValue.LOG, "更新成就墙状态,名称:" + toString(oldMap.get("BA_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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

    @Override
    @Transactional
    public Map<String, Object> deleteAchievement(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除成就墙表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAchievement(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT);
            baseDao.delete(NameSpace.AchievementMapper, "deleteAchievement", paramMap);

            resultMap.put(MagicValue.LOG, "删除成就墙,信息:" + formatColumnName(TableName.BUS_ACHIEVEMENT, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    @Override
    public Map<String, Object> selectAchievementDetail(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.AchievementMapper, "selectAchievementDetail", paramMap);
    }

    @Override
    public Map<String, Object> selectMAchievementDetailById(String ID) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", ID);

        Map<String, Object> map = baseDao.selectOne(NameSpace.AchievementMapper, "selectMAchievementDetail", paramMap);

        //文件路径加密
        FileUtil.filePathTobase64(map, "FILE_PATH");
        return map;
    }

    @Override
    public DataTablesView<?> selectMAchievementDetailList(int offset, int limit, String BW_ID) {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        QuerySet querySet = new QuerySet();

        //连接名称
        querySet.set(QuerySet.EQ, "BW_ID", BW_ID);

        querySet.setOffset(offset);
        querySet.setLimit(limit);

        querySet.setOrderByClause("BAD_ENTERTIME DESC");
        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.AchievementMapper, "selectMAchievementDetailList", querySet.getWhereMap());
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    @Override
    public Integer selectAchievementDetailListCountByWechatId(String BW_ID) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BW_ID", BW_ID);
        return baseDao.selectOne(NameSpace.AchievementMapper, "selectAchievementDetailListCount", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateAchievementDetail(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT);

            paramMap.put("ID", id);
            paramMap.put("BA_ID", mapParam.get("BA_ID"));
            paramMap.put("BW_ID", mapParam.get("BW_ID"));
            paramMap.put("BAD_REMARKS", mapParam.get("BAD_REMARKS"));
            paramMap.put("BAD_FILETYPE", mapParam.get("BAD_FILETYPE"));

            if (isEmpty(id)) {
                id = getId();
                paramMap.put("ID", id);
                paramMap.put("BAD_ENTERTIME", getDate());

                baseDao.insert(NameSpace.AchievementMapper, "insertAchievementDetail", paramMap);
                resultMap.put(MagicValue.LOG, "添加打卡信息:" + formatColumnName(TableName.BUS_ACHIEVEMENT, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectAchievementDetail(oldMap);

                baseDao.update(NameSpace.AchievementMapper, "updateAchievementDetail", paramMap);
                resultMap.put(MagicValue.LOG, "更新打卡信息,更新前:" + formatColumnName(TableName.BUS_ACHIEVEMENT, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_ACHIEVEMENT, paramMap));
            }
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

    @Override
    @Transactional
    public Map<String, Object> deleteAchievementDetail(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除打卡信息表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectAchievementDetail(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT);
            baseDao.delete(NameSpace.AchievementMapper, "deleteAchievementDetail", paramMap);

            resultMap.put(MagicValue.LOG, "删除打卡信息,信息:" + formatColumnName(TableName.BUS_ACHIEVEMENT, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }


}
