/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : examination

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 14/06/2019 22:13:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`  (
  `id` int(2) NULL DEFAULT NULL COMMENT '试卷号',
  `time` int(10) NULL DEFAULT NULL COMMENT '考试时间',
  `qty_sing` int(2) NULL DEFAULT NULL COMMENT '单选题数量',
  `qty_muti` int(2) NULL DEFAULT NULL COMMENT '多选题数量',
  `qty_jud` int(2) NULL DEFAULT NULL COMMENT '判断题数量',
  `qty_fill` int(2) NULL DEFAULT NULL COMMENT '填空题数量',
  `qty_ess` int(2) NULL DEFAULT NULL COMMENT '简答题数量',
  `quantity` int(3) NULL DEFAULT NULL COMMENT '总题目数量'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES (1, 30, 5, 4, 5, 5, 3, 22);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `number` varchar(8) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '题目序号',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '题目类型',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '题目标题',
  `select` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '题目选项',
  `score` float NOT NULL COMMENT '题目分值',
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '题目答案/关键词',
  `img` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '题目配图',
  PRIMARY KEY (`number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('11', '单选题', '正午时分让太阳光垂直照射一个当中有小孔的黑纸板，接收屏上出现一个小圆斑；测量小圆斑的直径和黑纸板到接收屏的距离，可大致推出太阳直径。他掌握的数据是：太阳光传到地球所需的时间、地球的公转周期、万有引力恒量；在最终得出太阳密度的过程中，他用到的物理规律是小孔成像规律和', '牛顿第二定律@万有引力定律@万有引力定律、牛顿第二定律@万有引力定律、牛顿第三定律', 3, 'C', 'wl1.png');
