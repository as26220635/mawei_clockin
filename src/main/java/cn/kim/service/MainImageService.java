package cn.kim.service;

import cn.kim.entity.DataTablesView;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 主页图片管理
 */
public interface MainImageService extends BaseService {

    /**
     * 查询主页图片
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectMainImage(Map<String, Object> mapParam);

    /**
     * 插入或更新主页图片
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateMainImage(Map<String, Object> mapParam);

    /**
     * 变更状态
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeMainImageStatus(Map<String, Object> mapParam);

    /**
     * 删除主页图片
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteMainImage(Map<String, Object> mapParam);

    /**
     * 查询主页图片区域
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> selectMainImageArea(Map<String, Object> mapParam);

    /**
     * 查询区域
     *
     * @param mapParam
     * @return
     */
    List<Map<String, Object>> selectMainImageAreaList(Map<String, Object> mapParam);


    /**
     * 插入或更新主页区域
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> insertAndUpdateMainImageArea(Map<String, Object> mapParam);

    /**
     * 删除主页图片区域
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> deleteMainImageArea(Map<String, Object> mapParam);

    /**
     * 改变主页图片区域
     *
     * @param mapParam
     * @return
     */
    Map<String, Object> changeMainImageArea(Map<String, Object> mapParam);

}
