package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.exception.CustomException;
import cn.kim.service.ActivityService;
import cn.kim.service.FileService;
import cn.kim.util.FileUtil;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/12
 * 活动管理
 */
@Service
public class ActivityServiceImpl extends BaseServiceImpl implements ActivityService {

    @Autowired
    private FileService fileService;

    @Override
    public Map<String, Object> selectActivity(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.ActivityMapper, "selectActivity", paramMap);
    }

    @Override
    public Map<String, Object> selectActivityById(String ID) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", ID);
        return baseDao.selectOne(NameSpace.ActivityMapper, "selectActivity", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateActivity(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACTIVITY);

            paramMap.put("ID", id);
            paramMap.put("BA_TITLE", mapParam.get("BA_TITLE"));
            paramMap.put("BA_SOURCE", mapParam.get("BA_SOURCE"));
            paramMap.put("BA_IS_WECHAT", mapParam.get("BA_IS_WECHAT"));
            paramMap.put("BA_WECHAT_URL", mapParam.get("BA_WECHAT_URL"));
            paramMap.put("BA_CONTENT", unescapeHtml4(mapParam.get("BA_CONTENT")));
            paramMap.put("BA_UPDATE_TIME", getDate());
            paramMap.put("SO_ID", getActiveUser().getId());

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BA_ENTRY_TIME", getDate());
                paramMap.put("IS_STATUS", STATUS_SUCCESS);

                baseDao.insert(NameSpace.ActivityMapper, "insertActivity", paramMap);
                resultMap.put(MagicValue.LOG, "添加活动:" + formatColumnName(TableName.BUS_ACTIVITY, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectActivity(oldMap);

                baseDao.update(NameSpace.ActivityMapper, "updateActivity", paramMap);
                resultMap.put(MagicValue.LOG, "更新活动,更新前:" + formatColumnName(TableName.BUS_ACTIVITY, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_ACTIVITY, paramMap));
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
    public Map<String, Object> changeActivityStatus(Map<String, Object> mapParam) {
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
            oldMap = selectActivity(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACTIVITY);
            baseDao.update(NameSpace.ActivityMapper, "updateActivity", paramMap);
            resultMap.put(MagicValue.LOG, "更新活动状态,名称:" + toString(oldMap.get("BA_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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
    public Map<String, Object> deleteActivity(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除活动表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectActivity(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACTIVITY);
            baseDao.delete(NameSpace.ActivityMapper, "deleteActivity", paramMap);

            //删除附件
            paramMap.clear();
            paramMap.put("SF_TABLE_ID", id);
            paramMap.put("SF_TABLE_NAME", TableName.BUS_ACTIVITY);
            List<Map<String, Object>> fileList = baseDao.selectList(NameSpace.FileMapper, "selectFile", paramMap);
            for (Map<String, Object> file : fileList) {
                fileService.deleteFile(toString(file.get("ID")));
            }
            deleteFile(id, TableName.BUS_ACTIVITY);

            resultMap.put(MagicValue.LOG, "删除活动,信息:" + formatColumnName(TableName.BUS_ACTIVITY, oldMap));
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
    public DataTablesView<?> selectMActivityList(int offset, int limit) {
        DataTablesView<Map<String, Object>> dataTablesView = new DataTablesView<>();
        QuerySet querySet = new QuerySet();

        querySet.set(QuerySet.EQ, "IS_STATUS", STATUS_SUCCESS);

        querySet.setOffset(offset);
        querySet.setLimit(limit);

        querySet.setOrderByClause("BA_ENTRY_TIME DESC");
        List<Map<String, Object>> dataList = baseDao.selectList(NameSpace.ActivityMapper, "selectMActivityList", querySet.getWhereMap());
        //文件路径加密
        FileUtil.filePathTobase64(dataList, "IMG_PATH");
        dataTablesView.setData(dataList);

        return dataTablesView;
    }

    @Override
    public Integer selectActivityListCount() {
        return baseDao.selectOne(NameSpace.ActivityMapper, "selectMActivityListCount");
    }
}
