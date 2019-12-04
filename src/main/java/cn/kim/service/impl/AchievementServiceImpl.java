package cn.kim.service.impl;

import cn.kim.common.attr.*;
import cn.kim.common.eu.NameSpace;
import cn.kim.common.eu.SystemEnum;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.QuerySet;
import cn.kim.entity.Tree;
import cn.kim.entity.TreeState;
import cn.kim.exception.CustomException;
import cn.kim.service.AchievementSearchService;
import cn.kim.service.AchievementService;
import cn.kim.service.AchievementService;
import cn.kim.util.*;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.awt.*;
import java.util.*;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by 余庚鑫 on 2019/12/1
 * 成就墙管理
 */
@Service
public class AchievementServiceImpl extends BaseServiceImpl implements AchievementService {

    @Autowired
    private AchievementSearchService achievementSearchService;

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
            paramMap.put("BA_POINT", mapParam.get("BA_POINT"));

            if (isEmpty(id)) {
                id = insertId;
                paramMap.put("ID", id);
                paramMap.put("BA_ENTRYTIME", getDate());
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


            //刷新前端搜索缓存
            achievementSearchService.init();

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


            //刷新前端搜索缓存
            achievementSearchService.init();

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


            //刷新前端搜索缓存
            achievementSearchService.init();

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
            paramMap.put(MagicValue.SVR_TABLE_NAME, TableName.BUS_ACHIEVEMENT_DETAIL);

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

    @Override
    public List<Tree> selectAchievementTree(Map<String, Object> mapParam) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        String BMI_ID = toString(mapParam.get("BMI_ID"));

        paramMap.put("BMI_ID", BMI_ID);
        String parentId = baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImageTopIdByChildrenId", paramMap);

        //查询所有子类已经选择过的成就墙
        List<String> childrenList = Lists.newArrayList();
        childrenList.add(parentId);
        getAchievementChildrenId(childrenList, parentId, BMI_ID);

        paramMap.clear();
        paramMap.put("BMI_ID_LIST", TextUtil.toString(childrenList, true));
        List<Map<String, Object>> existAchievementList = baseDao.selectList(NameSpace.AchievementMapper, "selectMainImageAchievement", paramMap);
        Map<String, String> existMap = Maps.newHashMap();
        for (Map<String, Object> exist : existAchievementList) {
            existMap.put(toString(exist.get("BA_ID")), toString(exist.get("BMI_ID")));
        }

        //查询已经选择的
        paramMap.clear();
        paramMap.put("BMI_ID", BMI_ID);
        List<Map<String, Object>> selectAchievementList = baseDao.selectList(NameSpace.AchievementMapper, "selectMainImageAchievement", paramMap);
        Set<String> selectSet = selectAchievementList.stream().map(m -> toString(m.get("BA_ID"))).collect(Collectors.toSet());

        //查询所有成就墙
        paramMap.clear();
        paramMap.put("IS_STATUS", STATUS_SUCCESS);
        List<Map<String, Object>> achievementList = baseDao.selectList(NameSpace.AchievementMapper, "selectAchievement", paramMap);

        List<Tree> achievementTree = Lists.newArrayList();
        if (!isEmpty(achievementList)) {
            achievementList.forEach(achievement -> {
                String id = toString(achievement.get("ID"));

                Tree tree = new Tree();
                tree.setId(id);
                tree.setText(toString(achievement.get("BA_NAME")));

                TreeState state = new TreeState();
                //是否选中
                if (!isEmpty(selectSet) && selectSet.contains(id)) {
                    state.setChecked(true);
                    //选中的设置打开
                    state.setExpanded(true);
                }
                //是否已被其他选择
                if (!isEmpty(existMap) && existMap.containsKey(id)) {
                    paramMap.clear();
                    paramMap.put("ID", existMap.get(id));
                    Map<String, Object> mainImage = baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImage", paramMap);

                    if (!isEmpty(mainImage)) {
                        tree.setTags(new String[]{
                                "已被主页图片" + toHtmlBColor(mainImage.get("BMI_NAME")) + "选中"
                        });
                    }
                    state.setDisabled(true);
                }

                //设置状态
                tree.setState(state);

                achievementTree.add(tree);
            });
        }

        return achievementTree;
    }

