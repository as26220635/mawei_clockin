package cn.kim.service;

import cn.kim.entity.DataTablesView;
import cn.kim.entity.Tree;
import com.alibaba.fastjson.JSONArray;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.store.LockObtainFailedException;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/12/4
 * 成就墙搜索管理
 */
public interface AchievementSearchService extends BaseService {

    /**
     * 初始化加载
     *
     * @throws Exception
     */
    void init() throws Exception;

    /**
     * 搜索
     *
     * @param queryWord
     * @return
     * @throws Exception
     */
    JSONArray search(String queryWord) throws Exception;
}
