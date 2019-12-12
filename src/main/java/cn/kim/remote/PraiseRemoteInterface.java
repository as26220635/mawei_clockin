package cn.kim.remote;

/**
 * Created by 余庚鑫 on 2019/12/12
 * 点赞
 */
public interface PraiseRemoteInterface {

    /**
     * 记录点赞
     *
     * @param fromId
     * @param toId
     * @param action
     * @param date
     */
    void praise(String fromId, String toId, int action, String date);
}