    /**
     * 递归获得所有子类ID
     *
     * @param childrenList
     * @param parentId
     * @return
     */
    public List<String> getAchievementChildrenId(List<String> childrenList, String parentId, String excludeId) {
        Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(1);
        paramMap.put("BMI_PARENTID", parentId);
        List<Map<String, Object>> list = baseDao.selectList(NameSpace.MainImageMapper, "selectMainImage", paramMap);
        if (!isEmpty(list)) {
            for (Map<String, Object> mainImage : list) {
                String ID = toString(mainImage.get("ID"));
                getAchievementChildrenId(childrenList, ID, excludeId);
                if (!ID.equals(excludeId)) {
                    childrenList.add(ID);
                }
            }
        }
        return childrenList;
    }

    /**
     * 更新主页图片关联成就墙
     *
     * @param mapParam
     * @return
     */
    @Override
    public Map<String, Object> updateAchievementMainImage(Map<String, Object> mapParam) {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(5);
        int status = STATUS_ERROR;
        String desc = SAVE_ERROR;
        try {
            Map<String, Object> paramMap = Maps.newHashMapWithExpectedSize(3);
            String id = toString(mapParam.get("ID"));
            //选中的按钮ID
            String[] achievementIds = toString(mapParam.get("achievementIds")).split(SERVICE_SPLIT);

            //查询主页图片
            paramMap.clear();
            paramMap.put("ID", id);
            Map<String, Object> mainImage = baseDao.selectOne(NameSpace.MainImageMapper, "selectMainImage", paramMap);
            //查询sys_menu_button表
            paramMap.clear();
            paramMap.put("BMI_ID", id);
            Map<String, String> oldAchievementIds = toMapKey(baseDao.selectList(NameSpace.AchievementMapper, "selectMainImageAchievement", paramMap), "BA_ID");
            //新菜单权限
            Map<String, String> newAchievementIds = Arrays.stream(achievementIds).collect(Collectors.toMap(String::toString, String::toString));

            //原来没有的就添加
            if (!isEmpty(newAchievementIds)) {
                for (String newAchievementId : newAchievementIds.keySet()) {
                    if (!isEmpty(newAchievementId)) {
                        if (isEmpty(oldAchievementIds) || !oldAchievementIds.containsKey(newAchievementId)) {
                            //添加
                            paramMap.clear();
                            paramMap.put("ID", getId());
                            paramMap.put("BMI_ID", id);
                            paramMap.put("BA_ID", newAchievementId);
                            baseDao.insert(NameSpace.AchievementMapper, "insertMainImageAchievement", paramMap);
                        }
                    }
                }
            }
            //新的菜单id 旧的还存在的就要删除
            if (!isEmpty(oldAchievementIds)) {
                for (String oldAchievementId : oldAchievementIds.keySet()) {
                    if (!isEmpty(oldAchievementId)) {
                        if (isEmpty(newAchievementIds) || !newAchievementIds.containsKey(oldAchievementId)) {
                            //删除
                            paramMap.clear();
                            paramMap.put("BMI_ID", id);
                            paramMap.put("BA_ID", oldAchievementId);
                            baseDao.delete(NameSpace.AchievementMapper, "deleteMainImageAchievement", paramMap);
                        }
                    }
                }
            }
            //清除缓存
            CacheUtil.clear(NameSpace.MainImageMapper.getValue());

            //刷新前端搜索缓存
            achievementSearchService.init();

            status = STATUS_SUCCESS;
            desc = UPDATE_SUCCESS;

            resultMap.put("ID", id);
            resultMap.put(MagicValue.LOG, "主页图片:" + mainImage.get("BMI_NAME") + ",旧成就墙:" + toString(toKeySet(oldAchievementIds)) + ",新成就墙:" + toString(toKeySet(newAchievementIds)));
        } catch (Exception e) {
            desc = catchException(e, baseDao, resultMap);
        }

        resultMap.put(MagicValue.STATUS, status);
        resultMap.put(MagicValue.DESC, desc);
        return resultMap;
    }


}
