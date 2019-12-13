package cn.kim.service;

import cn.kim.entity.DataTablesView;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/12
 * 活动管理
 */
public interface ActivityService extends BaseService {

    /**
     * 查询活动
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectActivity(Map<String, Object> mapParam);

    /**
     * 查询活动
     *
     * @param ID
     * @return
     */
    Map<String, Object> selectActivityById(String ID);

    /**
     * 插入或更新活动
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateActivity(Map<String, Object> mapParam);

    /**
     * 变更状态
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeActivityStatus(Map<String, Object> mapParam);

    /**
     * 删除活动
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteActivity(Map<String, Object> mapParam);

    /**
     * 查询列表
     *
     * @return
     */
    DataTablesView<?> selectMActivityList(int offset, int limit);

    /**
     * 查询打卡信息列表数量
     *
     * @return
     */
    Integer selectActivityListCount();
}
