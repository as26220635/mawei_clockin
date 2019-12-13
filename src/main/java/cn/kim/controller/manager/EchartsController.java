package cn.kim.controller.manager;

import cn.kim.common.annotation.NotEmptyLogin;
import cn.kim.common.attr.TableViewName;
import cn.kim.exception.CustomException;
import cn.kim.service.AchievementService;
import cn.kim.service.WechatService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Created by 余庚鑫 on 2019/12/13
 * 图形报表
 */
@Controller
@RequestMapping("/admin/Echarts")
public class EchartsController extends BaseController {
    /**
     * 柱形
     */
    private static final String ECHARTS_BAR = "bar";
    /**
     * 饼图
     */
    private static final String ECHARTS_PIE = "pie";
    /**
     * 雷达
     */
    private static final String ECHARTS_RADAR = "radar";


    @Autowired
    private WechatService wechatService;

    @Autowired
    private AchievementService achievementService;

    /**
     * 柱形图
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/bar")
    @NotEmptyLogin
    public String bar(@RequestParam Map<String, Object> mapParam, Model model) throws Exception {
        String v = toString(mapParam.get("v"));
        if (isEmpty(v)) {
            throw new CustomException("参数错误");
        }
        String title = "统计数据";
        String subtext = getDate();
        //动作
        String action = toString(mapParam.get("action"));

        //获得数据
        if (TableViewName.V_WECHAT.equals(v)) {
            //微信用户
            List<Map<String, Object>> baseList = null;
            if ("register".equals(action)) {
                //注册
                baseList = wechatService.selectWechatRegisterStatistic();
            } else {
                //登录
                baseList = wechatService.selectWechatLoginStatistic();
            }

            Map<String, Integer> dataMap = Maps.newHashMapWithExpectedSize(16);

            int totalCount = 0;
            //分割xAxis
            List<String> xAxisList = Lists.newLinkedList();
            for (Map<String, Object> base : baseList) {
                String ENTRY_TIME = toString(base.get("ENTRY_TIME"));
                int ENTRY_COUNT = toInt(base.get("ENTRY_COUNT"));

                xAxisList.add(ENTRY_TIME);
                dataMap.put(ENTRY_TIME, ENTRY_COUNT);
                totalCount += ENTRY_COUNT;
            }
            int[] dataArray = new int[xAxisList.size()];
            for (int i = 0; i < xAxisList.size(); i++) {
                dataArray[i] = dataMap.get(xAxisList.get(i));
            }

            model.addAttribute("xAxisArray", joinArray(xAxisList.stream()));
            model.addAttribute("dataArray", joinValueArray(Arrays.stream(dataArray).boxed()));

            if ("register".equals(action)) {
                title = "微信用户注册统计";
                title = title + "   总注册数:" + totalCount;
                model.addAttribute("seriesName", "注册数");
            } else {
                title = "微信用户登录统计";
                model.addAttribute("seriesName", "登录数");
            }
        }

        model.addAttribute("v", v);
        model.addAttribute("title", title);
        model.addAttribute("subtext", subtext);
        model.addAttribute("chartId", UUID.randomUUID().toString());
        return "admin/system/echarts/bar";
    }

    /**
     * 饼图
     *
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("/pie")
    @NotEmptyLogin
    public String pie(@RequestParam Map<String, Object> mapParam, Model model) throws Exception {
        String v = toString(mapParam.get("v"));
        if (isEmpty(v)) {
            throw new CustomException("参数错误");
        }
        String title = "统计数据";
        String subtext = getDate();
        //动作
        String action = toString(mapParam.get("action"));

        //获得数据
        if (TableViewName.V_ACHIEVEMENT.equals(v)) {
            //成就墙
            List<Map<String, Object>> baseList = achievementService.selectAchievementClockinStatistic();

            Map<String, Integer> dataMap = Maps.newHashMapWithExpectedSize(16);

            int totalCount = 0;
            //分割xAxis
            List<String> xAxisList = Lists.newLinkedList();
            for (Map<String, Object> base : baseList) {
                String BA_NAME = toString(base.get("BA_NAME"));
                int CLOCKIN_COUNT = toInt(base.get("CLOCKIN_COUNT"));

                xAxisList.add(BA_NAME);
                dataMap.put(BA_NAME, CLOCKIN_COUNT);
                totalCount += CLOCKIN_COUNT;
            }
            int[] dataArray = new int[xAxisList.size()];
            for (int i = 0; i < xAxisList.size(); i++) {
                dataArray[i] = dataMap.get(xAxisList.get(i));
            }

            model.addAttribute("xAxisArray", xAxisList.stream().map(i -> "'" + i.toString() + "'").collect(Collectors.joining(",")));
            model.addAttribute("dataArray", toPieArray(xAxisList.stream().map(i -> toString(i)).toArray(String[]::new), dataArray));

            title = "成就墙打卡人数统计";
            title = title + "\\n总打卡次数:" + totalCount;
            model.addAttribute("seriesName", "打卡人数");
        }

        model.addAttribute("v", v);
        model.addAttribute("title", title);
        model.addAttribute("subtext", subtext);
        model.addAttribute("chartId", UUID.randomUUID().toString());
        return "admin/system/echarts/pie";
    }

    /**
     * list转为bar可以使用的参数
     *
     * @param list            数据
     * @param xAxisField      X轴字段
     * @param legendField     组字段
     * @param valueFields     参数字段
     * @param valueNameFields 参数名称字段
     * @return
     */
    public Map<String, Object> toBarGroupData(List<Map<String, Object>> list, String xAxisField, String legendField, String[] valueFields, String[] valueNameFields) {
        Map<String, Object> resultMap = new HashMap<>();
        if (list == null || list.size() == 0) {
            return resultMap;
        }
        //X轴参数
        List<String> xAxisList = xAxisListSort(list, xAxisField);
        //统计组参数
        Set<String> legendSet = new LinkedHashSet<>();
        Map<String, Double> valueMap = new HashMap<>();
        list.forEach(map -> {
            for (int i = 0; i < valueFields.length; i++) {
                String valueField = valueFields[i];
                String valueNameField = valueNameFields[i];
                String legend = toString(map.get(legendField)) + valueNameField;
                Double val = toBigDecimal(map.get(valueField)).doubleValue();
                valueMap.put(toString(map.get(xAxisField)) + legend, val == null ? 0d : val);
                legendSet.add(legend);
            }
        });
        //补充每个组缺少的参数
        legendSet.forEach(legend -> {
            xAxisList.forEach(xAxis -> {
                for (String valueNameField : valueNameFields) {
                    if (valueMap.get(xAxis + legend + valueNameField) == null) {
                        valueMap.put(xAxis + legend + valueNameField, 0d);
                    }
                }
            });
        });
        //转为参数集合
        List<Map<String, Object>> seriesList = new LinkedList<>();
        legendSet.forEach(legend -> {
            Map<String, Object> series = new HashMap<>();
            //组名
            series.put("name", legend);
            //参数
            series.put("data", doubleArrayToValue(xAxisList, valueMap, legend));

            seriesList.add(series);
        });

        resultMap.put("legendArray", joinArray(legendSet.stream()));
        resultMap.put("xAxisArray", joinArray(xAxisList.stream()));
        resultMap.put("seriesList", seriesList);

        return resultMap;
    }

