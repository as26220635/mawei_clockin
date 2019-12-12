package cn.kim.remote;

import org.redisson.api.RFuture;
import org.redisson.api.annotation.RRemoteAsync;

/**
 * Created by 余庚鑫 on 2019/12/12
 * 点赞异步接口
 */
@RRemoteAsync(PraiseRemoteInterface.class)
public interface PraiseRemoteInterfaceAsync {

    /**
     * 记录点赞
     *
     * @param fromId
     * @param toId
     * @param action
     * @param date
     */
    RFuture<Void> praise(String fromId, String toId, int action, String date);
}
