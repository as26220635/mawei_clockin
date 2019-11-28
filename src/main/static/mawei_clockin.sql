/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : mawei_clockin

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 26/11/2019 16:24:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_account_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_account_info`;
CREATE TABLE `sys_account_info`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SAI_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号名称',
  `SAI_PHONE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `SAI_EMAIL` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `SAI_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型关联ID',
  `SAI_TYPE` int(5) NULL DEFAULT NULL COMMENT '用户类型$SYS_ROLE_TYPE$',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  INDEX `SAI_TABLE_ID`(`SAI_TABLE_ID`) USING BTREE,
  INDEX `SAI_TYPE`(`SAI_TYPE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_account_info
-- ----------------------------
INSERT INTO `sys_account_info` VALUES ('1', '1', 'admin', '', '', NULL, 1);

-- ----------------------------
-- Table structure for sys_allocation
-- ----------------------------
DROP TABLE IF EXISTS `sys_allocation`;
CREATE TABLE `sys_allocation`  (
  `ID` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SA_KEY` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SA_VALUE` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SA_MODIFY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `SA_KEY`(`SA_KEY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_allocation
-- ----------------------------
INSERT INTO `sys_allocation` VALUES ('21304048766418944', 'EMAIL_USER', '17012342032@163.com', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21304048955162624', 'EMAIL_PASSWORD', 'as851758629', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21304049068408832', 'EMAIL_HOST', 'smtp.163.com', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21311400131428352', 'EMAIL_STATUS', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21386471894155264', 'EMAIL_PORT', '465', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961086197760', 'EMAIL_PROTOCOL', 'smtp', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961480462336', 'EMAIL_AUTH', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('21399961660817408', 'EMAIL_SSL_ENABLE', '1', '2018-06-07 23:48:24');
INSERT INTO `sys_allocation` VALUES ('50328920767070208', 'EDUCATION_PROPORTION', '20', '2018-08-12 17:07:05');
INSERT INTO `sys_allocation` VALUES ('50328920993562624', 'INTELLECTUAL_PROPORTION', '70', '2018-08-12 17:07:05');
INSERT INTO `sys_allocation` VALUES ('50328921140363264', 'VOLUNTEER_PROPORTION', '10', '2018-08-12 17:07:06');
INSERT INTO `sys_allocation` VALUES ('50331495037927424', 'LATE_PROPORTION', '2', '2018-08-11 13:33:12');
INSERT INTO `sys_allocation` VALUES ('50331495419609088', 'ABSENTEEISM_PROPORTION', '40', '2018-08-11 13:33:13');

-- ----------------------------
-- Table structure for sys_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_button`;
CREATE TABLE `sys_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SB_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮名称',
  `SB_BUTTONID` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮ID',
  `SB_FUNC` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮操作方法',
  `SB_CLASS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮CLASS样式 $SYS_BUTTON_CLASS$',
  `SB_EXTEND_CLASS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮扩展CLASS样式',
  `SB_ICON` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮图标图片',
  `SB_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限编码',
  `SB_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `SB_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮类型 $SYS_BUTTON_TYPE$',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_button
-- ----------------------------
INSERT INTO `sys_button` VALUES ('1', '添加', 'addBtn', NULL, 'btn btn-info', NULL, 'mdi mdi-table-row-plus-before', 'INSERT', 1, '0');
INSERT INTO `sys_button` VALUES ('1007779779182592', '设置权限', 'setPermission', '', 'btn btn-warning', NULL, 'mdi mdi-power-plug', 'SET_PERMISSION', 7, '1');
INSERT INTO `sys_button` VALUES ('161254695686373376', '分配班级管理', 'distributionClass', '', 'btn btn-info', '', 'mdi mdi-select', 'DISTRIBUTION_CLASS', 13, '1');
INSERT INTO `sys_button` VALUES ('161261019585314816', '分配班级', 'distributionClass', 'distributionClass();', 'btn btn-info', '', 'mdi mdi-select', 'DISTRIBUTION_CLASS', 10, '0');
INSERT INTO `sys_button` VALUES ('161261473966850048', '删除', 'delete', 'del();', 'btn btn-danger', '', 'mdi mdi-table-column-remove', 'DELETE', 100, '0');
INSERT INTO `sys_button` VALUES ('161642569980182528', '辅导员查看', 'instructor', '', 'btn btn-info', '', 'mdi mdi-search-web', 'INSTRUCTOR', 14, '1');
INSERT INTO `sys_button` VALUES ('161939307504861184', '修改辅导员', 'updateInstructor', 'updateInstructor();', 'btn btn-danger', '', 'mdi mdi-stackexchange', 'U_INSTRUCTOR', 11, '0');
INSERT INTO `sys_button` VALUES ('162466157897449472', '室管理', 'room', '', 'btn btn-info', '', 'mdi mdi-mushroom', 'ROOM', 15, '1');
INSERT INTO `sys_button` VALUES ('162466344221016064', '铺位管理', 'berth', '', 'btn btn-info', '', 'mdi mdi-mushroom-outline', 'BERTH', 16, '1');
INSERT INTO `sys_button` VALUES ('162829158844465152', '日志查看', 'log', '', 'btn btn-info', '', 'mdi mdi-locker-multiple', 'LOG', 17, '1');
INSERT INTO `sys_button` VALUES ('1795360737460224', '返回', 'return', 'backHtml();', 'btn btn-warning', NULL, 'mdi mdi-keyboard-return', 'RETURN', 0, '0');
INSERT INTO `sys_button` VALUES ('20703880723562496', '组', 'group', '', 'btn btn-primary', NULL, 'mdi mdi-group', 'GROUP', 6, '0');
INSERT INTO `sys_button` VALUES ('2256636777332736', '设置字段', 'setField', '', 'btn btn-warning', NULL, 'mdi mdi-table-row', 'SET_FIELD', 8, '1');
INSERT INTO `sys_button` VALUES ('2261000862564352', '正则管理', 'regex', '', 'btn btn-danger', NULL, 'mdi mdi-table-column-plus-after', 'REGEX', 4, '0');
INSERT INTO `sys_button` VALUES ('2819607190568960', '刷新缓存', 'cache', '', 'btn btn-info', NULL, 'mdi mdi-cached', 'CACHE', 5, '0');
INSERT INTO `sys_button` VALUES ('2824289539588096', '列表', 'list', '', 'btn btn-info', NULL, 'mdi mdi-format-list-numbers', 'LIST', 9, '1');
INSERT INTO `sys_button` VALUES ('28283426524102656', '重置密码', 'resetPassword', '', 'btn btn-warning', NULL, 'mdi mdi-lock-reset', 'RESET_PWD', 98, '1');
INSERT INTO `sys_button` VALUES ('3008659554566144', '设置角色', 'setRole', '', 'btn btn-warning', NULL, 'mdi mdi-account-switch', 'SET_ROLE', 11, '1');
INSERT INTO `sys_button` VALUES ('33081849764904960', '作废', 'cancel', '', 'btn btn-danger', NULL, 'mdi mdi-cancel', 'CANCEL', 98, '1');
INSERT INTO `sys_button` VALUES ('33267466964566016', '作废信息', 'cancelInfo', '', 'btn btn-info', NULL, 'mdi mdi-information-outline', 'CANCEL_INFO', 98, '1');
INSERT INTO `sys_button` VALUES ('3375831514611712', '设置账号', 'setSub', '', 'btn btn-primary', NULL, 'mdi mdi-account-group', 'SET_SUB', 10, '1');
INSERT INTO `sys_button` VALUES ('48286237202579456', '导入', 'import', '', 'btn btn-success', 'btn-import', 'mdi mdi-import', 'IMPORT', 7, '0');
INSERT INTO `sys_button` VALUES ('48286450940116992', '导出', 'export', 'exportData();', 'btn btn-success', '', 'mdi mdi-export', 'EXPORT', 8, '0');
INSERT INTO `sys_button` VALUES ('48287050272604160', '账号信息', 'accountInfo', '', 'btn btn-info', NULL, 'mdi mdi-account-edit', 'ACCOUNT_INFO', 9, '1');
INSERT INTO `sys_button` VALUES ('49028916572061696', '撤销', 'revoke', '', 'btn btn-danger', NULL, 'mdi mdi-backburger', 'REVOKE', 97, '1');
INSERT INTO `sys_button` VALUES ('50800567487823872', '拷贝', 'copy', '', 'btn btn-danger', NULL, 'mdi mdi-content-copy', 'COPY', 9, '1');
INSERT INTO `sys_button` VALUES ('51562014773870592', '授权', 'authorization', '', 'btn btn-warning', NULL, 'mdi mdi-graphql', 'AUTHORIZATION', 96, '1');
INSERT INTO `sys_button` VALUES ('52931029941354496', '流程提交', 'processSubmit', '', 'btn btn-success', '', 'mdi mdi-comment-check-outline', 'PROCESS_SUBMIT', 99, '0');
INSERT INTO `sys_button` VALUES ('53380929225228288', '详细记录', 'detailLog', '', 'btn btn-info', '', 'mdi mdi-locker-multiple', 'DETAIL_LOG', 96, '1');
INSERT INTO `sys_button` VALUES ('58407294232166400', '设置文件', 'setFile', '', 'btn btn-info', '', 'mdi mdi-file', 'SET_FILE', 8, '1');
INSERT INTO `sys_button` VALUES ('59163248951296000', '回复', 'reply', '', 'btn btn-warning', '', 'mdi mdi-message-reply-text', 'REPLY', 12, '1');
INSERT INTO `sys_button` VALUES ('59175846681772032', '导入查询', 'importQuery', '', 'btn btn-info', 'btn-import', 'mdi mdi-file-excel-box', 'IMPORT_QUERY', 9, '0');
INSERT INTO `sys_button` VALUES ('61704939650416640', '设置岗位', 'setPost', '', 'btn btn-warning', '', 'mdi mdi-box-shadow', 'SET_POST', 95, '1');
INSERT INTO `sys_button` VALUES ('62088284481781760', '设置学生', 'setStudent', '', 'btn btn-warning', '', 'mdi mdi-account-group', 'SET_STUDENT', 94, '1');
INSERT INTO `sys_button` VALUES ('62462439475642368', '月工资', 'monthWages', '', 'btn btn-warning', '', 'mdi mdi-cash', 'MONTH_WAGES', 93, '1');
INSERT INTO `sys_button` VALUES ('763206804963328', '保存', 'save', 'save();', 'btn btn-primary', '', 'mdi mdi-content-save', 'SAVE', 2, '0');
INSERT INTO `sys_button` VALUES ('793562643955712', '编辑', 'edit', '', 'btn btn-success', NULL, 'mdi mdi-table-edit', 'UPDATE', 1, '1');
INSERT INTO `sys_button` VALUES ('793777245519872', '删除', 'del', '', 'btn btn-danger', NULL, 'mdi mdi-table-row-remove', 'DELETE', 99, '1');
INSERT INTO `sys_button` VALUES ('794877562454016', '设置按钮', 'setButton', 'setButton', 'btn btn-warning', NULL, 'mdi mdi-menu', 'SET_MENU', 3, '1');
INSERT INTO `sys_button` VALUES ('795677957292032', '设置列', 'setColumn', '', 'btn btn-warning', NULL, 'mdi mdi-table-row', 'SET_COLUMN', 4, '1');
INSERT INTO `sys_button` VALUES ('795961550962688', '设置搜索', 'setSearch', '', 'btn btn-info', NULL, 'mdi mdi-search-web', 'SET_SEARCH', 5, '1');
INSERT INTO `sys_button` VALUES ('797443633446912', '设置菜单', 'setMenu', '', 'btn btn-info', NULL, 'mdi mdi-menu', 'SET_MENU', 6, '1');

-- ----------------------------
-- Table structure for sys_configure
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure`;
CREATE TABLE `sys_configure`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置列表名称',
  `SC_VIEW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图名',
  `SC_ORDER_BY` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ORDER BY语句',
  `SC_JSP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JSP地址',
  `SC_IS_SELECT` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启选择框  $SYS_YES_NO$',
  `SC_IS_PAGING` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否分页 $SYS_YES_NO$',
  `SC_IS_SEARCH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启搜索 $SYS_YES_NO$',
  `SC_IS_FILTER` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启自定义过滤 $SYS_YES_NO$',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE,
  INDEX `ID_3`(`ID`) USING BTREE,
  INDEX `ID_4`(`ID`) USING BTREE,
  INDEX `ID_5`(`ID`) USING BTREE,
  INDEX `ID_6`(`ID`) USING BTREE,
  INDEX `ID_7`(`ID`) USING BTREE,
  INDEX `ID_8`(`ID`) USING BTREE,
  INDEX `ID_9`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure
-- ----------------------------
INSERT INTO `sys_configure` VALUES ('1', '配置列表管理', 'v_configure', 'CONVERT(ID,SIGNED) DESC', 'admin/system/configure/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('162321745234100224', '流程管理-流程时间控制', 'v_process_time_control', 'CONVERT(ID,SIGNED) ASC', 'admin/system/process/timeControl/home', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('1758638922268672', '配置列表管理-设置字段', 'v_configure_column', 'CONVERT(SCC_IS_FIXED,SIGNED) DESC,SCC_ORDER ASC', 'admin/system/configure/column/home', NULL, '0', '1', '');
INSERT INTO `sys_configure` VALUES ('1870969903775744', '配置列表管理-设置搜索', 'v_configure_search', 'SCS_ORDER ASC', 'admin/system/configure/search/home', NULL, '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2', '按钮管理', 'v_button', 'SB_TYPE ASC,SB_ORDER ASC', 'admin/system/button/home', NULL, '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('20764730981351424', '验证管理-验证组', 'v_validate_group', 'CONVERT(ID,SIGNED) ASC', 'admin/system/validate/group/home', NULL, '1', '0', NULL);
INSERT INTO `sys_configure` VALUES ('2244279544053760', '验证管理', 'v_validate', 'CONVERT(ID,SIGNED) DESC', 'admin/system/validate/home', NULL, '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2265709233045504', '验证管理-设置字段', 'v_validate_field', '', 'admin/system/validate/field/home', NULL, '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('2268726246244352', '验证管理-正则管理', 'v_validate_regex', '', 'admin/system/validate/regex/home', NULL, '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26491587483664384', '格式管理', 'v_format', 'CONVERT(ID,SIGNED) DESC', 'admin/system/format/home', NULL, '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26568354160443392', '格式管理-详细', 'v_format_detail', 'SFD_ORDER ASC', 'admin/system/format/detail/home', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('26721805670547456', '流程管理-流程定义', 'v_process_definition', 'CONVERT(BUS_PROCESS,SIGNED) ASC,CONVERT(BUS_PROCESS2,SIGNED) ASC', 'admin/system/process/definition/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('27187947212111872', '流程管理-流程步骤', 'v_process_step', 'SPS_ORDER ASC', 'admin/system/process/step/home', '', '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('27999782165282816', '流程管理-流程启动角色', 'v_process_start', 'CONVERT(ID,SIGNED) ASC', 'admin/system/process/start/home', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2910894828814336', '字典管理', 'v_dict_type', 'CONVERT(ID,SIGNED) ASC', 'admin/system/dict/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('2912701923721216', '字典管理-信息', 'v_dict_info', 'SDI_ORDER ASC', 'admin/system/dict/info/home', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('2997414705233920', '菜单管理', 'v_menu', 'SM_ORDER ASC', 'admin/system/menu/home', '', '0', '1', NULL);
INSERT INTO `sys_configure` VALUES ('3', '角色管理', 'v_role', 'SR_TYPE ASC,CONVERT(ID,SIGNED) DESC', 'admin/system/role/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('33080508233547776', '流程管理-流程进度', 'v_process_schedule', 'CONVERT(ID,SIGNED) DESC', 'admin/system/process/schedule/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('3316994321416192', '操作员管理', 'v_operator', 'CONVERT(ID,SIGNED) DESC', 'admin/system/operator/home', '', '1', '1', NULL);
INSERT INTO `sys_configure` VALUES ('3545555946962944', '操作员管理-账号管理', 'v_operator_sub', '', 'admin/system/operator/sub/home', '', '0', '0', NULL);
INSERT INTO `sys_configure` VALUES ('52185393809850368', '日志管理-系统日志', 'v_log_system', 'SL_ENTERTIME DESC', 'admin/log/system/home', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52235707715944448', '日志管理-操作日志', 'v_log_use', 'SL_ENTERTIME DESC', 'admin/log/use/home', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52235788951224320', '日志管理-登录日志', 'v_log_personal', 'SL_ENTERTIME DESC', 'admin/log/personal/home', '', '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('52258927902982144', '日志管理-查看日志', 'v_log_see', 'SL_ENTERTIME DESC', 'admin/log/see/home', NULL, '1', '1', '1');
INSERT INTO `sys_configure` VALUES ('53384301168820224', '日志管理-数据变动记录', 'v_log_value_record', 'SVR_ENTRY_TIME DESC', 'admin/log/record/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('53604023634231296', '日志管理-数据变动记录-详细', 'v_log_value_record_detail', 'SVR_ENTRY_TIME DESC', 'admin/log/record/detail/home', '', '1', '1', '');
INSERT INTO `sys_configure` VALUES ('58409949016883200', '配置列表管理-设置文件', 'v_configure_file', '', 'admin/system/configure/file/home', '', '0', '1', '');

-- ----------------------------
-- Table structure for sys_configure_column
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure_column`;
CREATE TABLE `sys_configure_column`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCC_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名',
  `SCC_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据查询字段',
  `SCC_ALIGN` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对齐方式',
  `SCC_WIDTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '宽度',
  `SCC_CLASS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列的classname',
  `SCC_FUNC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '格式化函数',
  `SCC_SDT_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典SDT_CODE',
  `SCC_IS_FIXED` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否是固定列 $SYS_FIXED$',
  `SCC_IS_EXPORT` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否导出 $SYS_YES_NO$',
  `SCC_IS_OPERATION` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是操作列',
  `SCC_IS_MERGE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合并操作列',
  `SCC_IS_VISIBLE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否隐藏',
  `SCC_IS_STATUS` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是状态列',
  `SCC_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SC_ID`(`SC_ID`) USING BTREE,
  CONSTRAINT `KIM_SC_ID` FOREIGN KEY (`SC_ID`) REFERENCES `sys_configure` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure_column
-- ----------------------------
INSERT INTO `sys_configure_column` VALUES ('1', '1', '名称', 'SC_NAME', 'left', '200px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('10', '2', '排序', 'SB_ORDER', 'center', '50px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('12', '2', '操作', '', 'center', '180px', '', '', '', '0', '1', '1', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('13', '3', '名称', 'SR_NAME', 'center', '200px', '', '', NULL, '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('14', '3', '操作', '', 'center', '200px', '', '', '', '0', '1', '1', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('162321745271848960', '162321745234100224', '开始时间', 'SPTC_START_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('162321745297014784', '162321745234100224', '操作', '', 'center', '160px', '', '', '', '0', '1', '1', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('162321981729931264', '162321745234100224', '结束时间', 'SPTC_END_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('162322037522563072', '162321745234100224', '录入时间', 'SPTC_ENTRY_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('162322096058269696', '162321745234100224', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '1', 40);
INSERT INTO `sys_configure_column` VALUES ('162328740771135488', '26721805670547456', '时间范围', 'SPTC_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 65);
INSERT INTO `sys_configure_column` VALUES ('18', '1758638922268672', '名称', 'SCC_NAME', 'center', '70px', '', '', NULL, '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('1860152030396416', '1758638922268672', '查询字段', 'SCC_FIELD', 'center', '100px', '', '', NULL, '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('1860905247703040', '1758638922268672', '对齐方式', 'SCC_ALIGN', 'center', '60px', '', '', 'SYS_ALIGN', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('1864436302217216', '1758638922268672', '宽度', 'SCC_WIDTH', 'center', '50px', '', '', '', '0', '1', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('1864567009312768', '1758638922268672', '字典CODE', 'SCC_SDT_CODE', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('1864656347987968', '1758638922268672', '是否操作列', 'SCC_IS_OPERATION', 'center', '70px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('1864758626091008', '1758638922268672', '是否显示', 'SCC_IS_VISIBLE', 'center', '70px', '', '', 'SYS_YES_NO', '0', '1', '0', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('1864854247833600', '1758638922268672', '是否状态列', 'SCC_IS_STATUS', 'center', '70px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('1864960447610880', '1758638922268672', '排序', 'SCC_ORDER', 'center', '30px', '', '', '', '0', '1', '0', '', '1', '0', 90);
INSERT INTO `sys_configure_column` VALUES ('1865046737027072', '1758638922268672', '操作', '', 'center', '120px', '', '', '', '0', '1', '1', '', '1', '0', 100);
INSERT INTO `sys_configure_column` VALUES ('1868640605437952', '3', '角色编码', 'SR_CODE', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('1868813838581760', '3', '说明', 'SR_EXPLAIN', 'center', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('1868880834199552', '3', '备注', 'SR_REMARK', 'center', '200px', '', '', '', '0', '1', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('1869275610480640', '3', '类型', 'SR_TYPE', 'center', '50px', '', '', 'SYS_ROLE_TYPE', '0', '1', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('1869396372881408', '3', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '1', '0', NULL, '1', '1', 6);
INSERT INTO `sys_configure_column` VALUES ('2', '1', '视图', 'SC_VIEW', 'left', '200px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('20765562036551680', '20764730981351424', '组', 'SVG_GROUP', 'center', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('20765795134996480', '20764730981351424', '组字段', 'SVF_NAMES', 'center', '300px', '', 'formatterValidateFields(targets, field)', '', '0', '1', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('20765840668360704', '20764730981351424', '操作', '', 'center', '150px', '', '', '', '0', '1', '1', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('21038555857944576', '2265709233045504', '组', 'SVG_GROUPS', 'center', '150px', '', 'formatterValidateGroups(targets, field)', '', '0', '1', '0', NULL, '1', '0', 65);
INSERT INTO `sys_configure_column` VALUES ('2158780263432192', '1870969903775744', '名称', 'SCS_NAME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2158865617518592', '1870969903775744', '查询字段', 'SCS_FIELD', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2158947087679488', '1870969903775744', '字典', 'SCS_SDT_CODE', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2159271412236288', '1870969903775744', '查询条件', 'SCS_METHOD_TYPE', 'center', '100px', '', '', 'SYS_SEARCH_METHOD', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2159361338114048', '1870969903775744', '类型', 'SCS_TYPE', 'center', '70px', '', '', 'SYS_SEARCH_TYPE', '0', '1', '0', '', '1', '0', 7);
INSERT INTO `sys_configure_column` VALUES ('2159444662157312', '1870969903775744', '是否显示', 'SCC_IS_VISIBLE', 'center', '70px', '', '', 'SYS_YES_NO', '0', '1', '0', '', '1', '0', 8);
INSERT INTO `sys_configure_column` VALUES ('2159495593590784', '1870969903775744', '排序', 'SCS_ORDER', 'center', '30px', '', '', '', '0', '1', '0', NULL, '1', '0', 9);
INSERT INTO `sys_configure_column` VALUES ('2159557145001984', '1870969903775744', '操作', '', 'center', '180px', '', '', '', '0', '1', '1', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('2178961341677568', '1870969903775744', '备注', 'SCS_REMARK', 'left', '100px', '', '', '', '0', '1', '0', '', '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('2244934925025280', '2244279544053760', '表名', 'SV_TABLE', 'center', '200px', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2245043909820416', '2244279544053760', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '1', 2);
INSERT INTO `sys_configure_column` VALUES ('2245094707036160', '2244279544053760', '操作', '', 'center', '280px', '', '', '', '0', '1', '1', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2266941783801856', '2265709233045504', '名称', 'SVF_NAME', 'center', '130px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2267042472263680', '2265709233045504', '字段', 'SVF_FIELD', 'center', '130px', '', '', '', '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2267136751828992', '2265709233045504', '是否必填', 'SVF_IS_REQUIRED', 'center', '60px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2267227038416896', '2265709233045504', '最大字数', 'SVF_MAX_LENGTH', 'center', '60px', '', '', '', '0', '1', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2267305589342208', '2265709233045504', '最小字数', 'SVF_MIN_LENGTH', 'center', '60px', '', '', '', '0', '1', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2267444773126144', '2265709233045504', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '1', 70);
INSERT INTO `sys_configure_column` VALUES ('2267542622044160', '2265709233045504', '操作', '', 'center', '150px', '', '', '', '0', '1', '1', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('2268804033806336', '2268726246244352', '名称', 'SVR_NAME', 'center', '200px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2268850032738304', '2268726246244352', '正则', 'SVR_REGEX', 'center', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2268917275820032', '2268726246244352', '操作', '', 'center', '160px', '', '', '', '0', '1', '1', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2268978571378688', '2268726246244352', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '1', 4);
INSERT INTO `sys_configure_column` VALUES ('2510530543616000', '2268726246244352', '错误消息', 'SVR_REGEX_MESSAGE', 'left', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2515524864966656', '2265709233045504', '正则', 'SVR_NAME', 'center', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('26505467689697280', '26491587483664384', '格式名称', 'SF_NAME', 'left', '250px', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26505514997252096', '26491587483664384', '格式唯一标识', 'SF_CODE', 'left', '250px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26505581862846464', '26491587483664384', '格式配置年份', 'SF_YEAR', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26505673726492672', '26491587483664384', '格式配置时间', 'SF_ENTRY_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('26505863703298048', '26491587483664384', '操作', '', 'center', '240px', '', '', '', '0', '1', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('26568881204101120', '26568354160443392', '格式详细名称', 'SFD_NAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26569120757579776', '26568354160443392', '菜单名称', 'SM_NAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26569174163652608', '26568354160443392', '排序', 'SFD_ORDER', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26569430683090944', '26568354160443392', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '1', 40);
INSERT INTO `sys_configure_column` VALUES ('26569508260937728', '26568354160443392', '操作', '', 'center', '160px', '', '', '', '0', '1', '1', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('26725371181268992', '26721805670547456', '流程名称', 'SPD_NAME', 'center', '200px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('26725441578467328', '26721805670547456', '版本', 'SPD_VERSION', 'center', '50px', '', '', '', '0', '1', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('26725572235231232', '26721805670547456', '更新表名', 'SPD_UPDATE_TABLE', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('26725657031475200', '26721805670547456', '更新表名称字段', 'SPD_UPDATE_NAME', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('26725837801783296', '26721805670547456', '时间控制', 'IS_TIME_CONTROL', 'center', '50px', '', '', 'SYS_YES_NO', '0', '1', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('26725907158794240', '26721805670547456', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '1', 70);
INSERT INTO `sys_configure_column` VALUES ('26725940633534464', '26721805670547456', '操作', '', 'center', '140px', '', '', '', '0', '1', '1', '', '1', '0', 80);
INSERT INTO `sys_configure_column` VALUES ('27188897591066624', '27187947212111872', '步骤名称', 'SPS_NAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('27190954163175424', '27187947212111872', '办理角色', 'SR_NAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('27191092403240960', '27187947212111872', '流程状态', 'SPS_PROCESS_STATUS', 'center', '', '', '', 'SYS_PROCESS_STATUS', '0', '1', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('27191203975921664', '27187947212111872', '验证超时', 'SPS_IS_OVER_TIME', 'center', '60px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('27191254274015232', '27187947212111872', '超时时间(分)', 'SPS_OVER_TIME', 'center', '90px', '', '', '', '0', '1', '0', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('27191384893030400', '27187947212111872', '办理类型', 'SPS_STEP_TYPE', 'center', '60px', '', '', 'SYS_STEP_TYPE', '0', '1', '0', NULL, '1', '0', 25);
INSERT INTO `sys_configure_column` VALUES ('27191443244187648', '27187947212111872', '排序', 'SPS_ORDER', 'center', '50px', '', '', '', '0', '1', '0', NULL, '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('27191508914405376', '27187947212111872', '操作', '', 'center', '160px', '', '', '', '0', '1', '1', NULL, '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('28000060813869056', '27999782165282816', '角色名称', 'SR_NAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('28000165969264640', '27999782165282816', '角色编码', 'SR_CODE', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('28000216644845568', '27999782165282816', '操作', '', 'center', '160px', '', '', '', '0', '1', '1', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('2911711610798080', '2910894828814336', '字典名称', 'SDT_NAME', 'left', '250px', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2911767181131776', '2910894828814336', '字典编码', 'SDT_CODE', 'left', '250px', '', '', '', '0', '1', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2911814169919488', '2910894828814336', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '1', '0', NULL, '1', '1', 3);
INSERT INTO `sys_configure_column` VALUES ('2911845136465920', '2910894828814336', '操作', '', 'center', '280px', '', '', '', '0', '1', '1', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2913356109316096', '2912701923721216', '名称', 'SDI_NAME', 'left', '220px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2913416456962048', '2912701923721216', '信息编码', 'SDI_CODE', 'center', '130px', '', '', '', '0', '1', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2913455988277248', '2912701923721216', '连接编码', 'SDI_INNERCODE', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2913615233417216', '2912701923721216', '备注', 'SDI_REMARK', 'left', '200px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('2913660032778240', '2912701923721216', '排序', 'SDI_ORDER', 'center', '50px', '', '', '', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('2913742199193600', '2912701923721216', '状态', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '1', 60);
INSERT INTO `sys_configure_column` VALUES ('2913770057760768', '2912701923721216', '操作', '', 'center', '180px', '', '', '', '0', '1', '1', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('2997755832172544', '2997414705233920', '菜单名称', 'SM_NAME', 'left', '250px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('2997843275022336', '2997414705233920', '配置列表', 'SC_NAME', 'left', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('2997919837847552', '2997414705233920', '权限编码', 'SM_CODE', 'left', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('2997976557420544', '2997414705233920', 'URL地址', 'SM_URL', 'left', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('2998205407035392', '2997414705233920', '图标', 'SM_CLASSICON', 'center', '30px', '', 'formatterIcon(value, row, index);', '', '0', '1', '0', NULL, '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('2998269449863168', '2997414705233920', '排序', 'SM_ORDER', 'center', '20px', '', '', '', '0', '1', '0', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('2998347505860608', '2997414705233920', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '1', '0', NULL, '1', '1', 7);
INSERT INTO `sys_configure_column` VALUES ('2998399913689088', '2997414705233920', '操作', '', 'center', '250px', '', '', '', '0', '1', '1', '0', '1', '0', 8);
INSERT INTO `sys_configure_column` VALUES ('3', '1', 'JSP地址', 'SC_JSP', 'left', '280px', '', '', '', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('3317102362492928', '3316994321416192', '姓名', 'SAI_NAME', 'center', '130px', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('3317258654842880', '3316994321416192', '登录账号', 'SOS_USERNAME', 'left', '150px', '', '', '', '0', '1', '0', '', '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('3317344390610944', '3316994321416192', '手机', 'SAI_PHONE', 'center', '80px', '', '', '', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('3317375399100416', '3316994321416192', '邮箱', 'SAI_EMAIL', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('3317518018019328', '3316994321416192', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '1', '0', '', '1', '1', 50);
INSERT INTO `sys_configure_column` VALUES ('3317579653316608', '3316994321416192', '操作', '', 'center', '360px', '', '', '', '0', '1', '1', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('33262437608194048', '33080508233547776', '流程定义', 'SPD_NAME', 'left', '150px', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('33262560820068352', '33080508233547776', '项目名称', 'SPS_TABLE_NAME', 'left', '200px', '', '', '', '0', '1', '0', NULL, '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('33264112095985664', '33080508233547776', '启动人', 'INITIATOR_NAME', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('33264915670106112', '33080508233547776', '当前步骤名称', 'STEP_NAME', 'center', '100px', '', '', '', '0', '1', '0', NULL, '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('33264993856126976', '33080508233547776', '流程状态', 'PROCESS_STATUS_NAME', 'center', '100px', '', 'processLogFunc(targets, field);', '', '0', '1', '0', NULL, '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('33265154850291712', '33080508233547776', '是否作废', 'SPS_IS_CANCEL', 'center', '80px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('33265501832478720', '33080508233547776', '操作', '', 'center', '80px', '', '', '', '0', '1', '1', NULL, '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('3545634929901568', '3545555946962944', '登录账号', 'SOS_USERNAME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('3547333325225984', '3545555946962944', '是否默认', 'SOS_DEFAULT', 'center', '80px', '', '', 'SYS_YES_NO', '0', '1', '0', NULL, '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('3547388299968512', '3545555946962944', '状态', 'IS_STATUS', 'center', '30px', '', '', '', '0', '1', '0', NULL, '1', '1', 5);
INSERT INTO `sys_configure_column` VALUES ('3547457338212352', '3545555946962944', '创建时间', 'SOS_CREATETIME', 'center', '', '', '', '', '0', '1', '0', NULL, '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('3547490485796864', '3545555946962944', '操作', '', 'center', '', '', '', '', '0', '1', '1', NULL, '1', '0', 6);
INSERT INTO `sys_configure_column` VALUES ('4', '1', '操作', '', 'center', '380px', '', '', '', '0', '1', '1', '', '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('48527923962970112', '3316994321416192', '类型', 'SAI_TYPE', 'center', '50px', '', '', 'SYS_OPERATOR_TYPE', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('49300938162176000', '26721805670547456', '大类', 'BUS_PROCESS', 'center', '50px', '', '', '', '0', '1', '0', '', '1', '0', 45);
INSERT INTO `sys_configure_column` VALUES ('49301009763139584', '26721805670547456', '小类', 'BUS_PROCESS2', 'center', '50px', '', '', '', '0', '1', '0', '', '1', '0', 46);
INSERT INTO `sys_configure_column` VALUES ('5', '2', '名称', 'SB_NAME', 'center', '150px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('52227996769058816', '52185393809850368', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52228093506486272', '52185393809850368', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52228151819894784', '52185393809850368', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52228262180421632', '52185393809850368', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52228391499202560', '52185393809850368', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52228826968621056', '52185393809850368', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52235707783053312', '52235707715944448', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52235707833384960', '52235707715944448', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52235707862745088', '52235707715944448', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52235708106014720', '52235707715944448', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52235708122791936', '52235707715944448', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52235708437364736', '52235707715944448', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52235788988973056', '52235788951224320', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52235789018333184', '52235788951224320', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52235789039304704', '52235788951224320', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52235789278380032', '52235788951224320', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52235789295157248', '52235788951224320', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52235789605535744', '52235788951224320', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('52258927953313792', '52258927902982144', '事件', 'SL_EVENT', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('52258927982673920', '52258927902982144', '操作员', 'SAI_NAME', 'center', '120px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('52258927999451136', '52258927902982144', 'IP地址', 'SL_IP', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('52258928267886592', '52258927902982144', '时间', 'SL_ENTERTIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('52258928284663808', '52258927902982144', '内容', 'SLT_CONTENT', 'center', '300px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('52258928716677120', '52258927902982144', '结果', 'SL_RESULT', 'center', '70px', '', '', 'SYS_SUCCESS_FAIL', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('53385726074552320', '53384301168820224', '表名', 'SVR_TABLE_NAME', 'center', '140px', '', '', '', '0', '1', '0', '', '1', '0', 10);
INSERT INTO `sys_configure_column` VALUES ('53385786342506496', '53384301168820224', '操作员', 'SAI_NAME', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('53385995432755200', '53384301168820224', '旧值', 'SVR_OLD_VALUE', 'left', '200px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('53386072725389312', '53384301168820224', '新值', 'SVR_NEW_VALUE', 'left', '200px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('53386161413947392', '53384301168820224', '变动时间', 'SVR_ENTRY_TIME', 'center', '75px', '', '', '', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('53386248835825664', '53384301168820224', '类型', 'SVR_TYPE', 'center', '60px', '', '', 'SYS_VALUE_RECORD_TYPE', '0', '1', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('53386340263264256', '53384301168820224', '操作', '', 'center', '70px', '', '', '', '0', '1', '1', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('53591377707008000', '53384301168820224', 'TABLE_ID', 'SVR_TABLE', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 5);
INSERT INTO `sys_configure_column` VALUES ('53604023764254720', '53604023634231296', '操作员', 'SAI_NAME', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('53604024091410432', '53604023634231296', '旧值', 'SVR_OLD_VALUE', 'left', '200px', '', '', '', '0', '1', '0', '', '1', '0', 30);
INSERT INTO `sys_configure_column` VALUES ('53604024112381952', '53604023634231296', '新值', 'SVR_NEW_VALUE', 'left', '200px', '', '', '', '0', '1', '0', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('53604024548589568', '53604023634231296', '变动时间', 'SVR_ENTRY_TIME', 'center', '140px', '', '', '', '0', '1', '0', '', '1', '0', 50);
INSERT INTO `sys_configure_column` VALUES ('53604024565366784', '53604023634231296', '类型', 'SVR_TYPE', 'center', '60px', '', '', 'SYS_VALUE_RECORD_TYPE', '0', '1', '0', '', '1', '0', 60);
INSERT INTO `sys_configure_column` VALUES ('53604024988991488', '53604023634231296', '操作', '', 'center', '70px', '', '', '', '0', '1', '1', '', '1', '0', 70);
INSERT INTO `sys_configure_column` VALUES ('55012670088151040', '1758638922268672', '固定列', 'SCC_IS_FIXED', 'center', '70px', '', '', 'SYS_FIXED', '0', '1', '0', '', '1', '0', 75);
INSERT INTO `sys_configure_column` VALUES ('55012866624847872', '1758638922268672', '是否导出', 'SCC_IS_EXPORT', 'center', '70px', '', '', 'SYS_YES_NO', '0', '1', '0', '', '1', '0', 76);
INSERT INTO `sys_configure_column` VALUES ('56903482577256448', '2912701923721216', '是否是叶节点', 'SDI_IS_LEAF', 'center', '100px', '', '', 'SYS_YES_NO', '0', '1', '0', '', '1', '0', 35);
INSERT INTO `sys_configure_column` VALUES ('58409949083992064', '58409949016883200', '名称', 'SCF_NAME', 'center', '', '', '', '', '0', '1', '0', '', '1', '0', 1);
INSERT INTO `sys_configure_column` VALUES ('58409950673633280', '58409949016883200', '操作', '', 'center', '180px', '', '', '', '0', '1', '1', '', '1', '0', 40);
INSERT INTO `sys_configure_column` VALUES ('58410347605786624', '58409949016883200', '是否启用', 'IS_STATUS', 'center', '100px', '', '', '', '0', '1', '0', '', '1', '1', 30);
INSERT INTO `sys_configure_column` VALUES ('58410493311713280', '58409949016883200', '添加时间', 'SCF_ENTRY_TIME', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 20);
INSERT INTO `sys_configure_column` VALUES ('6', '2', '操作ID', 'SB_BUTTONID', 'center', '100px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 2);
INSERT INTO `sys_configure_column` VALUES ('7', '2', '图标', 'SB_ICON', 'center', '50px', '', 'btnClassFunc(targets,field)', '', '0', '1', '0', '', '1', '0', 3);
INSERT INTO `sys_configure_column` VALUES ('8', '2', '权限编码', 'SB_CODE', 'center', '150px', '', '', '', '0', '1', '0', '', '1', '0', 4);
INSERT INTO `sys_configure_column` VALUES ('9', '2', '按钮类型', 'SB_TYPE_NAME', 'center', '70px', NULL, NULL, NULL, '0', '1', '0', NULL, '1', '0', 5);

-- ----------------------------
-- Table structure for sys_configure_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure_file`;
CREATE TABLE `sys_configure_file`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `SC_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置列表 @SYS_CONFIGURE,SC_NAME@',
  `SCF_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名称',
  `IS_STATUS` int(1) NULL DEFAULT 1 COMMENT '是否启用 $SYS_YES_NO$',
  `SCF_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SC_ID`(`SC_ID`) USING BTREE,
  INDEX `IS_STATUS`(`IS_STATUS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure_file
-- ----------------------------
INSERT INTO `sys_configure_file` VALUES ('58428571672117248', '50831880232108032', '学校奖学金导入模板', 1, '2018-09-02 21:48:06');
INSERT INTO `sys_configure_file` VALUES ('62698194781339648', '62083883247599616', '勤工助学名单导入模板', 1, '2018-09-14 16:34:03');
INSERT INTO `sys_configure_file` VALUES ('62698243603038208', '62461073449549824', '勤工助学月工资导入模板', 1, '2018-09-14 16:34:15');

-- ----------------------------
-- Table structure for sys_configure_search
-- ----------------------------
DROP TABLE IF EXISTS `sys_configure_search`;
CREATE TABLE `sys_configure_search`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCS_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `SCS_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段',
  `SCS_SDT_CODE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典CODE',
  `SCS_METHOD_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询条件',
  `SCS_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '搜索类型',
  `SCS_IS_STUDENT_YEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否学年搜索',
  `SCS_REMARK` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `SCC_IS_VISIBLE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否要显示到界面上',
  `SCS_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SC_ID`(`SC_ID`) USING BTREE,
  CONSTRAINT `SC_ID` FOREIGN KEY (`SC_ID`) REFERENCES `sys_configure` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_configure_search
-- ----------------------------
INSERT INTO `sys_configure_search` VALUES ('1', '1758638922268672', '配置列表ID', 'SC_ID', NULL, '1', '1', '1', NULL, '0', 999);
INSERT INTO `sys_configure_search` VALUES ('2', '1870969903775744', '配置列表ID', 'SC_ID', '', '1', '1', '1', NULL, '0', 999);
INSERT INTO `sys_configure_search` VALUES ('20765340250144768', '20764730981351424', '验证表ID', 'SV_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('2171824976691200', '1', '名称', 'SC_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2171865384615936', '1', '视图', 'SC_VIEW', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186041037422592', '2', '名称', 'SB_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2186121794551808', '2', '按钮ID', 'SB_BUTTONID', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186200785879040', '2', '权限编码', 'SB_CODE', '', '4', '1', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('2186332197617664', '2', '类型', 'SB_TYPE', 'SYS_BUTTON_TYPE', '1', '2', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('2186661538562048', '3', '名称', 'SR_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2186704823779328', '3', '角色编码', 'SR_CODE', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('2186816178356224', '3', '类型', 'SR_TYPE', 'SYS_ROLE_TYPE', '1', '2', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('2186924844384256', '3', '状态', 'IS_STATUS', 'SYS_YES_NO', '1', '2', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('2245173287321600', '2244279544053760', '表名', 'SV_TABLE', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2509095781269504', '2265709233045504', '验证表ID', 'SV_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('26571126167568384', '26568354160443392', 'SF_ID', 'SF_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('26726106744750080', '26721805670547456', '流程名称', 'SPD_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('26726185870295040', '26721805670547456', '流程更新表', 'SPD_UPDATE_TABLE', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('26726269102063616', '26721805670547456', '状态', 'IS_STATUS', 'SYS_YES_NO', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('27188785221468160', '27187947212111872', 'SPD_ID', 'SPD_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('28000645642452992', '27999782165282816', 'SPD_ID', 'SPD_ID', '', '1', '1', '1', '', '0', 99);
INSERT INTO `sys_configure_search` VALUES ('2936099735339008', '2912701923721216', 'SDT_ID', 'SDT_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('29363312076521472', '2910894828814336', '是否隐藏', 'IS_HIDDEN', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('2936386403434496', '2268726246244352', '正则名称', 'SVR_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2936517366382592', '2910894828814336', '名称', 'SDT_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('2936558080491520', '2910894828814336', '编码', 'SDT_CODE', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('3318078297341952', '3316994321416192', '姓名', 'SAI_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('3318164473511936', '3316994321416192', '登录账号', 'SOS_USERNAME', '', '4', '1', '1', '', '1', 2);
INSERT INTO `sys_configure_search` VALUES ('3318215916650496', '3316994321416192', '手机', 'SAI_PHONE', '', '4', '1', '1', '', '1', 3);
INSERT INTO `sys_configure_search` VALUES ('3318255989030912', '3316994321416192', '邮箱', 'SAI_EMAIL', '', '4', '1', '1', '', '1', 4);
INSERT INTO `sys_configure_search` VALUES ('33265648310157312', '33080508233547776', '流程定义', 'SPD_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('33265744854646784', '33080508233547776', '项目名称', 'SPS_TABLE_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('33265870629240832', '33080508233547776', '启动人', 'INITIATOR_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('33266027097751552', '33080508233547776', '流程状态', 'SPS_AUDIT_STATUS', 'SYS_PROCESS_STATUS', '1', '2', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('33266132563525632', '33080508233547776', '是否作废', 'SPS_IS_CANCEL', 'SYS_YES_NO', '1', '2', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('3547613181771776', '3545555946962944', 'SO_ID', 'SO_ID', '', '1', '1', '1', '', '0', 999);
INSERT INTO `sys_configure_search` VALUES ('39603098028605440', '2997414705233920', '名称', 'SM_NAME', '', '4', '1', '1', '', '1', 1);
INSERT INTO `sys_configure_search` VALUES ('48946558678335488', '3316994321416192', '类型', 'SAI_TYPE', 'SYS_OPERATOR_TYPE', '1', '2', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52228903812464640', '52185393809850368', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52229086726062080', '52185393809850368', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52229127566000128', '52185393809850368', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52229287880687616', '52185393809850368', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52229361411031040', '52185393809850368', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52229475181527040', '52185393809850368', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52235708483502080', '52235707715944448', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52235708823240704', '52235707715944448', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52235708848406528', '52235707715944448', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52235709121036288', '52235707715944448', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52235709142007808', '52235707715944448', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52235709435609088', '52235707715944448', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52235789655867392', '52235788951224320', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52235789974634496', '52235788951224320', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52235789995606016', '52235788951224320', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52235790234681344', '52235788951224320', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52235790259847168', '52235788951224320', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52235790519894016', '52235788951224320', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('52258929148690432', '52258927902982144', '事件', 'SL_EVENT', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('52258929173856256', '52258927902982144', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('52258929484234752', '52258927902982144', 'IP', 'SL_IP', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('52258929501011968', '52258927902982144', '开始时间', 'SL_ENTERTIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('52258929798807552', '52258927902982144', '结束时间', 'SL_ENDTIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('52258929815584768', '52258927902982144', '结果', 'SL_RESULT', 'SYS_SUCCESS_FAIL', '1', '2', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('53386432907051008', '53384301168820224', '表名', 'SVR_TABLE_NAME', '', '4', '1', '1', '', '1', 10);
INSERT INTO `sys_configure_search` VALUES ('53387743643828224', '53384301168820224', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('53388065674100736', '53384301168820224', '开始时间', 'SVR_ENTRY_TIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('53388135358267392', '53384301168820224', '结束时间', 'SVR_END_TIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('53388665858031616', '53384301168820224', '类型', 'SVR_TYPE', 'SYS_VALUE_RECORD_TYPE', '3', '3', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('53604025509085184', '53604023634231296', '操作员', 'SAI_NAME', '', '4', '1', '1', '', '1', 20);
INSERT INTO `sys_configure_search` VALUES ('53604025521668096', '53604023634231296', '开始时间', 'SVR_ENTRY_TIME', '', '8', '6', '1', '', '1', 30);
INSERT INTO `sys_configure_search` VALUES ('53604025811075072', '53604023634231296', '结束时间', 'SVR_END_TIME', '', '6', '6', '1', '', '1', 40);
INSERT INTO `sys_configure_search` VALUES ('53604025823657984', '53604023634231296', '类型', 'SVR_TYPE', 'SYS_VALUE_RECORD_TYPE', '3', '3', '1', '', '1', 50);
INSERT INTO `sys_configure_search` VALUES ('53604197626544128', '53604023634231296', 'SVR_TABL', 'SVR_TABLE_ID', '', '1', '1', '1', '', '0', 99);
INSERT INTO `sys_configure_search` VALUES ('53607625203384320', '53384301168820224', 'TABLE_ID', 'SVR_TABLE', '', '4', '1', '1', '', '1', 5);
INSERT INTO `sys_configure_search` VALUES ('58409951172755456', '58409949016883200', '配置列表ID', 'SC_ID', '', '1', '1', '1', NULL, '0', 999);

-- ----------------------------
-- Table structure for sys_dict_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_info`;
CREATE TABLE `sys_dict_info`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SDT_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典主表ID',
  `SDT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `SDI_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_INNERCODE` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接代码',
  `SDI_PARENTID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父ID',
  `SDI_IS_LEAF` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是叶节点 $SYS_YES_NO$',
  `SDI_REMARK` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDI_REQUIRED` int(5) NULL DEFAULT 0 COMMENT '是否必填',
  `SDI_ORDER` int(5) NULL DEFAULT NULL COMMENT '字典排序',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SDT_CODE`(`SDT_CODE`) USING BTREE,
  INDEX `SDT_ID`(`SDT_ID`) USING BTREE,
  INDEX `SDI_CODE`(`SDI_CODE`) USING BTREE,
  CONSTRAINT `SDT_ID` FOREIGN KEY (`SDT_ID`) REFERENCES `sys_dict_type` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_info
-- ----------------------------
INSERT INTO `sys_dict_info` VALUES ('1', '1', 'SYS_ON_OFF', '启用', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('10', '3', 'SYS_SEARCH_METHOD', '小于等于', '6', 'lessThan', '0', NULL, '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('11', '3', 'SYS_SEARCH_METHOD', '大于', '7', 'greater', '0', NULL, '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('12', '3', 'SYS_SEARCH_METHOD', '大于等于', '8', 'greaterThan', '0', NULL, '', 0, 8, 1);
INSERT INTO `sys_dict_info` VALUES ('13', '4', 'SYS_BUTTON_TYPE', '顶部按钮', '0', '0', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('14', '4', 'SYS_BUTTON_TYPE', '列表按钮', '1', '1', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('15', '5', 'SYS_BUTTON_CLASS', '默认', 'btn btn-default', 'btn btn-default', '0', NULL, '标准的按钮', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('16', '5', 'SYS_BUTTON_CLASS', '原始', 'btn btn-primary', 'btn btn-primary', '0', NULL, '提供额外的视觉效果，标识一组按钮中的原始动作', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('17', '5', 'SYS_BUTTON_CLASS', '信息', 'btn btn-info', 'btn btn-info', '0', NULL, ' 信息警告消息的上下文按钮', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('18', '5', 'SYS_BUTTON_CLASS', '成功', 'btn btn-success', 'btn btn-success', '0', NULL, '表示一个成功的或积极的动作', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('19', '5', 'SYS_BUTTON_CLASS', '警告', 'btn btn-warning', 'btn btn-warning', '0', NULL, '表示应谨慎采取的动作', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('2', '1', 'SYS_ON_OFF', '关闭', '0', '0', '0', NULL, NULL, 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('20', '5', 'SYS_BUTTON_CLASS', '危险', 'btn btn-danger', 'btn btn-danger', '0', NULL, '表示一个危险的或潜在的负面动作', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('21', '5', 'SYS_BUTTON_CLASS', '链接', 'btn btn-link', 'btn btn-link', '0', NULL, '并不强调是一个按钮，看起来像一个链接，但同时保持按钮的行为', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('21390992187850752', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'pop3', 'pop3', 'pop3', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('21391049700147200', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'smtp', 'smtp', 'smtp', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('21401881397952512', '21390918460375040', 'SYS_EMAIL_PROTOCOL', 'imap', 'imap', 'imap', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('23', '2', 'SYS_YES_NO', '是', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('23853711512043520', '23853626858405888', 'FILE_TEST', '测试1', 'test1', 'test1', '0', NULL, '', 1, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('23854618110853120', '23853626858405888', 'FILE_TEST', '测试2', 'test2', 'test2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('24', '2', 'SYS_YES_NO', '否', '0', '0', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('25', '6', 'SYS_ALIGN', '居中', 'center', 'center', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('26', '6', 'SYS_ALIGN', '左对齐', 'left', 'left', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('27', '6', 'SYS_ALIGN', '右对齐', 'right', 'right', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('27191798979887104', '27191701793669120', 'SYS_STEP_TYPE', '角色', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('27191845347917824', '27191701793669120', 'SYS_STEP_TYPE', '人员', '2', '2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('27636810712612864', '27191919998140416', 'SYS_PROCESS_STATUS', '启动人员', '0', '0', '0', NULL, '未提交', 0, 0, 1);
INSERT INTO `sys_dict_info` VALUES ('27637224036106240', '27191919998140416', 'SYS_PROCESS_STATUS', '审核通过', '999', '999', '0', NULL, '', 0, 999, 1);
INSERT INTO `sys_dict_info` VALUES ('27637452621479936', '27191919998140416', 'SYS_PROCESS_STATUS', '撤回/退回', '-1', '-1', '0', NULL, '', 0, -1, 1);
INSERT INTO `sys_dict_info` VALUES ('28', '7', 'SYS_ROLE_TYPE', '管理员', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('29', '8', 'SYS_SEARCH_TYPE', '文本', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('30', '8', 'SYS_SEARCH_TYPE', '单选', '2', '2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('32', '8', 'SYS_SEARCH_TYPE', '多选', '3', '3', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('33', '8', 'SYS_SEARCH_TYPE', '年', '4', '4', '0', NULL, '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('34', '8', 'SYS_SEARCH_TYPE', '年月日', '6', '6', '0', NULL, '', 0, 6, 1);
INSERT INTO `sys_dict_info` VALUES ('35', '8', 'SYS_SEARCH_TYPE', '年月日时分秒', '9', '9', '0', '', '', 0, 9, 1);
INSERT INTO `sys_dict_info` VALUES ('3546159557640192', '3546057401171968', 'SYS_OPERATOR_TYPE', '管理员', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('3546984086503424', '3546057401171968', 'SYS_OPERATOR_TYPE', '部门', '2', '2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('36', '8', 'SYS_SEARCH_TYPE', '年月', '5', '5', '0', NULL, '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('48528552202600448', '3546057401171968', 'SYS_OPERATOR_TYPE', '系部', '3', '3', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('48528576848330752', '3546057401171968', 'SYS_OPERATOR_TYPE', '学生', '4', '4', '0', NULL, '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('48528600491622400', '3546057401171968', 'SYS_OPERATOR_TYPE', '教师', '5', '5', '0', NULL, '', 0, 5, 1);
INSERT INTO `sys_dict_info` VALUES ('49270789383389184', '9', 'SYS_PROCESS_TYPE', '测试流程', '1001', '1001', '0', '1', '', 0, 999, 1);
INSERT INTO `sys_dict_info` VALUES ('49270878021615616', '9', 'SYS_PROCESS_TYPE', '测试流程2', '2001', '1001.2001', '49270789383389184', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49301852625305600', '9', 'SYS_PROCESS_TYPE', '测试流程3', '2002', '1001.2002', '49270789383389184', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('49302304356040704', '9', 'SYS_PROCESS_TYPE', '测试2.1', '2003', '1002.2003', '49301917020454912', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('49615720119533568', '49615343454257152', 'BUS_FILE_DEFAULT', '附件', 'DEFAULT', 'DEFAULT', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('5', '3', 'SYS_SEARCH_METHOD', '等于', '1', 'eq', '0', NULL, NULL, 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50802464470859776', '9', 'SYS_PROCESS_TYPE', '资助管理', '100', '100', '0', '1', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('50802594620112896', '9', 'SYS_PROCESS_TYPE', '学校奖学金', '109', '100.109', '50802464470859776', NULL, '', 0, 9, 1);
INSERT INTO `sys_dict_info` VALUES ('50804677247238144', '9', 'SYS_PROCESS_TYPE', '年度表彰', '110', '100.110', '50802464470859776', NULL, '', 0, 10, 1);
INSERT INTO `sys_dict_info` VALUES ('50839345229201408', '27191919998140416', 'SYS_PROCESS_STATUS', '学生处', '99', '99', '0', NULL, '', 0, 99, 1);
INSERT INTO `sys_dict_info` VALUES ('52229765242814464', '10', 'SYS_SUCCESS_FAIL', '成功', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('52229795525689344', '10', 'SYS_SUCCESS_FAIL', '失败', '0', '0', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('52506154542039040', '27191919998140416', 'SYS_PROCESS_STATUS', '辅导员', '50', '50', '0', NULL, '', 0, 50, 1);
INSERT INTO `sys_dict_info` VALUES ('52506480846307328', '27191919998140416', 'SYS_PROCESS_STATUS', '系部管理员', '51', '51', '0', NULL, '', 0, 51, 1);
INSERT INTO `sys_dict_info` VALUES ('53384736596295680', '11', 'SYS_VALUE_RECORD_TYPE', '插入', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('53384767311183872', '11', 'SYS_VALUE_RECORD_TYPE', '更新', '2', '2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('53384795660484608', '11', 'SYS_VALUE_RECORD_TYPE', '删除', '3', '3', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('54459895730143232', '9', 'SYS_PROCESS_TYPE', '绿色通道(学院级)', '101', '100.101', '50802464470859776', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('54459895730143233', '9', 'SYS_PROCESS_TYPE', '绿色通道(系级)', '114', '100.114', '50802464470859776', '', '', 0, 114, 1);
INSERT INTO `sys_dict_info` VALUES ('54460165071568896', '9', 'SYS_PROCESS_TYPE', '减免学费', '107', '100.107', '50802464470859776', NULL, '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('54460306910347264', '9', 'SYS_PROCESS_TYPE', '困难毕业生就业补助', '111', '100.111', '50802464470859776', NULL, '', 0, 11, 1);
INSERT INTO `sys_dict_info` VALUES ('54460426104078336', '9', 'SYS_PROCESS_TYPE', '应急求助', '113', '100.113', '50802464470859776', NULL, '', 0, 13, 1);
INSERT INTO `sys_dict_info` VALUES ('55006327197401088', '12', 'SYS_FIXED', '左', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('55006356515586048', '12', 'SYS_FIXED', '无', '0', '0', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('55006392745984000', '12', 'SYS_FIXED', '右', '-1', '-1', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('55922993825579008', '9', 'SYS_PROCESS_TYPE', '国家奖学金(学院级)', '102', '100.102', '50802464470859776', '', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('55922993825579009', '9', 'SYS_PROCESS_TYPE', '国家奖学金(系级)', '115', '100.115', '50802464470859776', '', '', 0, 115, 1);
INSERT INTO `sys_dict_info` VALUES ('55923060267548672', '9', 'SYS_PROCESS_TYPE', '国家助学金', '104', '100.104', '50802464470859776', NULL, '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('56172345097715712', '13', 'SYS_SELECT_TYPE', '多选', '1', '1', '0', NULL, '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('56172371039485952', '13', 'SYS_SELECT_TYPE', '单选', '2', '2', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('58388298342596608', '9', 'SYS_PROCESS_TYPE', '国家励志奖学金(学院级)', '103', '100.103', '50802464470859776', '', '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('58388298342596609', '9', 'SYS_PROCESS_TYPE', '国家励志奖学金(系级)', '116', '100.116', '50802464470859776', '', '', 0, 116, 1);
INSERT INTO `sys_dict_info` VALUES ('6', '3', 'SYS_SEARCH_METHOD', '不等于', '2', 'ne', '0', NULL, '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('61339743320801280', '7', 'SYS_ROLE_TYPE', '通用', '0', '0', '0', '', '', 0, 0, 1);
INSERT INTO `sys_dict_info` VALUES ('61345460392034304', '9', 'SYS_PROCESS_TYPE', '勤工助学', '200', '200', '0', '1', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('61345646761738240', '9', 'SYS_PROCESS_TYPE', '勤工助学', '201', '200.201', '61345460392034304', '', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('61345775963078656', '9', 'SYS_PROCESS_TYPE', '勤工助学月工资', '202', '200.202', '61345460392034304', '', '', 0, 2, 1);
INSERT INTO `sys_dict_info` VALUES ('61349921101447168', '27191919998140416', 'SYS_PROCESS_STATUS', '勤工助学初审', '1', '1', '0', '', '', 0, 1, 1);
INSERT INTO `sys_dict_info` VALUES ('62439973168611328', '8', 'SYS_SEARCH_TYPE', '年月日(无下滑)', '8', '8', '0', '', '', 0, 8, 1);
INSERT INTO `sys_dict_info` VALUES ('62440030882234368', '8', 'SYS_SEARCH_TYPE', '月', '7', '7', '0', '', '', 0, 7, 1);
INSERT INTO `sys_dict_info` VALUES ('7', '3', 'SYS_SEARCH_METHOD', '在其中', '3', 'in', '0', NULL, '', 0, 3, 1);
INSERT INTO `sys_dict_info` VALUES ('8', '3', 'SYS_SEARCH_METHOD', '模糊', '4', 'like', '0', NULL, '', 0, 4, 1);
INSERT INTO `sys_dict_info` VALUES ('9', '3', 'SYS_SEARCH_METHOD', '小于', '5', 'less', '0', NULL, '', 0, 5, 1);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SDT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `SDT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  `SDT_ROLE_DOWN` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件拥有权限下载角色',
  `SDT_ROLE_DEL` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件拥有权限删除角色',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  `IS_HIDDEN` int(5) NULL DEFAULT 0 COMMENT '是否隐藏',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '系统_启用-关闭', 'SYS_ON_OFF', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('10', '系统_成功失败', 'SYS_SUCCESS_FAIL', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('11', '系统_数据变动类型', 'SYS_VALUE_RECORD_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('12', '系统_固定方向', 'SYS_FIXED', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('13', '系统_选择类型', 'SYS_SELECT_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('2', '系统_是_否', 'SYS_YES_NO', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('21390918460375040', '系统_邮件协议', 'SYS_EMAIL_PROTOCOL', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('23853626858405888', '文件-测试', 'FILE_TEST', '1', '1', 1, 0);
INSERT INTO `sys_dict_type` VALUES ('27191701793669120', '流程_办理状态', 'SYS_STEP_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('27191919998140416', '流程_流程状态', 'SYS_PROCESS_STATUS', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('3', '系统_查询条件', 'SYS_SEARCH_METHOD', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('3546057401171968', '系统_用户类型', 'SYS_OPERATOR_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('4', '系统_按钮类型', 'SYS_BUTTON_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('49615343454257152', '业务_文件（默认）', 'BUS_FILE_DEFAULT', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('5', '系统_按钮样式', 'SYS_BUTTON_CLASS', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('6', '系统_对齐方式', 'SYS_ALIGN', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('7', '系统_角色类型', 'SYS_ROLE_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('8', '系统_搜索类型', 'SYS_SEARCH_TYPE', NULL, NULL, 1, 0);
INSERT INTO `sys_dict_type` VALUES ('9', '系统_流程定义', 'SYS_PROCESS_TYPE', NULL, NULL, 1, 0);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SF_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '各表主键ID',
  `SF_TABLE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表名',
  `SF_SDT_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典代码',
  `SF_SDI_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典子代码',
  `SF_ORIGINAL_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件原始名称',
  `SF_NAME` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件保存名称',
  `SF_PATH` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件保存路径',
  `SF_SUFFIX` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件后缀名',
  `SF_SIZE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件大小',
  `SF_SEE_TYPE` int(5) NULL DEFAULT 1 COMMENT '是否可以不用登录查看',
  `SF_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SF_TABLE_ID_NAME`(`SF_TABLE_ID`, `SF_TABLE_NAME`) USING BTREE,
  INDEX `SF_SDI_CODE`(`SF_TABLE_ID`, `SF_TABLE_NAME`, `SF_SDI_CODE`, `SF_SDT_CODE`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('24333612232998912', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', 'bg3.jpeg', '24333612232998912', 'file/2018-05-31/', 'jpeg', '272948', 1, '2018-05-31 19:46:58');
INSERT INTO `sys_file` VALUES ('24556195545088000', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '大字段.xlsx', '24556195545088000', 'file/2018-06-01/', 'xlsx', '20433', 1, '2018-06-01 10:31:22');
INSERT INTO `sys_file` VALUES ('24556195545088001', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '12.pptx', '24556195545088001', 'file/2018-06-01/', 'pptx', '1869015', 1, '2018-06-01 10:31:23');
INSERT INTO `sys_file` VALUES ('24556196404920320', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '新系统漏洞.doc', '24556196404920320', 'file/2018-06-01/', 'doc', '3731456', 1, '2018-06-01 10:31:23');
INSERT INTO `sys_file` VALUES ('24562004152811520', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test2', '1.png', '24562004152811520', 'file/2018-06-01/', 'png', '1833330', 1, '2018-06-01 10:54:28');
INSERT INTO `sys_file` VALUES ('33362560342294528', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '流程步骤控制.doc', '33362560342294528', 'file/2018-06-25/', 'doc', '120949', 1, '2018-06-25 17:44:43');
INSERT INTO `sys_file` VALUES ('33362752571441152', '1', '123456', 'SYS_FILE', 'FILE_TEST', 'test1', '流程步骤控制.doc', '33362752571441152', 'file/2018-06-25/', 'doc', '120949', 1, '2018-06-25 17:45:29');
INSERT INTO `sys_file` VALUES ('49746794988437504', '1', '49746696170635264', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'timg.jpg', '49746794988437504', 'punishment/2018-08-09/', 'jpg', '30046', 1, '2018-08-09 22:49:51');
INSERT INTO `sys_file` VALUES ('49754111855296512', '1', '1', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'u=635704053,1460945271&fm=27&gp=0.jpg', '49754111855296512', 'punishment/2018-08-09/', 'jpg', '29754', 1, '2018-08-09 23:18:54');
INSERT INTO `sys_file` VALUES ('49773713242980352', '1', '1', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', 'timg.jpg', '49773713242980352', 'punishment/2018-08-10/', 'jpg', '30046', 1, '2018-08-10 00:36:47');
INSERT INTO `sys_file` VALUES ('56269825151860736', '1', '56269795728818176', 'BUS_STUDENT_PUNISHMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', '困难毕业生就业补助导入模板.xlsx', '56269825151860736', 'punishment/2018-08-27/', 'xlsx', '10812', 1, '2018-08-27 22:50:01');
INSERT INTO `sys_file` VALUES ('58428571860860928', '1', '58428571672117248', 'SYS_CONFIGURE_FILE', 'BUS_FILE_DEFAULT', 'DEFAULT', '学校奖学金导入模板.xlsx', '58428571860860928', 'SYS_CONFIGURE_FILE/2018-09-02/', 'xlsx', '10483', 1, '2018-09-02 21:48:06');
INSERT INTO `sys_file` VALUES ('59165248048857088', '1', '', 'BUS_DOCUMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', '文件导入模板.xlsx', '59165248048857088', 'BUS_DOCUMENT/2018-09-04/', 'xlsx', '10280', 1, '2018-09-04 22:35:26');
INSERT INTO `sys_file` VALUES ('59169169496604672', '1', '59169139700269056', 'BUS_DOCUMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', '文件导入模板.xlsx', '59169169496604672', 'BUS_DOCUMENT/2018-09-04/', 'xlsx', '10280', 1, '2018-09-04 22:51:00');
INSERT INTO `sys_file` VALUES ('62698195024609280', '1', '62698194781339648', 'SYS_CONFIGURE_FILE', 'BUS_FILE_DEFAULT', 'DEFAULT', '勤工助学名单导入模板.xlsx', '62698195024609280', 'SYS_CONFIGURE_FILE/2018-09-14/', 'xlsx', '10281', 1, '2018-09-14 16:34:04');
INSERT INTO `sys_file` VALUES ('62698243842113536', '1', '62698243603038208', 'SYS_CONFIGURE_FILE', 'BUS_FILE_DEFAULT', 'DEFAULT', '勤工助学月工资导入模板.xlsx', '62698243842113536', 'SYS_CONFIGURE_FILE/2018-09-14/', 'xlsx', '10311', 1, '2018-09-14 16:34:15');
INSERT INTO `sys_file` VALUES ('70235827912835072', '1', '69492693457174528', 'BUS_DOCUMENT', 'BUS_FILE_DEFAULT', 'DEFAULT', '年度表彰导入模板.xlsx', '70235827912835072', 'BUS_DOCUMENT/2018-10-05/', 'xlsx', '10188', 1, '2018-10-05 11:45:57');

-- ----------------------------
-- Table structure for sys_format
-- ----------------------------
DROP TABLE IF EXISTS `sys_format`;
CREATE TABLE `sys_format`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SF_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `SF_CODE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一标识',
  `SF_YEAR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配置年度',
  `SF_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `SF_CODE`(`SF_CODE`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE,
  INDEX `ID_3`(`ID`) USING BTREE,
  INDEX `ID_4`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_format
-- ----------------------------
INSERT INTO `sys_format` VALUES ('26573352437022720', '流程定义', 'SYS_PROCESS_DEFINITION', '2018', '2018-06-07 00:06:50');

-- ----------------------------
-- Table structure for sys_format_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_format_detail`;
CREATE TABLE `sys_format_detail`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SF_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '格式表ID',
  `SM_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单表ID',
  `SFD_PARENT_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '父类菜单',
  `SFD_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `SFD_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SFD_SF_ID`(`SF_ID`) USING BTREE,
  CONSTRAINT `SFD_SF_ID` FOREIGN KEY (`SF_ID`) REFERENCES `sys_format` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_format_detail
-- ----------------------------
INSERT INTO `sys_format_detail` VALUES ('162322677036482560', '26573352437022720', '162322471645609984', '0', '流程时间控制', 4, 1);
INSERT INTO `sys_format_detail` VALUES ('26579144556937216', '26573352437022720', '26845813934129152', '0', '流程定义', 1, 1);
INSERT INTO `sys_format_detail` VALUES ('26716322922496000', '26573352437022720', '26714856669315072', '0', '流程步骤', 2, 1);
INSERT INTO `sys_format_detail` VALUES ('26717060805427200', '26573352437022720', '26715728707059712', '0', '流程启动角色', 3, 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户表主键',
  `SL_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志标题',
  `SL_EVENT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作事件',
  `SL_IP` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作IP',
  `SL_RESULT` int(1) NULL DEFAULT NULL COMMENT '日志操作结果 0 失败 1成功',
  `SL_ENTERTIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SL_TYPE` int(1) NULL DEFAULT NULL COMMENT '日志类型 0查看日志 1系统运行日志2用户操作日志9用户个人日志',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SL_TYPE`(`SL_TYPE`) USING BTREE,
  INDEX `SL_RESULT`(`SL_RESULT`) USING BTREE,
  INDEX `SL_ENTERTIME`(`SL_ENTERTIME`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('221421075513212928', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:07', 0);
INSERT INTO `sys_log` VALUES ('221421087886409728', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:10', 0);
INSERT INTO `sys_log` VALUES ('221421091178938368', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:11', 0);
INSERT INTO `sys_log` VALUES ('221421102323204096', '1', NULL, '设置操作员角色', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:14', 2);
INSERT INTO `sys_log` VALUES ('221421113245171712', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:16', 0);
INSERT INTO `sys_log` VALUES ('221421150960353280', '1', NULL, '登录', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:25', 9);
INSERT INTO `sys_log` VALUES ('221421172284194816', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:30', 0);
INSERT INTO `sys_log` VALUES ('221421176486887424', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:31', 0);
INSERT INTO `sys_log` VALUES ('221421182371495936', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:33', 0);
INSERT INTO `sys_log` VALUES ('221421185601110016', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:33', 0);
INSERT INTO `sys_log` VALUES ('221421187887005696', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:34', 0);
INSERT INTO `sys_log` VALUES ('221421202776784896', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:37', 0);
INSERT INTO `sys_log` VALUES ('221421206291611648', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:38', 0);
INSERT INTO `sys_log` VALUES ('221421211643543552', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:40', 0);
INSERT INTO `sys_log` VALUES ('221421216630571008', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:41', 0);
INSERT INTO `sys_log` VALUES ('221421218920660992', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:41', 0);
INSERT INTO `sys_log` VALUES ('221421221101699072', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:42', 0);
INSERT INTO `sys_log` VALUES ('221421229662273536', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:44', 0);
INSERT INTO `sys_log` VALUES ('221421235823706112', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:45', 0);
INSERT INTO `sys_log` VALUES ('221421239489527808', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:46', 0);
INSERT INTO `sys_log` VALUES ('221421242329071616', '1', NULL, '查看列表', '0:0:0:0:0:0:0:1', 1, '2019-11-26 16:22:47', 0);

-- ----------------------------
-- Table structure for sys_log_text
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_text`;
CREATE TABLE `sys_log_text`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SL_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志主表id',
  `SLT_CONTENT` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SL_ID`(`SL_ID`) USING BTREE,
  CONSTRAINT `SL_ID` FOREIGN KEY (`SL_ID`) REFERENCES `sys_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_text
-- ----------------------------
INSERT INTO `sys_log_text` VALUES ('221421075639042048', '221421075513212928', '查看角色管理');
INSERT INTO `sys_log_text` VALUES ('221421087911575552', '221421087886409728', '查看字典管理');
INSERT INTO `sys_log_text` VALUES ('221421091204104192', '221421091178938368', '查看操作员管理');
INSERT INTO `sys_log_text` VALUES ('221421102348369920', '221421102323204096', '操作员:admin,旧角色:[1],新角色:[1]');
INSERT INTO `sys_log_text` VALUES ('221421113261948928', '221421113245171712', '查看操作员管理');
INSERT INTO `sys_log_text` VALUES ('221421150977130496', '221421150960353280', '登录成功!登录地址:未知,登录时间:2019-11-26 16:22:25');
INSERT INTO `sys_log_text` VALUES ('221421172296777728', '221421172284194816', '查看系统日志');
INSERT INTO `sys_log_text` VALUES ('221421176507858944', '221421176486887424', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('221421182388273152', '221421182371495936', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('221421185626275840', '221421185601110016', '查看按钮管理');
INSERT INTO `sys_log_text` VALUES ('221421187907977216', '221421187887005696', '查看菜单管理');
INSERT INTO `sys_log_text` VALUES ('221421202793562112', '221421202776784896', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('221421206316777472', '221421206291611648', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('221421211668709376', '221421211643543552', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('221421216647348224', '221421216630571008', '查看操作日志');
INSERT INTO `sys_log_text` VALUES ('221421218941632512', '221421218920660992', '查看登录日志');
INSERT INTO `sys_log_text` VALUES ('221421221122670592', '221421221101699072', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('221421229687439360', '221421229662273536', '查看数据变动记录');
INSERT INTO `sys_log_text` VALUES ('221421235844677632', '221421235823706112', '查看查看日志');
INSERT INTO `sys_log_text` VALUES ('221421239514693632', '221421239489527808', '查看数据变动记录');
INSERT INTO `sys_log_text` VALUES ('221421242350043136', '221421242329071616', '查看查看日志');

-- ----------------------------
-- Table structure for sys_long_text
-- ----------------------------
DROP TABLE IF EXISTS `sys_long_text`;
CREATE TABLE `sys_long_text`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BLT_TABLE_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用表',
  `BLT_TABLE_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用表ID',
  `BLT_CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `BLT_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '添加时间',
  `BLT_MODIFY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BLT_TABLE`(`BLT_TABLE_NAME`, `BLT_TABLE_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SC_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置列表ID',
  `SM_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `SM_PARENTID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '父权限ID',
  `SM_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限编码',
  `SM_URL` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问URL',
  `SM_URL_PARAMS` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问URL所带的参数',
  `SM_CLASSICON` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'icon图片class',
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程大类',
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程小类',
  `SM_IS_LEAF` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是叶节点',
  `SM_IS_EXPAND` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否默认张开节点',
  `SM_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型:1管理员 2会员',
  `SM_ORDER` int(5) NULL DEFAULT NULL COMMENT '排序号',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SM_PARENTID`(`SM_PARENTID`) USING BTREE,
  INDEX `SM_CODE`(`SM_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '', '系统管理', '0', 'SYSTEM', '', '', 'mdi mdi-laptop', '', '', '1', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('13358417838080', '3316994321416192', '操作员管理', '1', 'SYSTEM:OPERATOR', 'admin/dataGrid/', '', 'mdi mdi-account-group', NULL, NULL, '0', '', '1', 7, 1);
INSERT INTO `sys_menu` VALUES ('1427690443767808', '', '编辑', '2', 'SYSTEM:MENU_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('1448716162564096', '', '编辑', '3', 'SYSTEM:BUTTON_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('1451155909509120', '2910894828814336', '字典管理', '1', 'SYSTEM:DICT_TYPE', 'admin/dataGrid/', '', 'mdi mdi-zip-box', NULL, NULL, '0', '', '1', 5, 1);
INSERT INTO `sys_menu` VALUES ('1560059138015232', '', '编辑', '8', 'SYSTEM:CONFIGURE_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('162322471645609984', '162321745234100224', '时间控制', '26579469829406720', 'SYSTEM:PROCESS_TIME_CONTROL', 'admin/dataGrid/', '', '', '', '', '0', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('1757509987598336', '1758638922268672', '设置字段', '8', 'SYSTEM:CONFIGURE_SET_COLUMN', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('1846593582006272', '', '编辑', '1757509987598336', 'SYSTEM:CONFIGURE_SET_COLUMN_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2', '2997414705233920', '菜单管理', '1', 'SYSTEM:MENU', 'admin/dataGrid/', NULL, 'mdi mdi-menu', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('20766815625936896', '20764730981351424', '组', '7', 'SYSTEM:VALIDATE_GROUP', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '0', '1', 4, 1);
INSERT INTO `sys_menu` VALUES ('21130604443598848', '', '系统配置', '1', 'SYSTEM:ALLOCATION', '', NULL, 'mdi mdi-settings', NULL, NULL, '1', '', '1', 99, 1);
INSERT INTO `sys_menu` VALUES ('21131205961318400', '', '邮箱管理', '21130604443598848', 'SYSTEM:ALLOCATION_EMAIL', 'admin/allocation/email', NULL, 'mdi mdi-email-secure', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2163592187084800', '1870969903775744', '设置搜索', '8', 'SYSTEM:CONFIGURE_SET_SEARCH', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('2163861868249088', '', '编辑', '2163592187084800', 'SYSTEM:CONFIGURE_SET_SEARCH_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2258672239509504', '', '编辑', '7', 'SYSTEM:VALIDATE_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('2258969972178944', '2265709233045504', '设置字段', '7', 'SYSTEM:VALIDATE_SET_FIELD', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('2269941063483392', '2268726246244352', '正则管理', '7', 'SYSTEM:VALIDATE_REGEX', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('23657888534757376', '', '文件上传测试', '21130604443598848', '', 'admin/allocation/fileInputTest', NULL, '', NULL, NULL, '0', '', '1', 90, 1);
INSERT INTO `sys_menu` VALUES ('26476504758091776', '26491587483664384', '格式管理', '1', 'SYSTEM:FORMAT', 'admin/dataGrid/', '', 'mdi mdi-format-align-left', NULL, NULL, '0', '', '1', 8, 1);
INSERT INTO `sys_menu` VALUES ('26511186237325312', '', '编辑', '26476504758091776', 'SYSTEM:FORMAT_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26571410583322624', '26568354160443392', '格式详细', '26476504758091776', 'SYSTEM:FORMAT_DETAIL', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('26571551922978816', '', '编辑', '26571410583322624', 'SYSTEM:FORMAT_DETAIL_UPDATE', '', '', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26577007949119488', '', '流程管理', '1', 'SYSTEM:PROCESS', '', '', 'mdi mdi-stack-overflow', NULL, NULL, '1', '', '1', 9, 1);
INSERT INTO `sys_menu` VALUES ('26577844645658624', '26721805670547456', '流程定义', '26577007949119488', 'SYSTEM:PROCESS_DEFINITION', 'admin/dataGrid/', '', 'mdi mdi-book-open', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26579469829406720', '', '标签列表', '26577844645658624', 'SYSTEM:PROCESS_DEFINITION_TABS', 'admin/tabs', 'SF_CODE=SYS_PROCESS_DEFINITION', '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('26714856669315072', '27187947212111872', '流程步骤', '26579469829406720', 'SYSTEM:PROCESS_STEP', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('26715728707059712', '27999782165282816', '启动角色', '26579469829406720', 'SYSTEM:PROCESS_START', 'admin/dataGrid/', '', '', NULL, NULL, '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('26845813934129152', '', '流程定义', '26579469829406720', 'SYSTEM:PROCESS_DEFINITION_UPDATE', 'admin/process/definition/update', '', '', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('28019952082485248', '28020396255084544', '测试流程', '21130604443598848', '', 'admin/dataGrid/', '', '', '1001', '2001', '0', '', '1', 91, 1);
INSERT INTO `sys_menu` VALUES ('2910350022279168', '2912701923721216', '字典信息', '1451155909509120', 'SYSTEM:DICTINFO', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '1', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('3', '2', '按钮管理', '1', 'SYSTEM:BUTTON', 'admin/dataGrid/', NULL, 'mdi mdi-equal-box', NULL, NULL, '0', NULL, '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('33081241360138240', '33080508233547776', '流程进度', '26577007949119488', 'SYSTEM:PROCESS_SCHEDULE', 'admin/dataGrid/', '', 'mdi mdi-stack-overflow', NULL, NULL, '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('3316536806735872', '', '编辑', '13358417838080', 'SYSTEM:OPERATOR_UPDATE', '', NULL, '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('3547951557246976', '3545555946962944', '账户管理', '13358417838080', 'SYSTEM:OPERATOR_SUB', 'admin/dataGrid/', NULL, '', NULL, NULL, '0', '', '1', 2, 1);
INSERT INTO `sys_menu` VALUES ('4103758959083520', '', '编辑', '9', 'SYSTEM:ROLE_UPDATE', '', NULL, '', NULL, NULL, '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('52184510715920384', '', '日志管理', '0', 'LOG', '', '', 'mdi mdi-note-multiple-outline', '', '', '1', '', '1', 999, 1);
INSERT INTO `sys_menu` VALUES ('52184511034687488', '52185393809850368', '系统日志', '52184510715920384', 'LOG:SYSTEM', 'admin/dataGrid/', '', 'mdi mdi-laptop-windows', '', '', '0', '', '1', 10, 1);
INSERT INTO `sys_menu` VALUES ('52235853056966656', '52235707715944448', '操作日志', '52184510715920384', 'LOG:USE', 'admin/dataGrid/', '', 'mdi mdi-developer-board', '', '', '0', '', '1', 20, 1);
INSERT INTO `sys_menu` VALUES ('52235902763663360', '52235788951224320', '登录日志', '52184510715920384', 'LOG:PERSONAL', 'admin/dataGrid/', '', 'mdi mdi-login', '', '', '0', '', '1', 30, 1);
INSERT INTO `sys_menu` VALUES ('52259024812376064', '52258927902982144', '查看日志', '52184510715920384', 'LOG:SEE', 'admin/dataGrid/', '', 'mdi mdi-eye', '', '', '0', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('53389170629935104', '53384301168820224', '数据变动记录', '52184510715920384', 'LOG:VALUE_RECORD', 'admin/dataGrid/', '', 'mdi mdi-locker-multiple', '', '', '0', '', '1', 50, 1);
INSERT INTO `sys_menu` VALUES ('53604331076714496', '53604023634231296', '详细', '53389170629935104', 'LOG:VALUE_RECORD_DETAIL', 'admin/dataGrid/', '', 'mdi mdi-locker-multiple', '', '', '0', '', '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('58409755399421952', '58409949016883200', '设置文件', '8', 'SYSTEM:CONFIGURE_SET_FILE', 'admin/dataGrid/', '', '', '', '', '0', '', '1', 40, 1);
INSERT INTO `sys_menu` VALUES ('58409755873378304', '', '编辑', '58409755399421952', 'SYSTEM:CONFIGURE_SET_FILE_UPDATE', '', NULL, '', NULL, NULL, '0', NULL, '1', 1, 1);
INSERT INTO `sys_menu` VALUES ('7', '2244279544053760', '验证管理', '1', 'SYSTEM:VALIDATE', 'admin/dataGrid/', NULL, 'mdi mdi-security', NULL, NULL, '0', NULL, '1', 3, 1);
INSERT INTO `sys_menu` VALUES ('8', '1', '配置列表管理', '1', 'SYSTEM:CONFIGURE', 'admin/dataGrid/', NULL, 'mdi mdi-view-list', NULL, NULL, '0', NULL, '1', 4, 1);
INSERT INTO `sys_menu` VALUES ('9', '3', '角色管理', '1', 'SYSTEM:ROLE', 'admin/dataGrid/', NULL, 'mdi mdi-account-settings-variant', NULL, NULL, '0', '', '1', 6, 1);

-- ----------------------------
-- Table structure for sys_menu_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_button`;
CREATE TABLE `sys_menu_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单表主键',
  `SB_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SM_ID`(`SM_ID`) USING BTREE,
  INDEX `SB_ID`(`SB_ID`) USING BTREE,
  CONSTRAINT `SB_ID` FOREIGN KEY (`SB_ID`) REFERENCES `sys_button` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SM_ID` FOREIGN KEY (`SM_ID`) REFERENCES `sys_menu` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu_button
-- ----------------------------
INSERT INTO `sys_menu_button` VALUES ('1', '3', '1');
INSERT INTO `sys_menu_button` VALUES ('1426649660784640', '2', '1');
INSERT INTO `sys_menu_button` VALUES ('1426649727893504', '2', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1426649765642240', '2', '794877562454016');
INSERT INTO `sys_menu_button` VALUES ('1426649815973888', '2', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1435359447613440', '1427690443767808', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('1435533670612992', '9', '1');
INSERT INTO `sys_menu_button` VALUES ('1435533712556032', '9', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1435533750304768', '9', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1448614282919936', '3', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1448614316474368', '3', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1448749549223936', '1448716162564096', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('1559887930720256', '8', '1');
INSERT INTO `sys_menu_button` VALUES ('1559888014606336', '8', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1559888035577856', '8', '795961550962688');
INSERT INTO `sys_menu_button` VALUES ('1559888056549376', '8', '795677957292032');
INSERT INTO `sys_menu_button` VALUES ('1559888085909504', '8', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1560095188058112', '1560059138015232', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('162322471666581504', '162322471645609984', '1');
INSERT INTO `sys_menu_button` VALUES ('162322471674970112', '162322471645609984', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('162322471679164416', '162322471645609984', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1757606397870080', '1757509987598336', '1');
INSERT INTO `sys_menu_button` VALUES ('1757606435618816', '1757509987598336', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('1757606464978944', '1757509987598336', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('1795406350516224', '1757509987598336', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('1847340797263872', '1846593582006272', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2', '9', '1007779779182592');
INSERT INTO `sys_menu_button` VALUES ('20698011151630336', '1451155909509120', '2819607190568960');
INSERT INTO `sys_menu_button` VALUES ('20704668854255616', '2258969972178944', '20703880723562496');
INSERT INTO `sys_menu_button` VALUES ('20766942985977856', '20766815625936896', '1');
INSERT INTO `sys_menu_button` VALUES ('20766943011143680', '20766815625936896', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('20766943027920896', '20766815625936896', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('20766943048892416', '20766815625936896', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('21131452464758784', '21131205961318400', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('21135896183046144', '21131205961318400', '2819607190568960');
INSERT INTO `sys_menu_button` VALUES ('2163726220263424', '2163592187084800', '1');
INSERT INTO `sys_menu_button` VALUES ('2163726237040640', '2163592187084800', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2163726249623552', '2163592187084800', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2163726262206464', '2163592187084800', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2163929136496640', '2163861868249088', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2258511178235904', '7', '1');
INSERT INTO `sys_menu_button` VALUES ('2258511203401728', '7', '2256636777332736');
INSERT INTO `sys_menu_button` VALUES ('2258511224373248', '7', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2258511241150464', '7', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2258725221957632', '2258672239509504', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('2259066357284864', '2258969972178944', '1');
INSERT INTO `sys_menu_button` VALUES ('2259066378256384', '2258969972178944', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2259066395033600', '2258969972178944', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2259066411810816', '2258969972178944', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2261093145640960', '7', '2261000862564352');
INSERT INTO `sys_menu_button` VALUES ('2270520498192384', '2269941063483392', '1');
INSERT INTO `sys_menu_button` VALUES ('2270520523358208', '2269941063483392', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2270520540135424', '2269941063483392', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2270520561106944', '2269941063483392', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('26507165615259648', '26476504758091776', '2824289539588096');
INSERT INTO `sys_menu_button` VALUES ('26507165661396992', '26476504758091776', '1');
INSERT INTO `sys_menu_button` VALUES ('26507165686562816', '26476504758091776', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26507165707534336', '26476504758091776', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26511240272543744', '26511186237325312', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('26571609242337280', '26571410583322624', '1');
INSERT INTO `sys_menu_button` VALUES ('26571609292668928', '26571410583322624', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26571609343000576', '26571410583322624', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26571626401234944', '26571551922978816', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('26574787094511616', '26571410583322624', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('26715842821488640', '26714856669315072', '1');
INSERT INTO `sys_menu_button` VALUES ('26715842855043072', '26714856669315072', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26715842876014592', '26714856669315072', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26715911536771072', '26715728707059712', '1');
INSERT INTO `sys_menu_button` VALUES ('26715911570325504', '26715728707059712', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('26715911599685632', '26715728707059712', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26724486367674368', '26577844645658624', '1');
INSERT INTO `sys_menu_button` VALUES ('26724486392840192', '26577844645658624', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('26846437945901056', '26845813934129152', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('28178037900050432', '28019952082485248', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('28283745773551616', '13358417838080', '28283426524102656');
INSERT INTO `sys_menu_button` VALUES ('2910422617292800', '2910350022279168', '1');
INSERT INTO `sys_menu_button` VALUES ('2910422659235840', '2910350022279168', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2910422688595968', '2910350022279168', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('2910422717956096', '2910350022279168', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('2910508327895040', '1451155909509120', '2824289539588096');
INSERT INTO `sys_menu_button` VALUES ('2910508369838080', '1451155909509120', '1');
INSERT INTO `sys_menu_button` VALUES ('2910508411781120', '1451155909509120', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('2910508449529856', '1451155909509120', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('3008720116121600', '13358417838080', '1');
INSERT INTO `sys_menu_button` VALUES ('3008720158064640', '13358417838080', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('3008720174841856', '13358417838080', '3008659554566144');
INSERT INTO `sys_menu_button` VALUES ('3008720187424768', '13358417838080', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('33081904680927232', '33081241360138240', '33081849764904960');
INSERT INTO `sys_menu_button` VALUES ('3316580893065216', '3316536806735872', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('33328711105249280', '33081241360138240', '33267466964566016');
INSERT INTO `sys_menu_button` VALUES ('3375940465852416', '13358417838080', '3375831514611712');
INSERT INTO `sys_menu_button` VALUES ('3548048869294080', '3547951557246976', '1');
INSERT INTO `sys_menu_button` VALUES ('3548048898654208', '3547951557246976', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('3548048915431424', '3547951557246976', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('4086872657625088', '3547951557246976', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('4103794426118144', '4103758959083520', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('50800621128777728', '2', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('50800669417799680', '26577844645658624', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('50800699251884032', '8', '50800567487823872');
INSERT INTO `sys_menu_button` VALUES ('53389614437629952', '53389170629935104', '53380929225228288');
INSERT INTO `sys_menu_button` VALUES ('53604331198349312', '53604331076714496', '53380929225228288');
INSERT INTO `sys_menu_button` VALUES ('53606571434835968', '53604331076714496', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('58409755542028288', '58409755399421952', '1795360737460224');
INSERT INTO `sys_menu_button` VALUES ('58409755575582720', '58409755399421952', '1');
INSERT INTO `sys_menu_button` VALUES ('58409755600748544', '58409755399421952', '793562643955712');
INSERT INTO `sys_menu_button` VALUES ('58409755617525760', '58409755399421952', '793777245519872');
INSERT INTO `sys_menu_button` VALUES ('58409756192145408', '58409755873378304', '763206804963328');
INSERT INTO `sys_menu_button` VALUES ('58418586376470528', '8', '58407294232166400');

-- ----------------------------
-- Table structure for sys_operator
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator`;
CREATE TABLE `sys_operator`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_PASSWORD` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `SO_SALT` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码加盐',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '状态 $SYS_ON_OFF$',
  `IS_DEFAULT_PWD` int(5) NULL DEFAULT 1 COMMENT '是否默认密码 1是 0 否',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_PASSWORD`(`SO_PASSWORD`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator
-- ----------------------------
INSERT INTO `sys_operator` VALUES ('1', '3060177a2cc22475a8b9c0be4d6ba6f3', 'fdb.4Q', 1, 0);

-- ----------------------------
-- Table structure for sys_operator_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_role`;
CREATE TABLE `sys_operator_role`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色表id',
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主表id',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE,
  CONSTRAINT `SO_ID` FOREIGN KEY (`SO_ID`) REFERENCES `sys_operator` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator_role
-- ----------------------------
INSERT INTO `sys_operator_role` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for sys_operator_sub
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_sub`;
CREATE TABLE `sys_operator_sub`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员 @SYS_ACCOUNT_INFO,SO_ID,SAI_NAME@',
  `SOS_USERNAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `SOS_CREATETIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SOS_REMARK` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `SOS_DEFAULT` int(1) NULL DEFAULT NULL COMMENT '是否默认账户 $SYS_YES_NO$',
  `IS_STATUS` int(1) NULL DEFAULT NULL COMMENT '状态  $SYS_ON_OFF$',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `KIM_OPERATORSUB_SO`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operator_sub
-- ----------------------------
INSERT INTO `sys_operator_sub` VALUES ('1', '1', 'admin', '2018-3-22 15:06:46', '超级管理员', 1, 1);
INSERT INTO `sys_operator_sub` VALUES ('28282832660987904', '1', '超级管理员', '2018-06-11 17:19:42', '', 0, 1);

-- ----------------------------
-- Table structure for sys_process_definition
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_definition`;
CREATE TABLE `sys_process_definition`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人@SYS_ACCOUNT_INFO,SO_ID,SAI_NAME@',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查看全部记录角色',
  `BUS_PROCESS` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程大类$SYS_PROCESS_TYPE$',
  `BUS_PROCESS2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程小类$SYS_PROCESS_TYPE$',
  `SPD_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程名称',
  `SPD_VERSION` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程版本',
  `SPD_UPDATE_TABLE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程更新表名',
  `SPD_UPDATE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程更新表名称字段',
  `SPD_COLLEGE_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '院系ID字段',
  `SPD_DEPARTMENT_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系部ID字段',
  `SPD_CLASS_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级ID字段',
  `SPD_DESCRIBE` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程描述',
  `SDP_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加时间',
  `IS_STATUS` int(1) NULL DEFAULT NULL COMMENT '是否启用$SYS_YES_NO$',
  `IS_MULTISTAGE_BACK` int(1) NULL DEFAULT NULL COMMENT '是否允许多级回退$SYS_YES_NO$',
  `IS_TIME_CONTROL` int(1) NULL DEFAULT NULL COMMENT '是否开启时间控制$SYS_YES_NO$',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `BUS_PROCESS`(`BUS_PROCESS`, `BUS_PROCESS2`) USING BTREE,
  INDEX `IS_STATUS`(`IS_STATUS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_log`;
CREATE TABLE `sys_process_log`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPS_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程进度表ID',
  `SPL_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表ID',
  `SPL_SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '办理人ID',
  `SPL_PROCESS_STATUS` int(5) NULL DEFAULT NULL COMMENT '流程办理状态',
  `SPL_TRANSACTOR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理人',
  `SPL_OPINION` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理意见',
  `SPL_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理时间',
  `SPL_TYPE` int(5) NULL DEFAULT NULL COMMENT '办理类型',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SP_LOG_ID`(`SPS_ID`) USING BTREE,
  INDEX `SPL_SO_ID`(`SPL_SO_ID`) USING BTREE,
  INDEX `SPL_TABLE_ID`(`SPL_TABLE_ID`) USING BTREE,
  CONSTRAINT `SP_LOG_ID` FOREIGN KEY (`SPS_ID`) REFERENCES `sys_process_schedule` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_schedule
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_schedule`;
CREATE TABLE `sys_process_schedule`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人ID',
  `SHOW_SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拥有查看权限的ID',
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义ID',
  `SPS_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前办理步骤ID',
  `SPS_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表ID',
  `SPS_TABLE_NAME` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程表名称',
  `SPS_AUDIT_STATUS` int(5) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `SPS_BACK_STATUS` int(5) NOT NULL DEFAULT 0 COMMENT '退回状态',
  `SPS_BACK_STATUS_TRANSACTOR` int(5) NULL DEFAULT NULL COMMENT '退回到的审核状态',
  `SPS_STEP_TYPE` int(5) NULL DEFAULT NULL COMMENT '当前办理步骤类型',
  `SPS_STEP_TRANSACTOR` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前办理步骤办理人',
  `SPS_PREV_AUDIT_STATUS` int(5) NULL DEFAULT NULL COMMENT '上一次流程审核状态',
  `SPS_PREV_STEP_TYPE` int(5) NULL DEFAULT NULL COMMENT '上一次办理步骤类型',
  `SPS_PREV_STEP_TRANSACTOR` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次办理步骤办理人',
  `SPS_PREV_STEP_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上一次办理步骤ID',
  `SPS_IS_CANCEL` int(5) NULL DEFAULT 0 COMMENT '是否作废',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SP_SCHEDULE_SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `SPS_STEP_TYPE_TRANSACTOR`(`SPS_STEP_TYPE`, `SPS_STEP_TRANSACTOR`) USING BTREE,
  INDEX `SHOW_SO_ID`(`SHOW_SO_ID`) USING BTREE,
  INDEX `SPS_TABLE_ID`(`SPS_TABLE_ID`) USING BTREE,
  INDEX `SPS_IS_CANCEL`(`SPS_IS_CANCEL`) USING BTREE,
  CONSTRAINT `SP_SCHEDULE_SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_schedule_cancel
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_schedule_cancel`;
CREATE TABLE `sys_process_schedule_cancel`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SPS_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程进度表',
  `SO_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作废人',
  `SPSC_REASON` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作废原因',
  `SPSC_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作废时间',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPS_ID`(`SPS_ID`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_start
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_start`;
CREATE TABLE `sys_process_start`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义表ID',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程启动角色',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `SR_ID`(`SPD_ID`, `SR_ID`) USING BTREE,
  CONSTRAINT `SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_step
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_step`;
CREATE TABLE `sys_process_step`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SPD_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程定义表ID',
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属办理角色',
  `SPS_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '步骤名称',
  `SPS_ORDER` int(5) NOT NULL COMMENT '步骤顺序',
  `SPS_STEP_TYPE` int(5) NOT NULL COMMENT '办理步骤类型',
  `SPS_PROCESS_STATUS` int(5) NOT NULL COMMENT '步骤流程状态',
  `SPS_IS_OVER_TIME` int(5) NULL DEFAULT NULL COMMENT '是否验证超时(开启后不填超时时间，默认为24小时 1440分钟)',
  `SPS_OVER_TIME` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '超时时间(分)',
  `SPS_IS_EDIT` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否无视状态编辑',
  `SPS_TAB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '步骤标记',
  `SPS_IS_ADVANCE_CHECK` int(5) NULL DEFAULT NULL COMMENT '是否前进校验',
  `SPS_IS_RETREAT_CHECK` int(5) NULL DEFAULT NULL COMMENT '是否退回校验',
  `SPS_IS_ADVANCE_EXECUTE` int(5) NULL DEFAULT NULL COMMENT '是否前进执行',
  `SPS_IS_RETREAT_EXECUTE` int(5) NULL DEFAULT NULL COMMENT '是否退回执行',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPS_SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `SPS_PROCESS_STATUS`(`SPS_PROCESS_STATUS`) USING BTREE,
  CONSTRAINT `SPS_SPD_ID` FOREIGN KEY (`SPD_ID`) REFERENCES `sys_process_definition` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_process_time_control
-- ----------------------------
DROP TABLE IF EXISTS `sys_process_time_control`;
CREATE TABLE `sys_process_time_control`  (
  `ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SPD_ID` char(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程定义ID',
  `SPTC_START_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '开始时间',
  `SPTC_END_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '结束时间',
  `SPTC_ENTRY_TIME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '录入时间',
  `IS_STATUS` int(1) NOT NULL COMMENT '是否启用$SYS_YES_NO$',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SPD_ID`(`SPD_ID`) USING BTREE,
  INDEX `IS_STATUS`(`IS_STATUS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `SR_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `SR_EXPLAIN` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色说明',
  `SR_REMARK` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色备注',
  `SR_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型:1管理员 2部门3系部4学生',
  `IS_STATUS` int(1) NULL DEFAULT NULL COMMENT '状态:0停用1启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SR_CODE`(`SR_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'ADMINISTRATOR', '超级管理员', '超级管理员', '1', 1);

-- ----------------------------
-- Table structure for sys_role_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_button`;
CREATE TABLE `sys_role_button`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SRM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色表主键',
  `SB_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SRM_ID`(`SRM_ID`) USING BTREE,
  INDEX `SB_ID`(`SB_ID`) USING BTREE,
  CONSTRAINT `KIM_SB_ID` FOREIGN KEY (`SB_ID`) REFERENCES `sys_button` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SRM_ID` FOREIGN KEY (`SRM_ID`) REFERENCES `sys_role_menu` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_button
-- ----------------------------
INSERT INTO `sys_role_button` VALUES ('1', '5', '1007779779182592');
INSERT INTO `sys_role_button` VALUES ('1388372232765440', '3', '1');
INSERT INTO `sys_role_button` VALUES ('1444749370195968', '1444740876730368', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1444787366395904', '5', '1');
INSERT INTO `sys_role_button` VALUES ('1444787391561728', '5', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1444787412533248', '5', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1444805708087296', '2', '1');
INSERT INTO `sys_role_button` VALUES ('1444805733253120', '2', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1444805750030336', '2', '794877562454016');
INSERT INTO `sys_role_button` VALUES ('1444805771001856', '2', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1450641524260864', '1450627603365888', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1555298946908160', '3', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1555298967879680', '3', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1560147998539776', '1560135797309440', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('1560163781705728', '4', '1');
INSERT INTO `sys_role_button` VALUES ('1560163815260160', '4', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1560163832037376', '4', '795961550962688');
INSERT INTO `sys_role_button` VALUES ('1560163853008896', '4', '795677957292032');
INSERT INTO `sys_role_button` VALUES ('1560163865591808', '4', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('162322814764843008', '162322803415056384', '1');
INSERT INTO `sys_role_button` VALUES ('162322814773231616', '162322803415056384', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('162322814773231617', '162322803415056384', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1759752866496512', '1759730993201152', '1');
INSERT INTO `sys_role_button` VALUES ('1759752900050944', '1759730993201152', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('1759752916828160', '1759730993201152', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('1795462185091072', '1759730993201152', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('1847371637981184', '1847264800669696', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('20698089362817024', '1452479145312256', '2819607190568960');
INSERT INTO `sys_role_button` VALUES ('20704410300579840', '1065899947720704', '20703880723562496');
INSERT INTO `sys_role_button` VALUES ('20704700147957760', '2259110124847104', '20703880723562496');
INSERT INTO `sys_role_button` VALUES ('20767354631749632', '20767326123065344', '1');
INSERT INTO `sys_role_button` VALUES ('20767354690469888', '20767326123065344', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('20767354703052800', '20767326123065344', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('20767354900185088', '20767326123065344', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('21131559075577856', '21131546849181696', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('21148886718480384', '21131546849181696', '2819607190568960');
INSERT INTO `sys_role_button` VALUES ('2163989190541312', '2163962472824832', '1');
INSERT INTO `sys_role_button` VALUES ('2163989207318528', '2163962472824832', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2163989219901440', '2163962472824832', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2163989228290048', '2163962472824832', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2163999428837376', '2163962489602048', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('2259135609438208', '1065899947720704', '1');
INSERT INTO `sys_role_button` VALUES ('2259135630409728', '1065899947720704', '2256636777332736');
INSERT INTO `sys_role_button` VALUES ('2259135642992640', '1065899947720704', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2259135655575552', '1065899947720704', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2259146627874816', '2259110296813568', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('2259165632266240', '2259110124847104', '1');
INSERT INTO `sys_role_button` VALUES ('2259165653237760', '2259110124847104', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2259165665820672', '2259110124847104', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2259165678403584', '2259110124847104', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2261127652179968', '1065899947720704', '2261000862564352');
INSERT INTO `sys_role_button` VALUES ('2270584817844224', '2270567050772480', '1');
INSERT INTO `sys_role_button` VALUES ('2270584838815744', '2270567050772480', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2270584855592960', '2270567050772480', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2270584868175872', '2270567050772480', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('26511328319373312', '26511298309128192', '2824289539588096');
INSERT INTO `sys_role_button` VALUES ('26511328365510656', '26511298309128192', '1');
INSERT INTO `sys_role_button` VALUES ('26511328394870784', '26511298309128192', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26511328428425216', '26511298309128192', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26511339627216896', '26511298258796544', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26571675722055680', '26571647033016320', '1');
INSERT INTO `sys_role_button` VALUES ('26571675826913280', '26571647033016320', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26571675847884800', '26571647033016320', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26571683259219968', '26571647079153664', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26716046983430144', '26716002301509632', '1');
INSERT INTO `sys_role_button` VALUES ('26716047012790272', '26716002301509632', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26716047033761792', '26716002301509632', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26716058782007296', '26716002242789376', '1');
INSERT INTO `sys_role_button` VALUES ('26716058807173120', '26716002242789376', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('26716058832338944', '26716002242789376', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26724642311897088', '26716002276343808', '1');
INSERT INTO `sys_role_button` VALUES ('26724642332868608', '26716002276343808', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('26846544095346688', '26846505239314432', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('26847391378309120', '26716002339258368', '1');
INSERT INTO `sys_role_button` VALUES ('26847391403474944', '26716002339258368', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('28178123719704576', '28022312963932160', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('28283813649973248', '1383066211713024', '28283426524102656');
INSERT INTO `sys_role_button` VALUES ('2914093807697920', '1452479145312256', '2824289539588096');
INSERT INTO `sys_role_button` VALUES ('2914093849640960', '1452479145312256', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2914093870612480', '1452479145312256', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2914828402294784', '2914068713177088', '1');
INSERT INTO `sys_role_button` VALUES ('2914828423266304', '2914068713177088', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('2914828444237824', '2914068713177088', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('2914828465209344', '2914068713177088', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('2915213791723520', '1452479145312256', '1');
INSERT INTO `sys_role_button` VALUES ('33082001623875584', '33081991280721920', '33081849764904960');
INSERT INTO `sys_role_button` VALUES ('3316636782166016', '3316626669699072', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('3316672232423424', '1383066211713024', '1');
INSERT INTO `sys_role_button` VALUES ('3316672257589248', '1383066211713024', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('3316672291143680', '1383066211713024', '3008659554566144');
INSERT INTO `sys_role_button` VALUES ('3316672316309504', '1383066211713024', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('33328765496983552', '33081991280721920', '33267466964566016');
INSERT INTO `sys_role_button` VALUES ('3375984820617216', '1383066211713024', '3375831514611712');
INSERT INTO `sys_role_button` VALUES ('4103843658858496', '4103830098673664', '763206804963328');
INSERT INTO `sys_role_button` VALUES ('4113066069327872', '4086505521807360', '1');
INSERT INTO `sys_role_button` VALUES ('4113066144825344', '4086505521807360', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('4113066157408256', '4086505521807360', '1795360737460224');
INSERT INTO `sys_role_button` VALUES ('4113072776019968', '4086505521807360', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('50800790012428288', '2', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('50800806047252480', '4', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('50800825278136320', '26716002276343808', '50800567487823872');
INSERT INTO `sys_role_button` VALUES ('53389665176125440', '53389571454402560', '53380929225228288');
INSERT INTO `sys_role_button` VALUES ('53606039618060288', '53606024011055104', '53380929225228288');
INSERT INTO `sys_role_button` VALUES ('58418757126586368', '4', '58407294232166400');
INSERT INTO `sys_role_button` VALUES ('58420310386409472', '58420263464730624', '1');
INSERT INTO `sys_role_button` VALUES ('58420310411575296', '58420263464730624', '793777245519872');
INSERT INTO `sys_role_button` VALUES ('58420310428352512', '58420263464730624', '793562643955712');
INSERT INTO `sys_role_button` VALUES ('58420318154260480', '58420272721559552', '763206804963328');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色表主键',
  `SM_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单表主键',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SR_ID`(`SR_ID`) USING BTREE,
  INDEX `SM_ID`(`SM_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('1065899947720704', '1', '7');
INSERT INTO `sys_role_menu` VALUES ('1383066211713024', '1', '13358417838080');
INSERT INTO `sys_role_menu` VALUES ('1444740876730368', '1', '1427690443767808');
INSERT INTO `sys_role_menu` VALUES ('1450627603365888', '1', '1448716162564096');
INSERT INTO `sys_role_menu` VALUES ('1452479145312256', '1', '1451155909509120');
INSERT INTO `sys_role_menu` VALUES ('1560135797309440', '1', '1560059138015232');
INSERT INTO `sys_role_menu` VALUES ('162322803415056384', '1', '162322471645609984');
INSERT INTO `sys_role_menu` VALUES ('1759730993201152', '1', '1757509987598336');
INSERT INTO `sys_role_menu` VALUES ('1847264800669696', '1', '1846593582006272');
INSERT INTO `sys_role_menu` VALUES ('2', '1', '2');
INSERT INTO `sys_role_menu` VALUES ('20767326123065344', '1', '20766815625936896');
INSERT INTO `sys_role_menu` VALUES ('21131546849181696', '1', '21131205961318400');
INSERT INTO `sys_role_menu` VALUES ('21131546899513344', '1', '21130604443598848');
INSERT INTO `sys_role_menu` VALUES ('2163962472824832', '1', '2163592187084800');
INSERT INTO `sys_role_menu` VALUES ('2163962489602048', '1', '2163861868249088');
INSERT INTO `sys_role_menu` VALUES ('2259110124847104', '1', '2258969972178944');
INSERT INTO `sys_role_menu` VALUES ('2259110296813568', '1', '2258672239509504');
INSERT INTO `sys_role_menu` VALUES ('2270567050772480', '1', '2269941063483392');
INSERT INTO `sys_role_menu` VALUES ('23657988535353344', '1', '23657888534757376');
INSERT INTO `sys_role_menu` VALUES ('26511298258796544', '1', '26511186237325312');
INSERT INTO `sys_role_menu` VALUES ('26511298309128192', '1', '26476504758091776');
INSERT INTO `sys_role_menu` VALUES ('26571647033016320', '1', '26571410583322624');
INSERT INTO `sys_role_menu` VALUES ('26571647079153664', '1', '26571551922978816');
INSERT INTO `sys_role_menu` VALUES ('26716002242789376', '1', '26715728707059712');
INSERT INTO `sys_role_menu` VALUES ('26716002276343808', '1', '26577844645658624');
INSERT INTO `sys_role_menu` VALUES ('26716002301509632', '1', '26714856669315072');
INSERT INTO `sys_role_menu` VALUES ('26716002318286848', '1', '26577007949119488');
INSERT INTO `sys_role_menu` VALUES ('26716002339258368', '1', '26579469829406720');
INSERT INTO `sys_role_menu` VALUES ('26846505239314432', '1', '26845813934129152');
INSERT INTO `sys_role_menu` VALUES ('28022312963932160', '1', '28019952082485248');
INSERT INTO `sys_role_menu` VALUES ('2914068713177088', '1', '2910350022279168');
INSERT INTO `sys_role_menu` VALUES ('3', '1', '3');
INSERT INTO `sys_role_menu` VALUES ('33081991280721920', '1', '33081241360138240');
INSERT INTO `sys_role_menu` VALUES ('3316626669699072', '1', '3316536806735872');
INSERT INTO `sys_role_menu` VALUES ('4', '1', '8');
INSERT INTO `sys_role_menu` VALUES ('4086505521807360', '1', '3547951557246976');
INSERT INTO `sys_role_menu` VALUES ('4103830098673664', '1', '4103758959083520');
INSERT INTO `sys_role_menu` VALUES ('5', '1', '9');
INSERT INTO `sys_role_menu` VALUES ('52230343104659456', '1', '52184511034687488');
INSERT INTO `sys_role_menu` VALUES ('52230343138213888', '1', '52184510715920384');
INSERT INTO `sys_role_menu` VALUES ('52236350467866624', '1', '52235902763663360');
INSERT INTO `sys_role_menu` VALUES ('52236350488838144', '1', '52235853056966656');
INSERT INTO `sys_role_menu` VALUES ('52259311908290560', '1', '52259024812376064');
INSERT INTO `sys_role_menu` VALUES ('53389571454402560', '1', '53389170629935104');
INSERT INTO `sys_role_menu` VALUES ('53606024011055104', '1', '53604331076714496');
INSERT INTO `sys_role_menu` VALUES ('58420263464730624', '1', '58409755399421952');
INSERT INTO `sys_role_menu` VALUES ('58420272721559552', '1', '58409755873378304');

-- ----------------------------
-- Table structure for sys_validate
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate`;
CREATE TABLE `sys_validate`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_TABLE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `IS_STATUS` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate
-- ----------------------------
INSERT INTO `sys_validate` VALUES ('21029210713751552', 'SYS_VALIDATE_GROUP', 1);
INSERT INTO `sys_validate` VALUES ('21138918841778176', 'SYS_ALLOCATION', 1);
INSERT INTO `sys_validate` VALUES ('2261226771972096', 'SYS_BUTTON', 1);
INSERT INTO `sys_validate` VALUES ('2508859939749888', 'SYS_MENU', 1);
INSERT INTO `sys_validate` VALUES ('2521910793469952', 'SYS_VALIDATE', 1);
INSERT INTO `sys_validate` VALUES ('2522562756083712', 'SYS_VALIDATE_FIELD', 1);
INSERT INTO `sys_validate` VALUES ('2526946793619456', 'SYS_VALIDATE_REGEX', 1);
INSERT INTO `sys_validate` VALUES ('2528928849723392', 'SYS_CONFIGURE', 1);
INSERT INTO `sys_validate` VALUES ('2529924065787904', 'SYS_CONFIGURE_COLUMN', 1);
INSERT INTO `sys_validate` VALUES ('2530699592597504', 'SYS_CONFIGURE_SEARCH', 1);
INSERT INTO `sys_validate` VALUES ('2531451308343296', 'SYS_ROLE', 1);
INSERT INTO `sys_validate` VALUES ('26503820167086080', 'SYS_FORMAT', 1);
INSERT INTO `sys_validate` VALUES ('26566331432173568', 'SYS_FORMAT_DETAIL', 1);
INSERT INTO `sys_validate` VALUES ('27200910899806208', 'SYS_PROCESS_DEFINITION', 1);
INSERT INTO `sys_validate` VALUES ('27201527949033472', 'SYS_PROCESS_STEP', 1);
INSERT INTO `sys_validate` VALUES ('27998590727094272', 'SYS_PROCESS_START', 1);
INSERT INTO `sys_validate` VALUES ('28616725398290432', 'SYS_PROCESS_LOG', 1);
INSERT INTO `sys_validate` VALUES ('28747238427590656', 'SYS_PROCESS_SCHEDULE', 1);
INSERT INTO `sys_validate` VALUES ('2916133099274240', 'SYS_DICT_TYPE', 1);
INSERT INTO `sys_validate` VALUES ('2916411848523776', 'SYS_DICT_INFO', 1);
INSERT INTO `sys_validate` VALUES ('33085808659398656', 'SYS_PROCESS_SCHEDULE_CANCEL', 1);
INSERT INTO `sys_validate` VALUES ('3318522176339968', 'SYS_OPERATOR_SUB', 1);
INSERT INTO `sys_validate` VALUES ('3318588060467200', 'SYS_ACCOUNT_INFO', 1);

-- ----------------------------
-- Table structure for sys_validate_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_field`;
CREATE TABLE `sys_validate_field`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVF_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `SVF_FIELD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询字段',
  `SVF_IS_REQUIRED` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填',
  `SVF_MIN_LENGTH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小字数',
  `SVF_MAX_LENGTH` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大字数',
  `SVF_MIN` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小值',
  `SVF_MAX` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大值',
  `SVR_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则表ID',
  `IS_STATUS` int(5) NULL DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SV_ID`(`SV_ID`) USING BTREE,
  CONSTRAINT `SV_ID` FOREIGN KEY (`SV_ID`) REFERENCES `sys_validate` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_field
-- ----------------------------
INSERT INTO `sys_validate_field` VALUES ('162312300483575808', '27200910899806208', '是否开启时间控制', 'IS_TIME_CONTROL', '1', '', '1', '', '', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('21029354062479360', '21029210713751552', 'SVG_GROUP', 'SVG_GROUP', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21029498875019264', '21029210713751552', 'SVF_IDS', 'SVF_IDS', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139099456897024', '21138918841778176', '邮箱登录名', 'EMAIL_USER', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139191005970432', '21138918841778176', '授权码', 'EMAIL_PASSWORD', '1', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21139245104103424', '21138918841778176', '服务器地址', 'EMAIL_HOST', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21384212485505024', '21138918841778176', '是否启用', 'EMAIL_STATUS', '1', '', '5', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21386284383600640', '21138918841778176', '端口', 'EMAIL_PORT', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('21388026127056896', '21138918841778176', '是否需要是否验证', 'EMAIL_AUTH', '1', '', '5', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21391241312731136', '21138918841778176', '邮件协议', 'EMAIL_PROTOCOL', '1', '', '10', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('21392401062952960', '21138918841778176', '是否开启SSL加密', 'EMAIL_SSL_ENABLE', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2275338709106688', '2261226771972096', '名称', 'SB_NAME', '1', '0', '50', NULL, NULL, NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2283799782096896', '2261226771972096', '类型', 'SB_TYPE', '1', '', '', NULL, NULL, NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2284187168014336', '2261226771972096', '按钮编码', 'SB_CODE', '1', '0', '50', NULL, NULL, NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2284278842916864', '2261226771972096', '排序', 'SB_ORDER', '1', '0', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2509555162415104', '2508859939749888', '名称', 'SM_NAME', '1', '0', '50', NULL, NULL, NULL, 1);
INSERT INTO `sys_validate_field` VALUES ('2509836394692608', '2508859939749888', '是否叶节点', 'SM_IS_LEAF', '1', '', '', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2509917319593984', '2508859939749888', '排序', 'SM_ORDER', '1', '0', '3', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2522152708341760', '2521910793469952', '表名', 'SV_TABLE', '1', '0', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2522646830907392', '2522562756083712', '名称', 'SVF_NAME', '1', '0', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2523512166154240', '2522562756083712', '字段', 'SVF_FIELD', '1', '0', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2523605007073280', '2522562756083712', '是否必填', 'SVF_IS_REQUIRED', '1', '', '', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2526757806669824', '2522562756083712', '最小字数', 'SVF_MIN_LENGTH', '0', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2526823703379968', '2522562756083712', '最大字数', 'SVF_MAX_LENGTH', '0', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2527028670627840', '2526946793619456', '名称', 'SVR_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2527090947653632', '2526946793619456', '正则', 'SVR_REGEX', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2527138645278720', '2526946793619456', '错误消息', 'SVR_REGEX_MESSAGE', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529121548632064', '2528928849723392', '配置列表名称', 'SC_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529161222553600', '2528928849723392', '数据库视图', 'SC_VIEW', '1', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529220509040640', '2528928849723392', '是否开启选择', 'SC_IS_SELECT', '0', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529305837961216', '2528928849723392', '是否单选', 'SC_IS_SINGLE', '0', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529387081629696', '2528928849723392', '是否分页', 'SC_IS_PAGING', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2529446250676224', '2528928849723392', 'SQL排序语句', 'SC_ORDER_BY', '0', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2529506808037376', '2528928849723392', 'JSP地址', 'SC_JSP', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530084942512128', '2529924065787904', '配置列表ID', 'SC_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530165498314752', '2529924065787904', '列名称', 'SCC_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530226936479744', '2529924065787904', '查询字段', 'SCC_FIELD', '0', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530327943708672', '2529924065787904', '对齐方式', 'SCC_ALIGN', '1', '', '20', NULL, NULL, '2522924040847360', 1);
INSERT INTO `sys_validate_field` VALUES ('2530484034732032', '2529924065787904', '是否是操作列', 'SCC_IS_OPERATION', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530534089555968', '2529924065787904', '是否是状态列', 'SCC_IS_STATUS', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530574363262976', '2529924065787904', '是否显示', 'SCC_IS_VISIBLE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530632055914496', '2529924065787904', '排序', 'SCC_ORDER', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2530737945313280', '2530699592597504', 'SC_ID', 'SC_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530839686545408', '2530699592597504', '搜索名称', 'SCS_NAME', '1', '', '8', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530922150756352', '2530699592597504', '查询字段', 'SCS_FIELD', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2530985086287872', '2530699592597504', '类型', 'SCS_TYPE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531053218562048', '2530699592597504', '查询条件', 'SCS_METHOD_TYPE', '1', '', '10', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531114551869440', '2530699592597504', '是否显示', 'SCC_IS_VISIBLE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531171363717120', '2530699592597504', '排序', 'SCS_ORDER', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2531530102538240', '2531451308343296', '角色名称', 'SR_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531589791678464', '2531451308343296', '角色编码', 'SR_CODE', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2531699913129984', '2531451308343296', '类型', 'SR_TYPE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('26472994477965312', '2508859939749888', 'URL参数', 'SM_URL_PARAMS', '0', '', '500', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26473054355849216', '2508859939749888', 'URL', 'SM_URL', '0', '', '400', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26504332669091840', '26503820167086080', '格式名称', 'SF_NAME', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26504411106770944', '26503820167086080', '格式唯一标识', 'SF_CODE', '1', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26505027984031744', '26503820167086080', '格式配置年份', 'SF_YEAR', '1', '', '', NULL, NULL, '26504926733533184', 1);
INSERT INTO `sys_validate_field` VALUES ('26566384259432448', '26566331432173568', 'SF_ID', 'SF_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26566459090010112', '26566331432173568', '格式详细名称', 'SFD_NAME', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('26566500777197568', '26566331432173568', '排序', 'SFD_ORDER', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27200992088948736', '27200910899806208', '流程名称', 'SPD_NAME', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201053149626368', '27200910899806208', '流程版本', 'SPD_VERSION', '0', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201123957866496', '27200910899806208', '流程更新表名', 'SPD_UPDATE_TABLE', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201243331952640', '27200910899806208', '流程更新表名称字段', 'SPD_UPDATE_NAME', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201479626457088', '27200910899806208', '流程描述', 'SPD_DESCRIBE', '0', '', '1000', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201590989422592', '27201527949033472', 'SPD_ID', 'SPD_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201667204120576', '27201527949033472', '办理角色', 'SR_ID', '0', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201721864290304', '27201527949033472', '步骤名称', 'SPS_NAME', '1', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27201770279141376', '27201527949033472', '步骤顺序', 'SPS_ORDER', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201841963991040', '27201527949033472', '办理类型', 'SPS_STEP_TYPE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201911572660224', '27201527949033472', '步骤流程状态', 'SPS_PROCESS_STATUS', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27201968753606656', '27201527949033472', '是否验证超时', 'SPS_IS_OVER_TIME', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202034717425664', '27201527949033472', '超时时间(分)', 'SPS_OVER_TIME', '0', '', '10', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202084369596416', '27201527949033472', '步骤标记', 'SPS_TAB', '0', '', '200', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27202130062344192', '27201527949033472', '是否前进校验', 'SPS_IS_ADVANCE_CHECK', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202181903941632', '27201527949033472', '是否退回校验', 'SPS_IS_RETREAT_CHECK', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202572817268736', '27201527949033472', '是否前进执行', 'SPS_IS_ADVANCE_EXECUTE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27202624684032000', '27201527949033472', '是否退回执行', 'SPS_IS_RETREAT_EXECUTE', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('27998641947934720', '27998590727094272', 'SPD_ID', 'SPD_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('27998700735299584', '27998590727094272', 'SR_ID', 'SR_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('28616835968532480', '28616725398290432', '办理意见', 'SPL_OPINION', '1', '', '500', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('28617469597843456', '28616725398290432', '流程办理表主键', 'SPS_TABLE_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('28617524367065088', '28616725398290432', '流程主键', 'SPD_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('28747316554891264', '28747238427590656', '下一步办理人', 'SPS_STEP_TRANSACTOR', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('28747488475217920', '28747238427590656', '办理类型', 'PROCESS_TYPE', '1', '', '', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('2916293984387072', '2916133099274240', '字典名称', 'SDT_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916339882655744', '2916133099274240', '字典编码', 'SDT_CODE', '1', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916502218997760', '2916411848523776', 'SDT_ID', 'SDT_ID', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916564244365312', '2916411848523776', '名称', 'SDI_NAME', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916608112590848', '2916411848523776', '编码', 'SDI_CODE', '1', '', '50', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916655382396928', '2916411848523776', '连接编码', 'SDI_INNERCODE', '1', '', '100', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('2916793802817536', '2916411848523776', '排序', 'SDI_ORDER', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('29363176130740224', '27200910899806208', '是否多级退回', 'IS_MULTISTAGE_BACK', '1', '', '1', '', '', '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('3002802230001664', '2508859939749888', '是否开启搜索', 'SC_IS_SEARCH', '1', '', '5', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('33085871934668800', '33085808659398656', '作废原因', 'SPSC_REASON', '1', '', '1500', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('3318806332047360', '3318522176339968', '登录账号', 'SOS_USERNAME', '1', '2', '18', NULL, NULL, '2523171857104896', 1);
INSERT INTO `sys_validate_field` VALUES ('3318901077180416', '3318522176339968', '用户类型', 'SOS_USERTYPE', '1', '', '1', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('3319050180493312', '3318588060467200', '姓名', 'SAI_NAME', '1', '', '50', NULL, NULL, '2523171857104896', 1);
INSERT INTO `sys_validate_field` VALUES ('3319111320862720', '3318588060467200', '手机', 'SAI_PHONE', '0', '', '', NULL, NULL, '2511317080473600', 1);
INSERT INTO `sys_validate_field` VALUES ('3319156837449728', '3318588060467200', '邮箱', 'SAI_EMAIL', '0', '', '', NULL, NULL, '2511177288515584', 1);
INSERT INTO `sys_validate_field` VALUES ('49300118259630080', '27200910899806208', '流程大类', 'BUS_PROCESS', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('49300156033531904', '27200910899806208', '流程小类', 'BUS_PROCESS2', '1', '', '', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('50327099268923392', '21138918841778176', '德育', 'EDUCATION_PROPORTION', '1', '', '2', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50327147201429504', '21138918841778176', '智育', 'INTELLECTUAL_PROPORTION', '1', '', '2', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50327192726405120', '21138918841778176', '志愿者', 'VOLUNTEER_PROPORTION', '1', '', '2', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50329904402661376', '21138918841778176', '迟到几节课算旷课', 'LATE_PROPORTION', '1', '', '2', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('50329946148569088', '21138918841778176', '旷课几节课算处分', 'ABSENTEEISM_PROPORTION', '1', '', '2', NULL, NULL, '2510375538917376', 1);
INSERT INTO `sys_validate_field` VALUES ('55012379414495232', '2529924065787904', '是否固定列', 'SCC_IS_FIXED', '1', '', '5', NULL, NULL, '', 1);
INSERT INTO `sys_validate_field` VALUES ('56600620911558656', '2522562756083712', '最小值', 'SVF_MIN', '0', '', '50', '', '', '2511687219412992', 1);
INSERT INTO `sys_validate_field` VALUES ('56600674829336576', '2522562756083712', '最大值', 'SVF_MAX', '0', '', '50', '', '', '2511687219412992', 1);

-- ----------------------------
-- Table structure for sys_validate_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_group`;
CREATE TABLE `sys_validate_group`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SV_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVG_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组名称',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SV_ID`(`SV_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_group
-- ----------------------------
INSERT INTO `sys_validate_group` VALUES ('21060492420186112', '21029210713751552', 'TEST1');
INSERT INTO `sys_validate_group` VALUES ('21060515270754304', '21029210713751552', 'TEST2');
INSERT INTO `sys_validate_group` VALUES ('21062378720329728', '21029210713751552', 'ALL');

-- ----------------------------
-- Table structure for sys_validate_group_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_group_field`;
CREATE TABLE `sys_validate_group_field`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SVG_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVF_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SVG_ID`(`SVG_ID`) USING BTREE,
  INDEX `SVF_ID`(`SVF_ID`) USING BTREE,
  CONSTRAINT `SVF_ID` FOREIGN KEY (`SVF_ID`) REFERENCES `sys_validate_field` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SVG_ID` FOREIGN KEY (`SVG_ID`) REFERENCES `sys_validate_group` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_group_field
-- ----------------------------
INSERT INTO `sys_validate_group_field` VALUES ('21060492462129152', '21060492420186112', '21029354062479360');
INSERT INTO `sys_validate_group_field` VALUES ('21060515321085952', '21060515270754304', '21029498875019264');
INSERT INTO `sys_validate_group_field` VALUES ('21065605595529216', '21062378720329728', '21029354062479360');
INSERT INTO `sys_validate_group_field` VALUES ('21065605637472256', '21062378720329728', '21029498875019264');

-- ----------------------------
-- Table structure for sys_validate_regex
-- ----------------------------
DROP TABLE IF EXISTS `sys_validate_regex`;
CREATE TABLE `sys_validate_regex`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SVR_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SVR_REGEX` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则表达式',
  `SVR_REGEX_MESSAGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正则错误提示',
  `IS_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_validate_regex
-- ----------------------------
INSERT INTO `sys_validate_regex` VALUES ('2510375538917376', '整数', '^-?\\d+$', '请输入整数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2510375538917377', '正整数', '^\\d+$', '请输入正整数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2510890322624512', '中文', '[\\u4e00-\\u9fa5]', '只能输入中文!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511177288515584', '邮箱', '\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}', '请输入正确的邮箱!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511317080473600', '手机', '0?(13|14|15|17|18)[0-9]{9}', '请输入正确的手机号码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511430095994880', '固定电话', '[0-9-()（）]{7,18}', '请输入正确的固定电话!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511687219412992', '浮点数', '^(-?\\d+)(\\.\\d+)?$', '请输入正确的带小数点的数字!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511798490103808', 'QQ号', '[1-9]([0-9]{5,11})', '请输入正确的QQ号!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2511926852583424', '邮政编码', '\\d{6}', '请输入正确的邮政编码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512132734189568', 'IP', '(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)', '请输入正确的IP地址!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512257846083584', '身份证', '^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$', '请输入正确的身份证号码!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512496095133696', '年月日日期', '\\d{4}(\\-|\\\\/|.)\\d{1,2}\\1\\d{1,2}', '请输入正确的日期(如1970-01-01)!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2512815759818752', '用户名', '[A-Za-z0-9_\\-\\u4e00-\\u9fa5]+', '请输入正确的用户名(支持的标点符号-、_)', '1');
INSERT INTO `sys_validate_regex` VALUES ('2521757806231552', '正浮点数', '^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$', '请输入正确的带小数点的正数!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2522924040847360', '英文字母', '^[a-zA-Z]+$', '只能输入a-z的英文字母!', '1');
INSERT INTO `sys_validate_regex` VALUES ('2523171857104896', '匹配中文，英文字母和数字及_', '^[\\u4e00-\\u9fa5_a-zA-Z0-9]+$', '只能输入中文、英文字母、数字、_', '1');
INSERT INTO `sys_validate_regex` VALUES ('26504926733533184', '年份', '^(19\\d\\d|20\\d\\d|2100|20\\d\\d-20\\d\\d)$', '请输入正确的年份!', '1');
INSERT INTO `sys_validate_regex` VALUES ('55916414480941056', '年月日日期(无下划线)', '\\d{4}(\\\\/|.)\\d{1,2}\\d{1,2}', '请输入正确的日期(如19700101)!', '1');
INSERT INTO `sys_validate_regex` VALUES ('62630865301143552', '月', '^(0?[1-9]|1[0-2])$', '月份错误!', '1');

-- ----------------------------
-- Table structure for sys_value_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_value_record`;
CREATE TABLE `sys_value_record`  (
  `ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SO_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人ID',
  `SVR_TABLE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录表名',
  `SVR_TABLE_ID` char(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录表ID',
  `SVR_OLD_VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '旧值',
  `SVR_NEW_VALUE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '新值',
  `SVR_ENTRY_TIME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `SVR_TYPE` int(5) NULL DEFAULT NULL COMMENT '类型，1插入2更新3删除',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `SVR_TABLE`(`SVR_TABLE_NAME`, `SVR_TABLE_ID`) USING BTREE,
  INDEX `SVR_TYPE`(`SVR_TYPE`) USING BTREE,
  INDEX `SO_ID`(`SO_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for v_button
-- ----------------------------
DROP VIEW IF EXISTS `v_button`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_button` AS select `sb`.`ID` AS `ID`,`sb`.`SB_NAME` AS `SB_NAME`,`sb`.`SB_BUTTONID` AS `SB_BUTTONID`,`sb`.`SB_ICON` AS `SB_ICON`,`sb`.`SB_CODE` AS `SB_CODE`,`sb`.`SB_ORDER` AS `SB_ORDER`,`sb`.`SB_TYPE` AS `SB_TYPE`,`sdi`.`SDI_NAME` AS `SB_TYPE_NAME` from (`sys_button` `sb` left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'SYS_BUTTON_TYPE') and (`sdi`.`SDI_CODE` = `sb`.`SB_TYPE`))));

-- ----------------------------
-- View structure for v_configure
-- ----------------------------
DROP VIEW IF EXISTS `v_configure`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure` AS select `sc`.`ID` AS `ID`,`sc`.`SC_NAME` AS `SC_NAME`,`sc`.`SC_JSP` AS `SC_JSP`,`sc`.`SC_VIEW` AS `SC_VIEW` from `sys_configure` `sc`;

-- ----------------------------
-- View structure for v_configure_column
-- ----------------------------
DROP VIEW IF EXISTS `v_configure_column`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure_column` AS select `scc`.`ID` AS `ID`,`scc`.`SC_ID` AS `SC_ID`,`scc`.`SCC_NAME` AS `SCC_NAME`,`scc`.`SCC_FIELD` AS `SCC_FIELD`,`scc`.`SCC_ALIGN` AS `SCC_ALIGN`,`scc`.`SCC_WIDTH` AS `SCC_WIDTH`,`scc`.`SCC_SDT_CODE` AS `SCC_SDT_CODE`,`scc`.`SCC_IS_OPERATION` AS `SCC_IS_OPERATION`,`scc`.`SCC_IS_VISIBLE` AS `SCC_IS_VISIBLE`,`scc`.`SCC_IS_STATUS` AS `SCC_IS_STATUS`,`scc`.`SCC_ORDER` AS `SCC_ORDER`,`scc`.`SCC_IS_FIXED` AS `SCC_IS_FIXED`,`scc`.`SCC_IS_EXPORT` AS `SCC_IS_EXPORT` from `sys_configure_column` `scc`;

-- ----------------------------
-- View structure for v_configure_file
-- ----------------------------
DROP VIEW IF EXISTS `v_configure_file`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure_file` AS select `scf`.`ID` AS `ID`,`scf`.`SC_ID` AS `SC_ID`,`scf`.`SCF_NAME` AS `SCF_NAME`,`scf`.`IS_STATUS` AS `IS_STATUS`,`scf`.`SCF_ENTRY_TIME` AS `SCF_ENTRY_TIME`,`sc`.`SC_NAME` AS `SC_NAME` from (`sys_configure_file` `scf` join `sys_configure` `sc` on((convert(`sc`.`ID` using utf8mb4) = `scf`.`SC_ID`)));

-- ----------------------------
-- View structure for v_configure_search
-- ----------------------------
DROP VIEW IF EXISTS `v_configure_search`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_configure_search` AS select `scs`.`ID` AS `ID`,`scs`.`SC_ID` AS `SC_ID`,`scs`.`SCS_NAME` AS `SCS_NAME`,`scs`.`SCS_FIELD` AS `SCS_FIELD`,`scs`.`SCS_SDT_CODE` AS `SCS_SDT_CODE`,`scs`.`SCS_METHOD_TYPE` AS `SCS_METHOD_TYPE`,`scs`.`SCS_TYPE` AS `SCS_TYPE`,`scs`.`SCC_IS_VISIBLE` AS `SCC_IS_VISIBLE`,`scs`.`SCS_ORDER` AS `SCS_ORDER`,`scs`.`SCS_REMARK` AS `SCS_REMARK` from `sys_configure_search` `scs`;

-- ----------------------------
-- View structure for v_dict_info
-- ----------------------------
DROP VIEW IF EXISTS `v_dict_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dict_info` AS select `sdi`.`ID` AS `ID`,`sdi`.`SDT_ID` AS `SDT_ID`,`sdi`.`SDT_CODE` AS `SDT_CODE`,`sdi`.`SDI_NAME` AS `SDI_NAME`,`sdi`.`SDI_CODE` AS `SDI_CODE`,`sdi`.`SDI_INNERCODE` AS `SDI_INNERCODE`,`sdi`.`SDI_PARENTID` AS `SDI_PARENTID`,`sdi`.`SDI_IS_LEAF` AS `SDI_IS_LEAF`,`sdi`.`SDI_REMARK` AS `SDI_REMARK`,`sdi`.`SDI_REQUIRED` AS `SDI_REQUIRED`,`sdi`.`SDI_ORDER` AS `SDI_ORDER`,`sdi`.`IS_STATUS` AS `IS_STATUS` from `sys_dict_info` `sdi`;

-- ----------------------------
-- View structure for v_dict_type
-- ----------------------------
DROP VIEW IF EXISTS `v_dict_type`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dict_type` AS select `sdt`.`ID` AS `ID`,`sdt`.`SDT_NAME` AS `SDT_NAME`,`sdt`.`SDT_CODE` AS `SDT_CODE`,`sdt`.`IS_STATUS` AS `IS_STATUS` from `sys_dict_type` `sdt`;

-- ----------------------------
-- View structure for v_format
-- ----------------------------
DROP VIEW IF EXISTS `v_format`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_format` AS select `sf`.`ID` AS `ID`,`sf`.`SF_NAME` AS `SF_NAME`,`sf`.`SF_CODE` AS `SF_CODE`,`sf`.`SF_YEAR` AS `SF_YEAR`,`sf`.`SF_ENTRY_TIME` AS `SF_ENTRY_TIME` from `sys_format` `sf`;

-- ----------------------------
-- View structure for v_format_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_format_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_format_detail` AS select `sfd`.`ID` AS `ID`,`sfd`.`SF_ID` AS `SF_ID`,`sfd`.`SM_ID` AS `SM_ID`,`sfd`.`SFD_PARENT_ID` AS `SFD_PARENT_ID`,`sfd`.`SFD_NAME` AS `SFD_NAME`,`sfd`.`SFD_ORDER` AS `SFD_ORDER`,`sfd`.`IS_STATUS` AS `IS_STATUS`,`sm`.`SM_NAME` AS `SM_NAME` from (`sys_format_detail` `sfd` left join `sys_menu` `sm` on((convert(`sm`.`ID` using utf8mb4) = `sfd`.`SM_ID`)));

-- ----------------------------
-- View structure for v_log_personal
-- ----------------------------
DROP VIEW IF EXISTS `v_log_personal`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_personal` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 9);

-- ----------------------------
-- View structure for v_log_see
-- ----------------------------
DROP VIEW IF EXISTS `v_log_see`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_see` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 0);

-- ----------------------------
-- View structure for v_log_system
-- ----------------------------
DROP VIEW IF EXISTS `v_log_system`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_system` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 1);

-- ----------------------------
-- View structure for v_log_use
-- ----------------------------
DROP VIEW IF EXISTS `v_log_use`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_use` AS select `sl`.`ID` AS `ID`,`sl`.`SO_ID` AS `SO_ID`,`sl`.`SL_NAME` AS `SL_NAME`,`sl`.`SL_EVENT` AS `SL_EVENT`,`sl`.`SL_IP` AS `SL_IP`,`sl`.`SL_RESULT` AS `SL_RESULT`,`sl`.`SL_ENTERTIME` AS `SL_ENTERTIME`,`sl`.`SL_ENTERTIME` AS `SL_ENDTIME`,`slt`.`SLT_CONTENT` AS `SLT_CONTENT`,`sai`.`SAI_NAME` AS `SAI_NAME` from ((`sys_log` `sl` left join `sys_log_text` `slt` on((`slt`.`SL_ID` = `sl`.`ID`))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sl`.`SO_ID`))) where (`sl`.`SL_TYPE` = 2);

-- ----------------------------
-- View structure for v_log_value_record
-- ----------------------------
DROP VIEW IF EXISTS `v_log_value_record`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_value_record` AS select `svrc`.`SVR_TABLE_ID` AS `ID`,`svrc`.`SVR_TABLE_ID` AS `SVR_TABLE`,`svrc`.`SVR_TABLE_NAME` AS `SVR_TABLE_NAME`,`svrc`.`SVR_ENTRY_TIME` AS `SVR_ENTRY_TIME`,`svrc`.`SVR_ENTRY_TIME` AS `SVR_END_TIME`,`svrc`.`SO_ID` AS `SO_ID`,`svrc`.`SVR_TYPE` AS `SVR_TYPE`,`svrc`.`SVR_OLD_VALUE` AS `SVR_OLD_VALUE`,`svrc`.`SVR_NEW_VALUE` AS `SVR_NEW_VALUE`,`sai`.`SAI_NAME` AS `SAI_NAME` from (((select `svr`.`SVR_TABLE_ID` AS `SVR_TABLE_ID`,`svr`.`SVR_TABLE_NAME` AS `SVR_TABLE_NAME`,max(`svr`.`SVR_ENTRY_TIME`) AS `SVR_ENTRY_TIME` from `sys_value_record` `svr` group by `svr`.`SVR_TABLE_NAME`,`svr`.`SVR_TABLE_ID`) `svr` join `sys_value_record` `svrc` on(((`svrc`.`SVR_TABLE_ID` = `svr`.`SVR_TABLE_ID`) and (`svrc`.`SVR_TABLE_NAME` = `svr`.`SVR_TABLE_NAME`) and (`svrc`.`SVR_ENTRY_TIME` = `svr`.`SVR_ENTRY_TIME`)))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `svrc`.`SO_ID`)));

-- ----------------------------
-- View structure for v_log_value_record_detail
-- ----------------------------
DROP VIEW IF EXISTS `v_log_value_record_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_log_value_record_detail` AS select `svr`.`ID` AS `ID`,`svr`.`SO_ID` AS `SO_ID`,`svr`.`SVR_TABLE_NAME` AS `SVR_TABLE_NAME`,`svr`.`SVR_TABLE_ID` AS `SVR_TABLE_ID`,`svr`.`SVR_OLD_VALUE` AS `SVR_OLD_VALUE`,`svr`.`SVR_NEW_VALUE` AS `SVR_NEW_VALUE`,`svr`.`SVR_ENTRY_TIME` AS `SVR_ENTRY_TIME`,`svr`.`SVR_TYPE` AS `SVR_TYPE`,`sai`.`SAI_NAME` AS `SAI_NAME` from (`sys_value_record` `svr` left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `svr`.`SO_ID`)));

-- ----------------------------
-- View structure for v_menu
-- ----------------------------
DROP VIEW IF EXISTS `v_menu`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_menu` AS select `sm`.`ID` AS `ID`,`sm`.`SC_ID` AS `SC_ID`,`sm`.`SM_NAME` AS `SM_NAME`,`sm`.`SM_PARENTID` AS `SM_PARENTID`,`sm`.`SM_CODE` AS `SM_CODE`,`sm`.`SM_URL` AS `SM_URL`,`sm`.`SM_CLASSICON` AS `SM_CLASSICON`,`sm`.`SM_IS_LEAF` AS `SM_IS_LEAF`,`sm`.`SM_IS_EXPAND` AS `SM_IS_EXPAND`,`sm`.`SM_TYPE` AS `SM_TYPE`,`sm`.`SM_ORDER` AS `SM_ORDER`,`sm`.`IS_STATUS` AS `IS_STATUS`,`sc`.`SC_NAME` AS `SC_NAME` from (`sys_menu` `sm` left join `sys_configure` `sc` on((`sc`.`ID` = `sm`.`SC_ID`)));

-- ----------------------------
-- View structure for v_operator
-- ----------------------------
DROP VIEW IF EXISTS `v_operator`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_operator` AS select `so`.`ID` AS `ID`,`so`.`IS_STATUS` AS `IS_STATUS`,`sai`.`SAI_NAME` AS `SAI_NAME`,`sai`.`SAI_PHONE` AS `SAI_PHONE`,`sai`.`SAI_EMAIL` AS `SAI_EMAIL`,`sos`.`SOS_USERNAME` AS `SOS_USERNAME`,`sai`.`SAI_TYPE` AS `SAI_TYPE`,`tdi`.`SDI_NAME` AS `SAI_TYPE_NAME` from (((`sys_operator` `so` join `sys_account_info` `sai` on((`sai`.`SO_ID` = `so`.`ID`))) left join (select `sos`.`SO_ID` AS `SO_ID`,group_concat(distinct `sos`.`SOS_USERNAME` separator ',') AS `SOS_USERNAME` from `sys_operator_sub` `sos` group by `sos`.`SO_ID`) `sos` on((`sos`.`SO_ID` = `so`.`ID`))) left join `sys_dict_info` `tdi` on(((`tdi`.`SDT_CODE` = 'SYS_ROLE_TYPE') and (`tdi`.`SDI_CODE` = `sai`.`SAI_TYPE`))));

-- ----------------------------
-- View structure for v_operator_sub
-- ----------------------------
DROP VIEW IF EXISTS `v_operator_sub`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_operator_sub` AS select `sos`.`ID` AS `ID`,`sos`.`SO_ID` AS `SO_ID`,`sos`.`SOS_USERNAME` AS `SOS_USERNAME`,`sos`.`SOS_CREATETIME` AS `SOS_CREATETIME`,`sos`.`SOS_REMARK` AS `SOS_REMARK`,`sos`.`SOS_DEFAULT` AS `SOS_DEFAULT`,`sos`.`IS_STATUS` AS `IS_STATUS` from `sys_operator_sub` `sos`;

-- ----------------------------
-- View structure for v_process_definition
-- ----------------------------
DROP VIEW IF EXISTS `v_process_definition`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_definition` AS select `spd`.`ID` AS `ID`,`spd`.`SO_ID` AS `SO_ID`,`spd`.`SR_ID` AS `SR_ID`,`spd`.`BUS_PROCESS` AS `BUS_PROCESS`,`spd`.`BUS_PROCESS2` AS `BUS_PROCESS2`,`spd`.`SPD_NAME` AS `SPD_NAME`,`spd`.`SPD_VERSION` AS `SPD_VERSION`,`spd`.`SPD_UPDATE_TABLE` AS `SPD_UPDATE_TABLE`,`spd`.`SPD_UPDATE_NAME` AS `SPD_UPDATE_NAME`,`spd`.`SPD_COLLEGE_FIELD` AS `SPD_COLLEGE_FIELD`,`spd`.`SPD_DEPARTMENT_FIELD` AS `SPD_DEPARTMENT_FIELD`,`spd`.`SPD_CLASS_FIELD` AS `SPD_CLASS_FIELD`,`spd`.`SPD_DESCRIBE` AS `SPD_DESCRIBE`,`spd`.`SDP_ENTRY_TIME` AS `SDP_ENTRY_TIME`,`spd`.`IS_STATUS` AS `IS_STATUS`,`spd`.`IS_MULTISTAGE_BACK` AS `IS_MULTISTAGE_BACK`,`spd`.`IS_TIME_CONTROL` AS `IS_TIME_CONTROL`,(case when (`spd`.`IS_TIME_CONTROL` = 1) then concat(`sptc`.`SPTC_START_TIME`,'  -  ',`sptc`.`SPTC_END_TIME`) else '' end) AS `SPTC_TIME` from (`sys_process_definition` `spd` left join `sys_process_time_control` `sptc` on(((`sptc`.`SPD_ID` = convert(`spd`.`ID` using utf8mb4)) and (`sptc`.`IS_STATUS` = 1))));

-- ----------------------------
-- View structure for v_process_schedule
-- ----------------------------
DROP VIEW IF EXISTS `v_process_schedule`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_schedule` AS select `sps`.`ID` AS `ID`,`sps`.`SO_ID` AS `SO_ID`,`sps`.`SHOW_SO_ID` AS `SHOW_SO_ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SPS_ID` AS `SPS_ID`,`sps`.`SPS_TABLE_ID` AS `SPS_TABLE_ID`,`sps`.`SPS_TABLE_NAME` AS `SPS_TABLE_NAME`,`sps`.`SPS_AUDIT_STATUS` AS `SPS_AUDIT_STATUS`,`sps`.`SPS_BACK_STATUS` AS `SPS_BACK_STATUS`,`sps`.`SPS_BACK_STATUS_TRANSACTOR` AS `SPS_BACK_STATUS_TRANSACTOR`,`sps`.`SPS_STEP_TYPE` AS `SPS_STEP_TYPE`,`sps`.`SPS_STEP_TRANSACTOR` AS `SPS_STEP_TRANSACTOR`,`sps`.`SPS_PREV_AUDIT_STATUS` AS `SPS_PREV_AUDIT_STATUS`,`sps`.`SPS_PREV_STEP_TYPE` AS `SPS_PREV_STEP_TYPE`,`sps`.`SPS_PREV_STEP_TRANSACTOR` AS `SPS_PREV_STEP_TRANSACTOR`,`sps`.`SPS_PREV_STEP_ID` AS `SPS_PREV_STEP_ID`,`sps`.`SPS_IS_CANCEL` AS `SPS_IS_CANCEL`,`spd`.`SPD_NAME` AS `SPD_NAME`,`sai`.`SAI_NAME` AS `INITIATOR_NAME`,`saic`.`SAI_NAME` AS `CANCEL_NAME`,`spsc`.`ID` AS `SPSC_ID`,`spsc`.`SPSC_REASON` AS `SPSC_REASON`,`spsc`.`SPSC_ENTRY_TIME` AS `SPSC_ENTRY_TIME`,`sdi`.`SDI_NAME` AS `PROCESS_STATUS_NAME`,`spt`.`SPS_NAME` AS `STEP_NAME` from ((((((`sys_process_schedule` `sps` left join `sys_process_step` `spt` on((`spt`.`ID` = `sps`.`SPS_ID`))) left join `sys_process_definition` `spd` on((`spd`.`ID` = `sps`.`SPD_ID`))) left join `sys_process_schedule_cancel` `spsc` on((`spsc`.`SPS_ID` = convert(`sps`.`ID` using utf8mb4)))) left join `sys_account_info` `sai` on((`sai`.`SO_ID` = `sps`.`SO_ID`))) left join `sys_account_info` `saic` on((convert(`saic`.`SO_ID` using utf8mb4) = `spsc`.`SO_ID`))) left join `sys_dict_info` `sdi` on(((`sdi`.`SDT_CODE` = 'SYS_PROCESS_STATUS') and (`sdi`.`SDI_CODE` = `sps`.`SPS_AUDIT_STATUS`))));

-- ----------------------------
-- View structure for v_process_start
-- ----------------------------
DROP VIEW IF EXISTS `v_process_start`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_start` AS select `sps`.`ID` AS `ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SR_ID` AS `SR_ID`,`sr`.`SR_NAME` AS `SR_NAME`,`sr`.`SR_CODE` AS `SR_CODE` from (`sys_process_start` `sps` left join `sys_role` `sr` on((`sr`.`ID` = `sps`.`SR_ID`)));

-- ----------------------------
-- View structure for v_process_step
-- ----------------------------
DROP VIEW IF EXISTS `v_process_step`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_step` AS select `sps`.`ID` AS `ID`,`sps`.`SPD_ID` AS `SPD_ID`,`sps`.`SR_ID` AS `SR_ID`,`sps`.`SPS_NAME` AS `SPS_NAME`,`sps`.`SPS_ORDER` AS `SPS_ORDER`,`sps`.`SPS_STEP_TYPE` AS `SPS_STEP_TYPE`,`sps`.`SPS_PROCESS_STATUS` AS `SPS_PROCESS_STATUS`,`sps`.`SPS_IS_OVER_TIME` AS `SPS_IS_OVER_TIME`,`sps`.`SPS_OVER_TIME` AS `SPS_OVER_TIME`,`sps`.`SPS_TAB` AS `SPS_TAB`,`sps`.`SPS_IS_ADVANCE_CHECK` AS `SPS_IS_ADVANCE_CHECK`,`sps`.`SPS_IS_RETREAT_CHECK` AS `SPS_IS_RETREAT_CHECK`,`sps`.`SPS_IS_ADVANCE_EXECUTE` AS `SPS_IS_ADVANCE_EXECUTE`,`sps`.`SPS_IS_RETREAT_EXECUTE` AS `SPS_IS_RETREAT_EXECUTE`,`sr`.`SR_NAME` AS `SR_NAME` from (`sys_process_step` `sps` left join `sys_role` `sr` on((`sr`.`ID` = `sps`.`SR_ID`)));

-- ----------------------------
-- View structure for v_process_time_control
-- ----------------------------
DROP VIEW IF EXISTS `v_process_time_control`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_process_time_control` AS select `sptc`.`ID` AS `ID`,`sptc`.`SPD_ID` AS `SPD_ID`,`sptc`.`SPTC_START_TIME` AS `SPTC_START_TIME`,`sptc`.`SPTC_END_TIME` AS `SPTC_END_TIME`,`sptc`.`SPTC_ENTRY_TIME` AS `SPTC_ENTRY_TIME`,`sptc`.`IS_STATUS` AS `IS_STATUS` from `sys_process_time_control` `sptc`;

-- ----------------------------
-- View structure for v_role
-- ----------------------------
DROP VIEW IF EXISTS `v_role`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_role` AS select `sr`.`ID` AS `ID`,`sr`.`SR_TYPE` AS `SR_TYPE`,`sr`.`SR_CODE` AS `SR_CODE`,`sr`.`SR_NAME` AS `SR_NAME`,`sr`.`SR_EXPLAIN` AS `SR_EXPLAIN`,`sr`.`SR_REMARK` AS `SR_REMARK`,`sr`.`IS_STATUS` AS `IS_STATUS` from `sys_role` `sr`;

-- ----------------------------
-- View structure for v_validate
-- ----------------------------
DROP VIEW IF EXISTS `v_validate`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate` AS select `sv`.`ID` AS `ID`,`sv`.`SV_TABLE` AS `SV_TABLE`,`sv`.`IS_STATUS` AS `IS_STATUS` from `sys_validate` `sv`;

-- ----------------------------
-- View structure for v_validate_field
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_field`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_field` AS select `svf`.`ID` AS `ID`,`svf`.`SV_ID` AS `SV_ID`,`svf`.`SVF_NAME` AS `SVF_NAME`,`svf`.`SVF_FIELD` AS `SVF_FIELD`,`svf`.`SVF_IS_REQUIRED` AS `SVF_IS_REQUIRED`,`svf`.`SVF_MIN_LENGTH` AS `SVF_MIN_LENGTH`,`svf`.`SVF_MAX_LENGTH` AS `SVF_MAX_LENGTH`,`svf`.`SVR_ID` AS `SVR_ID`,`svf`.`IS_STATUS` AS `IS_STATUS`,`svr`.`SVR_NAME` AS `SVR_NAME`,`svg`.`SVG_GROUPS` AS `SVG_GROUPS` from ((`sys_validate_field` `svf` left join `sys_validate_regex` `svr` on((`svr`.`ID` = `svf`.`SVR_ID`))) left join (select `svgf`.`SVF_ID` AS `SVF_ID`,group_concat(`svg`.`SVG_GROUP` order by cast(`svg`.`ID` as signed) ASC separator ',') AS `SVG_GROUPS` from (`sys_validate_group` `svg` join `sys_validate_group_field` `svgf` on((`svgf`.`SVG_ID` = `svg`.`ID`))) group by `svg`.`SV_ID`,`svgf`.`SVF_ID` order by cast(`svg`.`ID` as signed)) `svg` on((`svf`.`ID` = `svg`.`SVF_ID`)));

-- ----------------------------
-- View structure for v_validate_group
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_group`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_group` AS select `svg`.`ID` AS `ID`,`svg`.`SV_ID` AS `SV_ID`,`svg`.`SVG_GROUP` AS `SVG_GROUP`,`svgf`.`SVF_NAMES` AS `SVF_NAMES` from (`sys_validate_group` `svg` left join (select `svgf`.`SVG_ID` AS `SVG_ID`,group_concat(`svf`.`SVF_NAME` separator ',') AS `SVF_NAMES` from (`sys_validate_group_field` `svgf` join `sys_validate_field` `svf` on((`svf`.`ID` = `svgf`.`SVF_ID`))) group by `svgf`.`SVG_ID`) `svgf` on((`svgf`.`SVG_ID` = `svg`.`ID`)));

-- ----------------------------
-- View structure for v_validate_regex
-- ----------------------------
DROP VIEW IF EXISTS `v_validate_regex`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_validate_regex` AS select `svr`.`ID` AS `ID`,`svr`.`SVR_NAME` AS `SVR_NAME`,`svr`.`SVR_REGEX` AS `SVR_REGEX`,`svr`.`SVR_REGEX_MESSAGE` AS `SVR_REGEX_MESSAGE`,`svr`.`IS_STATUS` AS `IS_STATUS` from `sys_validate_regex` `svr`;

SET FOREIGN_KEY_CHECKS = 1;