    /**
     * list转为bar可以使用的参数
     *
     * @param list         数据
     * @param xAxisField   X轴字段
     * @param valueFields  参数字段
     * @param legendFields 转换参数名称字段
     * @return
     */
    public Map<String, Object> toBarGroupSplitData(List<Map<String, Object>> list, String xAxisField, String[] valueFields, String[] legendFields) {
        Map<String, Object> resultMap = new HashMap<>();
        //X轴参数
        List<String> xAxisList = xAxisListSort(list, xAxisField);
        //统计组参数
        Map<String, Double> valueMap = new HashMap<>();
        list.forEach(map -> {
            for (String valueField : valueFields) {
                Double val = toBigDecimal(map.get(valueField)).doubleValue();
                valueMap.put(toString(map.get(xAxisField)) + valueField, val == null ? 0d : val);
            }
        });
        //补充每个组缺少的参数
        for (String valueField : valueFields) {
            xAxisList.forEach(xAxis -> {
                if (valueMap.get(xAxis + valueField) == null) {
                    valueMap.put(xAxis + valueField, 0d);
                }
            });
        }
        //转为参数集合
        List<Map<String, Object>> seriesList = new LinkedList<>();
        for (int i = 0; i < valueFields.length; i++) {
            String valueField = valueFields[i];
            Map<String, Object> series = new HashMap<>();
            //组名
            series.put("name", legendFields[i]);
            //参数
            series.put("data", doubleArrayToValue(xAxisList, valueMap, valueField));

            seriesList.add(series);
        }

        resultMap.put("legendArray", joinArray(Arrays.stream(legendFields)));
        resultMap.put("xAxisArray", joinArray(xAxisList.stream()));
        resultMap.put("seriesList", seriesList);

        return resultMap;
    }

    /**
     * 转为饼图数据
     *
     * @param name
     * @param value
     * @return
     */
    public String toPieArray(String[] name, int[] value) {
        if (name.length != value.length) {
            return "";
        }
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < name.length; i++) {
            builder.append("{");
            builder.append("value:" + value[i] + ',');
            builder.append("name:'" + name[i] + "'");
            builder.append("},");
        }
        return builder.toString();
    }

    /**
     * 排序
     *
     * @param list
     * @param xAxisField
     * @return
     */
    public List<String> xAxisListSort(List<Map<String, Object>> list, String xAxisField) {
        Set<String> xAxisSet = new HashSet<>();
        List<String> xAxisList = new LinkedList<>();
        list.forEach(map -> {
            xAxisSet.add(toString(map.get(xAxisField)));
        });
        xAxisSet.forEach(s -> {
            xAxisList.add(s);
        });
        //排序坐标
        Collections.sort(xAxisList);
        return xAxisList;
    }

    public String joinArray(Stream<?> steam) {
        return joinArray(steam, ",");
    }

    public String joinArray(Stream<?> steam, String delimiter) {
        return steam.map(i -> "'" + i + "'").collect(Collectors.joining(delimiter));
    }

    public String joinValueArray(Stream<?> steam) {
        return steam.map(i -> toString(i)).collect(Collectors.joining(","));
    }

    public String doubleArrayToValue(List<?> xAxisList, Map<String, Double> valueMap, String valueField) {
        Double[] valueArray = xAxisList.stream().map(xAxis -> valueMap.get(xAxis + valueField)).toArray(Double[]::new);
        return joinValueArray(Arrays.stream(valueArray));
    }
}
