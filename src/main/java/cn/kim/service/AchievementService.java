package cn.kim.service;

import cn.kim.entity.DataTablesView;
import cn.kim.entity.Tree;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙管理
 */
public interface AchievementService extends BaseService {

    /**
     * 查询成就墙
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectAchievement(Map<String, Object> mapParam);

    /**
     * 查询成就墙列表
     *
     * @return
     */
    List<Map<String, Object>> selectMAchievementList();

    /**
     * 查询成就墙列表 带用户
     *
     * @param ID
     * @return
     */
    List<Map<String, Object>> selectMAchievementListByWechat(String ID);

    /**
     * 插入或更新成就墙
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateAchievement(Map<String, Object> mapParam);

    /**
     * 变更状态
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeAchievementStatus(Map<String, Object> mapParam);

    /**
     * 删除成就墙
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteAchievement(Map<String, Object> mapParam);

    /**
     * 查询打卡信息
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectAchievementDetail(Map<String, Object> mapParam);

    /**
     * 插入或更新打卡信息
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateAchievementDetail(Map<String, Object> mapParam);

    /**
     * 删除打卡信息
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteAchievementDetail(Map<String, Object> mapParam);

}
