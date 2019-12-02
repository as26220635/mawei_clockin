package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.exception.CustomException;
import cn.kim.service.MainImageService;
import cn.kim.util.FileUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/8/6
 * 主页图片管理
 */
@Service
public class MainImageServiceImpl extends BaseServiceImpl implements MainImageService {

    @Override
    public Map<String, Object> selectMainImage(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", mapParam.get("ID"));
        return baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImage", paramMap);
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateMainImage(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_MAIN_IMAGE);

            paramMap.put("ID", id);
            paramMap.put("BMI_NAME", mapParam.get("BMI_NAME"));
            paramMap.put("BMI_REMARKS", mapParam.get("BMI_REMARKS"));
            paramMap.put("BMI_UPDATETIME", getDate());
            paramMap.put("SO_ID", getActiveUser().getId());

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BMI_ENTRYTIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("IS_STATUS", STATUS_ERROR);

                baseDao.insert(NameSpace.MainImageMapper, "insertMainImage", paramMap);
                resultMap.put(MagicValue.LOG, "添加主页图片:" + formatColumnName(TableName.BUS_MAIN_IMAGE, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectMainImage(oldMap);

                baseDao.update(NameSpace.MainImageMapper, "updateMainImage", paramMap);
                resultMap.put(MagicValue.LOG, "更新主页图片,更新前:" + formatColumnName(TableName.BUS_MAIN_IMAGE, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_MAIN_IMAGE, paramMap));
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
    public Map<String, Object> changeMainImageStatus(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
            //作废其他启用记录
            int IS_STATUS = toInt(mapParam.get("IS_STATUS"));
            if (IS_STATUS == STATUS_SUCCESS) {
                paramMap.clear();
                paramMap.put("IS_STATUS", IS_STATUS);
                List<Map<String, Object>> list = baseDao.selectList(NameSpace.MainImageMapper, "selectMainImage", paramMap);
                for (Map<String, Object> main : list) {
                    //作废
                    paramMap.clear();
                    paramMap.put("ID", main.get("ID"));
                    paramMap.put("IS_STATUS", STATUS_ERROR);
                    baseDao.update(NameSpace.MainImageMapper, "updateMainImage", paramMap);
                }
            }
            //启用当前记录
            String id = toString(mapParam.get("ID"));

            paramMap.clear();
            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", IS_STATUS);

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectMainImage(oldMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_MAIN_IMAGE);
            baseDao.update(NameSpace.MainImageMapper, "updateMainImage", paramMap);
            resultMap.put(MagicValue.LOG, "更新主页图片状态,名称:" + toString(oldMap.get("BA_NAME")) + ",状态更新为:" + ParamTypeResolve.statusExplain(mapParam.get("IS_STATUS")));

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
    public Map<String, Object> deleteMainImage(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = DELETE_ERROR;
        try {
            if (isEmpty(mapParam.get("ID"))) {
                throw new CustomException(Tips.ID_NULL_ERROR);
            }
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
            String id = toString(mapParam.get("ID"));

            //删除主页图片表
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> oldMap = selectMainImage(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_MAIN_IMAGE);
            baseDao.delete(NameSpace.MainImageMapper, "deleteMainImage", paramMap);

            resultMap.put(MagicValue.LOG, "删除主页图片,信息:" + formatColumnName(TableName.BUS_MAIN_IMAGE, oldMap));
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