INSERT INTO `question` VALUES ('12', '多选题', '球从A处自由摆下，到最低点C时摆线碰到悬点O\n正下方的钉子B，B是OC的中点，则球经过C的瞬间：', '线速度不变；@角速度加倍；@角速度减半；@绳的拉力加倍.', 5, 'AB', 'wl12.png');
INSERT INTO `question` VALUES ('13', '单选题', '如右图所示，光滑的水平桌面上有一弹簧振子，弹簧的劲度系数为k.开始时，振子被拉到平衡位置O的右侧A处，此时拉力大小为F，然后轻轻释放振子，振子从初速度为零的状态开始向左运动，经过时间t后第一次到达平衡位置O处，此时振子的速度为v，则在这个过程中振子的平均速度为(　　)', '0@v/2@F/(kt)@不为零的某值，但由题设条件无法求出', 3, 'C', 'wl13.png');
INSERT INTO `question` VALUES ('14', '单选题', '如图所示，质量为m的物体从半径为R的半球形碗边向碗底滑动，滑到最低点时的速度为v 。若物体滑到最低点时受到的摩擦力是f，则物体与碗的动摩擦因数为  （     ）', 'Ffmg@Ffmg＋mv2R@Ffmg－mv2R@Ffmv2R', 3, 'B', 'wl14.png');
INSERT INTO `question` VALUES ('15', '单选题', '当你在单杆上做引体向上时，完成一次引体向上动作，估算你消耗的能量最接近的是', '50J@300J@1000J@3000J', 3, 'B', '');
INSERT INTO `question` VALUES ('16', '多选题', '水滴自高处由静止开始下落，至落地前的过程中遇到水平方向吹来的风，则（    ）', '风速越大，水滴下落的时间越长@风速越大，水滴落地时的瞬时速度越大@水滴着地时的瞬时速度与风速无关@水滴下落的时间与风速无关', 5, 'BD', '');
INSERT INTO `question` VALUES ('17', '多选题', '两个质量不同的小球，被长度不等的细线悬挂在同一点，并在同一水平面内作匀速圆周运动，如图所示。则两个小球的：  （     ）', '运动周期相等@运动线速度相等@运动角速度相等@向心加速度相等', 5, 'AC', 'wl15.png');
INSERT INTO `question` VALUES ('18', '单选题', '关于匀速圆周运动,下列说法中正确的是(     )', '线速度的方向保持不变@线速度的大小保持不变@角速度大小不断变化@线速度和角速度都保持不变', 3, 'B', '');
INSERT INTO `question` VALUES ('19', '多选题', '甲、乙、丙三小球分别位于如图所示的竖直平面内，甲、乙在同一条竖直线上，甲、丙在同一条水平线上，水平面上的P点在丙的正下方，在同一时刻甲、乙、丙开始运动，甲以水平速度v0平抛，乙以水平速度v0沿水平面向右做匀速直线运动，丙做自由落体运动．则（       ）', '若甲、乙、丙三球同时相遇，则一定发生在P点@若甲、丙二球在空中相遇，此时乙球一定在P点@若只有甲、乙二球在水平面上相遇，此时丙球还未着地@无论初速度v0大小如何，甲、乙、丙三球一定会同时在P点相遇', 5, 'AB', 'wl19.png');
INSERT INTO `question` VALUES ('20', '多选题', '铁路转弯处的弯道半径r是根据地形决定的．弯道处要求外轨比内轨高，其内外轨高度差h的设计不仅与r有关，还与火车在弯道上的行驶速率v有关．下面正确的是（  ）', 'v一定时，r越小则要求h越大@v一定时，r越大则要求h越大@r一定时，v越小则要求h越大@r一定时，v越大则要求h越大', 5, 'AD', '');
INSERT INTO `question` VALUES ('21', '填空题', '设宇宙射线粒子的能量是其静止能量的k倍．则粒子运动时的质量等于其静止质量的（ ）倍', '', 3, 'k', '');
INSERT INTO `question` VALUES ('22', '填空题', '质量为60kg的人，不慎从高空支架上跌落。由于弹性安全带的保护，使他悬挂在空中。已知安全带长5米，其缓冲时间为1.5秒，则安全带受到的平均冲力为___________________。', '', 3, '1000N', '');
INSERT INTO `question` VALUES ('23', '填空题', '在天然放射现象中放出的三种射线，射线均来源于      ', '', 3, '原子核', '');
INSERT INTO `question` VALUES ('24', '填空题', '如图，一辆质量为4kg的小车以速度2m/s在光滑水平面上运动，一质量为1kg速度为10m/s的物体以俯角为600的方向落到车上并埋在车里的砂中，此时小车的速度为　　　　 。', '', 3, '2.6m/s', 'wl24.png');
INSERT INTO `question` VALUES ('25', '填空题', '甲、乙两辆完全一样的小车处于光滑水平面上，质量都是M，乙车内用绳吊一质量为0.5M的小球。当乙车静止时，甲车以速度v与乙车相碰，碰后连为一体，则刚碰后瞬间两车的共同速度为______________。', '', 3, 'v/2', 'wl25.jpg');
INSERT INTO `question` VALUES ('26', '判断题', '爱因斯坦提出光是一种电磁波；', '', 4, '错', '');
INSERT INTO `question` VALUES ('27', '判断题', '光的偏振现象说明光是横波；', '', 4, '对', '');
INSERT INTO `question` VALUES ('28', '判断题', '在α、β、γ这三种射线中，γ射线的穿透能力最强，α射线的电离能力最强', '', 4, '对', '');
INSERT INTO `question` VALUES ('29', '判断题', '一单摆做简谐运动，摆球相继两次通过同一位置时的速度必相同', '', 4, '错', '');
INSERT INTO `question` VALUES ('30', '判断题', '相对论认为：真空中的光速在不同惯性参照系中都是相同的。', '', 4, '对', '');
INSERT INTO `question` VALUES ('41', '简答题', '简述历史上的原子结构模型。', '', 10, '道尔顿实心球模型@汤姆逊枣糕模型@卢瑟福行星模型@玻尔量子化轨道@现代电子云模型', '');
INSERT INTO `question` VALUES ('42', '简答题', '爱因斯坦在量子论的早期做出了什么样的贡献？', '', 10, '普朗克量子理论@光量子理论@解释光电效应', '');
INSERT INTO `question` VALUES ('43', '简答题', '简述量子力学的两大派别', '', 10, '德布罗意@物质波@波函数@薛定谔波动方程@海森伯@矩阵力学@玻恩@力学算符表示法', '');
INSERT INTO `question` VALUES ('44', '简答题', '狭义相对论的两个基本假设是什么？', '', 10, '相对性原理@光速不变原理', '');
INSERT INTO `question` VALUES ('45', '简答题', '广义相对论的三大验证是什么？', '', 10, '水星轨道近日点的反常进动问题@强引力场@时钟@慢@光线在引力场中偏转', '');
INSERT INTO `question` VALUES ('46', '单选题', '下列说法正确的是(   )', '某一声波从空气射入水中，其声波的波长将变大@机械波与电磁波都可在真空中传播@机械波在介质中传播一个周期的时间内，波上的质点沿波的传播方向平移一个波长@电磁波和机械波都能发生干涉、衍射现象和多普勒效应，但都不能发生偏振现象', 3, 'A', '');
INSERT INTO `question` VALUES ('47', '多选题', '振动系统的固有频率为f0，在周期性驱动力的作用下做受迫振动，驱动力的频率为f.若驱动力的振幅保持不变，下列说法正确的是', '当f＜f0时，该振动系统的振幅随f增大而减小@当f＞f0时，该振动系统的振幅随f减小而增大@该振动系统的振动稳定后，振动的频率等于f0@该振动系统的振动稳定后，振动的频率等于f', 5, 'BD', '');
INSERT INTO `question` VALUES ('48', '单选题', '关于竖直放置的肥皂液形成的薄膜干涉，下述说法中不正确的是(      )', '干涉条纹的产生是由于光在膜的前后两表面反射，形成的两列光波叠加的结果@干涉条纹中的暗纹是由于上述两列反射光的波谷与波谷叠加的结果@干涉条纹是一组等间距的平行线@观察薄膜干涉条纹时，应在入射光的同一侧', 3, 'B', '');
INSERT INTO `question` VALUES ('49', '单选题', '有以下说法：其中正确的是', '简谐运动是质点所受的合外力总是指向平衡位置且大小恒定的运动．@一列波的波长与障碍物的尺寸相比越大衍射现象就越明显@变化的磁场一定产生变化的电场@X射线是电子流', 3, 'B', '');
INSERT INTO `question` VALUES ('50', '多选题', '弹簧振子在光滑水平面上做简谐运动，在振子向平衡位置运动的过程中（ ）', '振子所受回复力逐渐减小 @振子位移逐渐减小 @振子速度逐渐减小 @振子加速度逐渐减小 ', 5, 'AD', '');
INSERT INTO `question` VALUES ('51', '单选题', '分子间同时存在着引力和斥力，当分子间距增加时，分子间的', '引力增加，斥力减小@引力增加，斥力增加@引力减小，斥力减小@引力减小，斥力增加', 3, 'C', '');
INSERT INTO `question` VALUES ('52', '单选题', '下列叙述中，正确的是', '物体的温度越高，分子热运动就越剧烈，每个分子动能也越大@布朗运动就是液体分子的热运动@一定质量的理想气体从外界吸收热量，其内能可能不变@根据热力学第二定律可知热量能够从高温物体传到低温物体，但不可能从低温物体传到高温物体', 3, 'C', '');
INSERT INTO `question` VALUES ('53', '多选题', '下列说法中正确的有', '气缸内的气体具有很大的压强，是因为气体分子间表现为斥力@液体表面具有张力是因为液体表面层的分子间表现为引力@晶体的物理性质具有各向异性是因为晶体内部微粒按一定规律排列的@温度越高的物体，其内能一定越大、分子运动越剧烈', 5, 'BC', '');
INSERT INTO `question` VALUES ('54', '填空题', '改变物体内能的方式：         ', '', 3, '做功', '');
INSERT INTO `question` VALUES ('55', '填空题', '理想气体的内能与_________无关', '', 3, '体积', '');
INSERT INTO `question` VALUES ('56', '填空题', '外界对一定质量的气体做了200J的功，同时气体又向外界放出了80J的热量，则气体的内能     （填“增加”或“减少”）', '', 3, '增加', '');
INSERT INTO `question` VALUES ('57', '判断题', '雨后天空出现彩虹是光的衍射现象', '', 4, '错', '');
INSERT INTO `question` VALUES ('58', '判断题', '紫光光子的能量比红光光子的能量大', '', 4, '对', '');
INSERT INTO `question` VALUES ('59', '判断题', '太阳辐射的能量主要来自内部的裂变反应', '', 4, '错', '');
INSERT INTO `question` VALUES ('60', '简答题', '为什么说19世纪末物理学面临的“危机”引发了近代物理学革命？', '', 10, '电子的发现@放射性的发现@以太漂移的探索@普朗克辐射定律@量子假说', '');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `ID` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生号',
  `score` float NULL DEFAULT -1 COMMENT '总分数',
  `score_sing` float NULL DEFAULT -1 COMMENT '单选题分数',
  `score_muti` float NULL DEFAULT -1 COMMENT '多选题分数',
  `score_jud` float NULL DEFAULT -1 COMMENT '判断题分数',
  `score_fill` float NULL DEFAULT -1 COMMENT '填空题分数',
  `score_ess` float NULL DEFAULT -1 COMMENT '简答题分数',
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '成绩评价',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `score`(`score`) USING BTREE,
  CONSTRAINT `score_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1001', 97, 15, 20, 20, 12, 30, '优秀');
INSERT INTO `score` VALUES ('1002', 78, 12, 15, 16, 12, 23, '中等');
INSERT INTO `score` VALUES ('1003', 94, 15, 20, 16, 15, 28, '良好');
INSERT INTO `score` VALUES ('1004', 66, 9, 15, 12, 12, 18, '及格');
INSERT INTO `score` VALUES ('1005', 78, 12, 10, 16, 15, 25, '中等');
INSERT INTO `score` VALUES ('1006', 92, 15, 20, 12, 15, 26, '良好');
INSERT INTO `score` VALUES ('1007', 62, 9, 10, 12, 15, 16, '及格');
INSERT INTO `score` VALUES ('1015', 0, 0, 0, 0, 0, 0, '不及格');
INSERT INTO `score` VALUES ('1017', 4, 0, 0, 4, 0, 0, '不及格');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `ID` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生号',
  `password` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学生密码',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学生姓名',
  `class` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学生班级',
  `score` float NOT NULL DEFAULT -1 COMMENT '学生成绩',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `score`(`score`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1001', '002', '赵安军', '计科164', 97);
INSERT INTO `student` VALUES ('1002', '0000', '赵广坤', '计科164', 78);
INSERT INTO `student` VALUES ('1003', '0000', '钱浩华', '计科164', 94);
INSERT INTO `student` VALUES ('1004', '0000', '钱德芳', '计科164', 66);
INSERT INTO `student` VALUES ('1005', '0000', '钱敬德', '计科164', 78);
INSERT INTO `student` VALUES ('1006', '0000', '孙文君', '计科164', 92);
INSERT INTO `student` VALUES ('1007', '0000', '孙学贤', '计科164', 62);
INSERT INTO `student` VALUES ('1008', '0000', '李平安', '计科164', -1);
INSERT INTO `student` VALUES ('1009', '0000', '李建国', '计科164', -1);
INSERT INTO `student` VALUES ('1010', '0000', '周公瑾', '计科164', -1);
INSERT INTO `student` VALUES ('1011', '0000', '周金讯', '计科164', -1);
INSERT INTO `student` VALUES ('1012', '0000', '刘德华', '计科164', -1);
INSERT INTO `student` VALUES ('1013', '0000', '黎明', '计科164', -1);
INSERT INTO `student` VALUES ('1014', '0000', '郭富城', '计科164', -1);
INSERT INTO `student` VALUES ('1015', '0000', '张学友', '计科164', 0);
INSERT INTO `student` VALUES ('1017', '0000', '刘波', '计科164', 53);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `ID` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教职工号',
  `password` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教师密码',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教师姓名',
  `class` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教师班级',
  `job` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '教师职称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('9001', '1111', '张中正', '计科164', '教授');
INSERT INTO `teacher` VALUES ('admin', 'admin', '管理员', 'ALL', '管理员');

SET FOREIGN_KEY_CHECKS = 1;
