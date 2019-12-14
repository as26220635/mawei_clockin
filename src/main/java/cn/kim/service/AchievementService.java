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
    List<Map<String, Object>> selectMAchievementList(String BW_ID);

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
     * 查看打卡详细记录（前端使用）
     *
     * @param ID
     * @return
     */
    Map<String, Object> selectMAchievementDetailById(String ID);

    /**
     * 查询列表
     *
     * @param BW_ID
     * @return
     */
    DataTablesView<?> selectMAchievementDetailList(int offset, int limit, String BW_ID);

    /**
     * 查询打卡信息列表数量
     *
     * @param BW_ID
     * @return
     */
    Integer selectAchievementDetailListCountByWechatId(String BW_ID);

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

    /**
     * 获取成就墙树数据
     *
     * @param mapParam
     * @return
     */
    List<Tree> selectAchievementTree(Map<String, Object> mapParam);

    /**
     * 更新主页图片关联成就墙
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> updateAchievementMainImage(Map<String, Object> mapParam);

    /**
     * 成就墙打卡人数
     * @return
     */
    List<Map<String,Object>> selectAchievementClockinStatistic();

    /**
     * 查询成就墙分享
     *
     * @param mapParam
     * @return
     */
    List<Map<String, Object>> selectAchievementShare(Map<String, Object> mapParam);

    /**
     * 变更成就墙分享区域
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeAchievementShare(Map<String, Object> mapParam);
}
