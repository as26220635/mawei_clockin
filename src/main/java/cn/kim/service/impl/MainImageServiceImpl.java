package cn.kim.service.impl;

import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.ParamTypeResolve;
import cn.kim.common.attr.TableName;
import cn.kim.common.attr.Tips;
import cn.kim.common.eu.NameSpace;
import cn.kim.exception.CustomException;
import cn.kim.service.MainImageService;
import cn.kim.util.FileUtil;
import cn.kim.util.TextUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
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
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("IS_STATUS", mapParam.get("IS_STATUS"));
        paramMap.put("BMI_PARENTID", mapParam.get("BMI_PARENTID"));

        Map<String, Object> mainImage = baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImage", paramMap);
        //文件路径加密
        FileUtil.filePathTobase64(mainImage, "IMG_PATH");
        return mainImage;
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
            paramMap.put("BMI_PARENTID", mapParam.get("BMI_PARENTID"));
            paramMap.put("BMI_NAME", mapParam.get("BMI_NAME"));
            paramMap.put("BMI_HEIGHT", mapParam.get("BMI_HEIGHT"));
            paramMap.put("BMI_TOP", mapParam.get("BMI_TOP"));
            paramMap.put("BMI_AREAHEIGHT", mapParam.get("BMI_AREAHEIGHT"));
            paramMap.put("BMI_AREAWIDTH", mapParam.get("BMI_AREAWIDTH"));
            paramMap.put("BMI_REMARKS", mapParam.get("BMI_REMARKS"));
            paramMap.put("BMI_UPDATETIME", getDate());
            paramMap.put("SO_ID", getActiveUser().getId());

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BMI_ENTRYTIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("IS_STATUS", isEmpty(mapParam.get("IS_STATUS")) ? STATUS_ERROR : mapParam.get("IS_STATUS"));

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
            String id = toString(mapParam.get("ID"));
            //作废其他启用记录
            int IS_STATUS = toInt(mapParam.get("IS_STATUS"));
            paramMap.clear();
            paramMap.put("IS_STATUS", STATUS_SUCCESS);
            paramMap.put("BMI_PARENTID", 0);
            List<Map<String, Object>> list = baseDao.selectList(NameSpace.MainImageMapper, "selectMainImage", paramMap);

            Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
            oldMap.put("ID", id);
            oldMap = selectMainImage(oldMap);

            if (IS_STATUS == STATUS_SUCCESS && "0".equals(toString(oldMap.get("BMI_PARENTID")))) {
                for (Map<String, Object> main : list) {
                    //作废
                    paramMap.clear();
                    paramMap.put("ID", main.get("ID"));
                    paramMap.put("IS_STATUS", STATUS_ERROR);
                    baseDao.update(NameSpace.MainImageMapper, "updateMainImage", paramMap);
                }
            }
            //启用当前记录
            paramMap.clear();
            paramMap.put("ID", id);
            paramMap.put("IS_STATUS", IS_STATUS);

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

    @Override
    public Map<String, Object> selectMainImageArea(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(2);
        paramMap.put("ID", mapParam.get("ID"));
        paramMap.put("BMI_RELATIONID", mapParam.get("BMI_RELATIONID"));
        return baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImageArea", paramMap);
    }

    @Override
    public List<Map<String, Object>> selectMainImageAreaList(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BMI_ID", mapParam.get("BMI_ID"));
        List<Map<String, Object>> list = baseDao.selectList(NameSpace.MainImageMapper, "selectMainImageArea", paramMap);

        //文件路径加密
        FileUtil.filePathTobase64(list, "IMG_PATH");
        return list;
    }

    @Override
    @Transactional
    public Map<String, Object> insertAndUpdateMainImageArea(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            String id = toString(mapParam.get("ID"));
            String insertId = toString(mapParam.get("insertId"));
            if (isEmpty(insertId)) {
                insertId = getId();
            }
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_MAIN_IMAGE_AREA);

            paramMap.put("ID", id);
            paramMap.put("BMI_ID", mapParam.get("BMI_ID"));
            paramMap.put("BMI_RELATIONID", mapParam.get("BMI_RELATIONID"));
            paramMap.put("BIMA_INDEX", mapParam.get("BIMA_INDEX"));
            paramMap.put("BIMA_TITLE", mapParam.get("BIMA_TITLE"));
            paramMap.put("BIMA_MAPINFO", mapParam.get("BIMA_MAPINFO"));
            paramMap.put("BIMA_UPDATETIME", getDate());
            paramMap.put("SO_ID", getActiveUser().getId());

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BIMA_ENTRYTIME", getDate());
                paramMap.put("SO_ID", getActiveUser().getId());
                paramMap.put("IS_STATUS", STATUS_SUCCESS);

                baseDao.insert(NameSpace.MainImageMapper, "insertMainImageArea", paramMap);
                resultMap.put(MagicValue.LOG, "添加主页图片区域:" + formatColumnName(TableName.BUS_MAIN_IMAGE_AREA, paramMap));
            } else {
                Map<String, Object> oldMap = Maps.newHashMapWithExpectedSize(1);
                oldMap.put("ID", id);
                oldMap = selectMainImage(oldMap);

                baseDao.update(NameSpace.MainImageMapper, "updateMainImageArea", paramMap);
                resultMap.put(MagicValue.LOG, "更新主页图片区域,更新前:" + formatColumnName(TableName.BUS_MAIN_IMAGE_AREA, oldMap) + ",更新后:" + formatColumnName(TableName.BUS_MAIN_IMAGE_AREA, paramMap));
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
    public Map<String, Object> deleteMainImageArea(Map<String, Object> mapParam) {
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
            Map<String, Object> oldMap = selectMainImageArea(paramMap);
            //记录日志
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_MAIN_IMAGE_AREA);
            baseDao.delete(NameSpace.MainImageMapper, "deleteMainImageArea", paramMap);

            resultMap.put(MagicValue.LOG, "删除主页图片区域,信息:" + formatColumnName(TableName.BUS_MAIN_IMAGE_AREA, oldMap));
            status = STATUS_SUCCESS;
            desc = DELETE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 插入或更新主页图片区域
     *
     * @param mapParam
     * @return
     */
    @Override
    @Transactional
    public Map<String, Object> changeMainImageArea(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(10);
            //主图片ID
            String BMI_ID = toString(mapParam.get("BMI_ID"));
            paramMap.put("ID", BMI_ID);
            Map<String, Object> mainImage = selectMainImage(paramMap);

            //更新图片计算宽高
            String BMI_AREAHEIGHT = toString(mapParam.get("BMI_AREAHEIGHT"));
            String BMI_AREAWIDTH = toString(mapParam.get("BMI_AREAWIDTH"));
            paramMap.clear();
            paramMap.put("ID", BMI_ID);
            paramMap.put("BMI_AREAHEIGHT", BMI_AREAHEIGHT);
            paramMap.put("BMI_AREAWIDTH", BMI_AREAWIDTH);
            if (!isSuccess(insertAndUpdateMainImage(paramMap))) {
                throw new CustomException("保存出错");
            }

            String PARENT_NAME = toString(mainImage.get("BMI_NAME"));
            //前台的区域信息
            JSONArray updateAreaList = JSONArray.parseArray(unescapeHtml4(toString(mapParam.get("updateAreaList"))));
            if (updateAreaList == null) {
                updateAreaList = new JSONArray();
            }
            idDecrypt(updateAreaList);
            //查询原本区域
            paramMap.clear();
            paramMap.put("BMI_ID", BMI_ID);
            List<Map<String, Object>> oldArealist = selectMainImageAreaList(paramMap);

            //查出那些需要删除更新和添加
            List<Map<String, Object>> insertList = Lists.newArrayList();
            List<Map<String, Object>> upadateList = Lists.newArrayList();
            List<Map<String, Object>> deleteList = Lists.newArrayList();
            //需要添加的区域
            for (int i = 0; i < updateAreaList.size(); i++) {
                JSONObject object = updateAreaList.getJSONObject(i);
                if ("1".equals(toString(object.get("IS_INSERT")))) {
                    insertList.add(object);
                }
            }
            //需要更新和删除的区域
            for (Map<String, Object> m : oldArealist) {
                JSONObject object = null;
                boolean isExist = false;
                String OLD_ID = toString(m.get("ID"));
                for (int i = 0; i < updateAreaList.size(); i++) {
                    object = updateAreaList.getJSONObject(i);
                    String NEW_ID = toString(object.get("ID"));
                    if (OLD_ID.equals(NEW_ID)) {
                        isExist = true;
                        break;
                    }
                }
                if (!isExist) {
                    deleteList.add(m);
                } else {
                    for (Map.Entry<String, Object> entry : object.entrySet()) {
                        m.put(entry.getKey(), entry.getValue());
                    }
                    upadateList.add(m);
                }
            }
            //添加添加主页图标表和区域表
            for (Map<String, Object> insertMap : insertList) {
                Map<String, Object> mainMap = Maps.newHashMapWithExpectedSize(7);

                mainMap.put("insertId", insertMap.get("BMI_RELATIONID"));
                mainMap.put("BMI_PARENTID", BMI_ID);
                mainMap.put("BMI_NAME", PARENT_NAME + "_" + insertMap.get("BIMA_TITLE"));
                mainMap.put("BMI_HEIGHT", mainImage.get("BMI_HEIGHT"));
                mainMap.put("BMI_TOP", mainImage.get("BMI_TOP"));
                mainMap.put("BMI_AREAHEIGHT", BMI_AREAHEIGHT);
                mainMap.put("BMI_AREAWIDTH", BMI_AREAWIDTH);
                mainMap.put("IS_STATUS", STATUS_SUCCESS);
                Map<String, Object> insertResultMap = insertAndUpdateMainImage(mainMap);
                if (!isSuccess(insertResultMap)) {
                    throw new CustomException("保存出错");
                }
                String ID = toString(insertResultMap.get("ID"));

                insertMap.remove("BMI_RELATIONID");
                insertMap.put("BMI_ID", BMI_ID);
                insertMap.put("BMI_RELATIONID", ID);
                insertResultMap = insertAndUpdateMainImageArea(insertMap);
                if (!isSuccess(insertResultMap)) {
                    throw new CustomException("保存出错");
                }
            }
            //更新
            for (Map<String, Object> updateMap : upadateList) {
                Map<String, Object> updateResultMap = insertAndUpdateMainImageArea(updateMap);
                if (!isSuccess(updateResultMap)) {
                    throw new CustomException("保存出错");
                }
            }
            //删除
            for (Map<String, Object> deleteMap : deleteList) {
                deleteRecursionMainImage(toString(deleteMap.get("BMI_RELATIONID")));
            }

            resultMap.put(MagicValue.LOG, "更新主页图片区域管理,更新前:" + TextUtil.toJSONString(oldArealist) + ",更新后:" + updateAreaList.toJSONString());

            status = STATUS_SUCCESS;
            desc = SAVE_SUCCESS;
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }
        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }

    /**
     * 递归删除主页图片和区域关联
     *
     * @param ID
     * @param parentId
     */
    public void deleteRecursionMainImage(String ID) throws CustomException {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("ID", ID);
        Map<String, Object> image = selectMainImage(paramMap);

        if (!isEmpty(image)) {
            paramMap.clear();
            paramMap.put("BMI_PARENTID", ID);
            List<Map<String, Object>> imageList = baseDao.selectList(NameSpace.MainImageMapper, "selectMainImage", paramMap);
            if (!isEmpty(imageList)) {
                for (Map<String, Object> childrenImage : imageList) {
                    deleteRecursionMainImage(toString(childrenImage.get("ID")));
                }
            }
            //删除
            paramMap.clear();
            paramMap.put("BMI_RELATIONID", ID);
            Map<String, Object> area = selectMainImageArea(paramMap);

            paramMap.clear();
            paramMap.put("ID", area.get("ID"));
            if (!isSuccess(deleteMainImageArea(paramMap))) {
                throw new CustomException("保存出错");
            }
            paramMap.clear();
            paramMap.put("ID", ID);
            if (!isSuccess(deleteMainImage(paramMap))) {
                throw new CustomException("保存出错");
            }
        }
    }

}
