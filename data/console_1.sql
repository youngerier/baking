create table if not exists announcement
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	org_id int unsigned not null comment '商家组织ID',
	announcement text null comment '公告',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '开发商公告表';

create table if not exists bbc_brand_good_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	order_id int not null comment '订单编号：bbc_order_info 表主键',
	brand_good_id int not null comment '商品id',
	user_id int null comment '商品所属用户id',
	brand_id int null comment '商品品牌id',
	preview_img varchar(127) null comment '商品图片链接',
	description varchar(255) null comment '商品描述',
	brand_good_name varchar(63) null comment '商品名称',
	price decimal(10,2) null comment '商品价格',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	space_type varchar(31) not null comment '空间类型'
)
comment 'bbc商品方案表';

create index idx_order_id
	on bbc_brand_good_info (order_id);

create table if not exists bbc_order_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	room_number varchar(63) null comment '用户填写的房间号',
	customer_name varchar(31) null comment '客户姓名',
	phone varchar(31) null comment '客户电话',
	remark varchar(255) null comment '备注',
	design_id int null comment '方案id',
	pano_type tinyint(3) null comment '漫游类型  0：单空间 ；1：全屋漫游 ；2：风格替换 ；3：智能漫游1.0；4：智能漫游2.0',
	total_price decimal(10,2) null comment '订单总价',
	user_id int null comment '订单所属销售id',
	account_id int null comment '所属销售的商家总账号',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	floorplanId int not null comment '楼盘id',
	propertyId int not null comment '户型id'
)
comment 'bbc订单表';

create table if not exists building_floorplan
(
	id int unsigned auto_increment comment '主键'
		primary key,
	building_id int(10) not null comment '楼栋id',
	floorplan_id int(10) not null comment '户型id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '楼栋户型分布';

create table if not exists building_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int(10) not null comment '楼盘id',
	name varchar(15) not null comment '楼栋名称',
	unit_number tinyint(3) null comment '单元数1-10',
	floor_household int(10) null comment '单层户数 单位(户)',
	total_household int(10) null comment '总户数 单位(户)',
	sale_status tinyint(3) not null comment '销售状态 0待售 1在售',
	storey_picture_url varchar(255) null comment '楼层图链接',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '楼栋信息表';

create index idx_property_id
	on building_info (property_id);

create table if not exists camera_plan_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	plan_id int not null comment '户型id',
	design_id int null comment '方案id',
	upload_image_url varchar(127) null comment '实景全景图url',
	cam_pos_x varchar(255) not null comment '相机位置x坐标',
	cam_pos_y varchar(255) not null comment '相机位置y坐标',
	cam_pos_z varchar(255) not null comment '相机位置z坐标',
	look_at_pod_x varchar(255) not null comment '相机朝向x坐标',
	look_at_pod_y varchar(255) not null comment '相机朝向y坐标',
	look_at_pod_z varchar(255) not null comment '相机朝向z坐标',
	hfov varchar(255) not null comment '全景图参数',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	location_id varchar(255) null comment '三方系统的点位id，可以不传'
)
comment '虚实同屏相机点位与方案信息表';

create index idx_plan_id
	on camera_plan_info (plan_id);

create table if not exists compare_design_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	plan_id int not null comment '户型id',
	design_id int not null comment '方案id',
	plan_image varchar(127) null comment '户型图url',
	design_name varchar(127) null comment '方案名称',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '对比方案信息表';

create table if not exists consultant_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int(10) not null comment '楼盘id',
	uid int unsigned null comment '置业顾问UID',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	phone varchar(15) null comment '置业顾问手机号'
)
comment '置业顾问关联表';

create index idx_property_id
	on consultant_info (property_id);

create table if not exists design_compare_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	compare_design_one int not null comment '方案对比id一:compare_design_info表主键',
	compare_design_two int not null comment '方案对比id二:compare_design_info表主键',
	account_id int null comment '总账号id',
	remark varchar(63) null comment '备注',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '方案vr同屏对比记录表';

create table if not exists floor_floorplan
(
	id int unsigned auto_increment comment '主键'
		primary key,
	building_id int not null comment '楼栋id',
	floorplan_id int(10) not null comment '户型id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	anchor_x int not null comment 'x轴坐标',
	anchor_y int not null comment 'y轴坐标',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '楼层户型关联表';

create table if not exists floor_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	building_id int(10) not null comment '楼栋id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '楼层信息表';

create index idx_building_id
	on floor_info (building_id);

create table if not exists floorplan_design_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	floorplan_id int not null comment '户型表主键id',
	design_id int null comment '方案id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	pano_type tinyint unsigned null comment '关联的全景图类型 0：单空间 ；1：全屋漫游 ；2：风格替换 ；3：智能漫游1.0；4：智能漫游2.0',
	design_name varchar(127) null comment '方案名称',
	pano_img_url varchar(255) null comment '漫游图连接'
)
comment '户型方案关联表';

create index idx_floorplan_id
	on floorplan_design_info (floorplan_id);

create table if not exists floorplan_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int(10) not null comment '楼盘id',
	name varchar(63) not null comment '户型名称',
	living_room_type tinyint null comment '户型结构 客厅',
	structure_space int(5) not null comment '建筑面积 单位(平米)',
	complimentary_space int(5) null comment '赠送面积 单位(平米) ',
	real_space int(5) null comment '实用面积 单位(平米) ',
	room_rate int(5) null comment '得房率 百分百 ',
	average_price int(10) null comment '参考均价 单位(元/平米) ',
	total_space int(10) null comment '参考总价 单位(万元) ',
	floorplan_picture_url varchar(255) not null comment '户型图链接',
	design_id int null comment 'vr全景图id',
	towards tinyint(3) null comment '朝向 朝南，朝北，朝东，朝西 ',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	bedroom_type tinyint null comment '户型类型 卧室',
	bathroom_type tinyint null comment '户型类型 卫生间',
	kitchen_type tinyint null comment '户型类型 厨房',
	pano_type tinyint unsigned null comment '关联的全景图类型'
)
comment '户型信息表';

create index idx_property_id
	on floorplan_info (property_id);

create table if not exists label_item
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	label_type_id int unsigned not null comment '标签类型ID',
	name varchar(255) not null comment '标签项名称',
	level varchar(15) not null comment '权限等级：system：系统标签不允许修改，customize：自定义标签允许修改',
	created datetime default CURRENT_TIMESTAMP not null,
	org_id int not null comment '商家组织ID'
)
comment '标签项表';

create index idx_label_id
	on label_item (label_type_id);

create table if not exists label_type
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	name varchar(31) not null comment '类型名称',
	level varchar(15) not null comment '权限等级：system：系统标签不允许修改，customize：自定义标签允许修改',
	select_type varchar(15) not null comment '选择方式：multi：多选，single：单选',
	created datetime default CURRENT_TIMESTAMP not null,
	org_id int not null comment '商家组织ID'
)
comment '标签类型表';

create table if not exists message_send_task_record
(
	id int unsigned auto_increment comment '主键'
		primary key,
	vr_session_record_id int not null comment 'vr_session_record主键id',
	task_id varchar(127) null comment '友盟发送的任务id',
	send_status varchar(15) null comment '发送状态',
	cancel_status varchar(15) null comment '取消状态',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	device_type varchar(15) null comment '设备类型'
)
comment '友盟消息发送任务表';

create index idx_vr_session_record_id
	on message_send_task_record (vr_session_record_id);

create table if not exists pano_demo_info
(
	id int auto_increment
		primary key,
	plan_id int not null comment '方案id',
	pano_scene text not null comment '全景图场景json',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	img varchar(255) not null comment '方案文件地址'
)
comment '金茂demo场景数据';

create table if not exists pic_compare_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	design_compare_id int not null comment 'design_compare_info表主键',
	pic_id varchar(63) null comment '全景图图片id',
	pic_id_compare varchar(63) null comment '对比全景图图片id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	level_id varchar(127) null comment '楼层id',
	level_id_compare varchar(127) null comment '对比楼层id'
)
comment '对比方案全景图关联信息表';

create table if not exists property_account_relation
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int not null comment '楼盘ID',
	sub_account_id int not null comment '账号ID',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '子账号和楼盘的多对多关系表';

create index idx_p_id
	on property_account_relation (property_id);

create index idx_s_a_id
	on property_account_relation (sub_account_id);

create table if not exists property_favorite
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int(10) not null comment '楼盘id',
	open_id varchar(255) not null comment '访客对应的open_id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	constraint udx_openid_property_id
		unique (open_id, property_id)
)
comment '用户收藏表';

create index idx_property_id
	on property_favorite (property_id);

create table if not exists property_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	name varchar(63) not null comment '楼盘名称',
	nickname varchar(63) null comment '楼盘别名',
	type tinyint(3) not null comment '物业业态：配置项 ：对应label_item_id',
	reference_price int(10) null comment '参考价格 单位(元/M2)',
	reference_total_price int(10) null comment '参考总价 单位(万元) ',
	decoration_situation tinyint(3) null comment '装修情况 1.精装修 2.毛坯',
	decoration_standard int(10) null comment '装修标准 单位(元/M2)',
	province int null comment '楼盘所在省',
	city int null comment '楼盘所在市',
	district int null comment '楼盘所在区',
	property_address varchar(255) null comment '楼盘所在地址',
	property_longitude varchar(31) null comment '楼盘所在地经度',
	property_latitude varchar(31) null comment '楼盘所在地纬度',
	sale_department_province int null comment '售楼部所在省',
	sale_department_city int null comment '售楼部所在市',
	sale_department_district int null comment '售楼部所在区',
	sale_department_address varchar(255) null comment '售楼部所在地址',
	sale_department_longitude varchar(31) null comment '售楼部所在地经度',
	sale_department_latitude varchar(31) null comment '售楼部所在地纬度',
	sandbox_picture_url varchar(255) null comment '沙盘图片地址',
	sale_status tinyint(3) default 0 null comment '销售状态 0待售 1在售',
	shelves_status tinyint(3) default 0 null comment '上架状态 0下架 1上架',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	is_recommend tinyint unsigned default 0 not null comment '是否推荐 0未推荐 1已推荐',
	cover_picture_url varchar(255) null comment '封面图片地址',
	account_id int null comment '总账号id',
	phone varchar(31) null comment '固定电话/手机号码',
	floor_space int(10) null comment '占地面积 单位(平米)',
	building_space int(10) null comment '建筑面积 单位(平米)',
	green_rate int(4) null comment '绿化率 百分比',
	parking_space int(10) null comment '停车位 单位(个)',
	household int(10) null comment '总户数 单位(户)',
	property_management_company varchar(63) null comment '物业公司',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	rights_year int null comment '产权年限',
	open_time varchar(31) null comment '开盘时间'
)
comment '楼盘信息表';

create table if not exists property_label
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int unsigned not null comment '楼盘ID',
	label_item_id int unsigned not null comment '标签项ID',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）'
)
comment '楼盘标签表';

create index idx_property_id
	on property_label (property_id);

create table if not exists property_picture
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int not null comment '楼盘id',
	picture_type tinyint(3) not null comment '图片类型',
	picture_name varchar(63) null comment '图片名称',
	picture_url varchar(255) not null comment '户型图链接',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '楼盘图册表';

create index idx_property_id
	on property_picture (property_id);

create table if not exists property_swiper
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	org_id int unsigned not null comment '商家组织ID',
	property_id int unsigned not null comment '楼盘项目ID',
	pic_url varchar(1023) not null comment '照片url地址',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '楼盘图片表';

create index idx_cid
	on property_swiper (org_id);

create table if not exists render_real_demo
(
	id int unsigned auto_increment comment '主键'
		primary key,
	design_id int not null comment '虚拟方案id',
	obs_pic_id varchar(63) not null comment '虚实全景图的picId',
	real_pic_url varchar(255) null comment '实景全景图链接',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	title varchar(31) null comment '全景图标题'
)
comment '虚实同屏demo';

create table if not exists render_real_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	plan_id int not null comment '户型id',
	design_id int null comment '方案id',
	render_pano_url varchar(127) null comment '渲染全屋漫游图url',
	real_pano_url varchar(127) null comment '实景全屋漫游图url',
	account_id int null comment '总账号id',
	design_name varchar(127) null comment '方案名称',
	community_name varchar(127) null comment '小区名',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	constraint idx_plan_id
		unique (plan_id)
)
comment '虚实同屏信息表';

create table if not exists render_real_transmit_record
(
	id int unsigned auto_increment comment 'id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	user_id int not null comment '用户id',
	plan_id int not null comment '方案id',
	request_url varchar(255) not null comment '请求地址',
	param text not null comment '请求参数',
	result text not null comment '返回结果',
	success tinyint default 0 not null comment '是否成功',
	start_time datetime not null comment '开始时间',
	end_time datetime not null comment '结束时间'
)
comment '虚实同屏传输记录';

create table if not exists render_real_transmit_task
(
	id int unsigned auto_increment comment 'id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	user_id int not null comment '用户id',
	plan_id int not null comment '方案id',
	content text not null comment '传输内容',
	status tinyint default 1 not null comment '状态：1-已提交，2-执行中，3-以完成',
	start_time datetime default CURRENT_TIMESTAMP not null comment '提交时间',
	end_time datetime default CURRENT_TIMESTAMP not null comment '结束时间',
	error_msg text null comment '失败信息'
)
comment '虚实同屏传输任务';

create table if not exists sandbox_building
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int(10) not null comment '楼盘id',
	building_id int(10) not null comment '楼栋id',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	anchor_x int not null comment 'x轴坐标',
	anchor_y int not null comment 'y轴坐标',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '沙盘楼栋关联表';

create table if not exists surrounding_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	property_id int not null comment '楼盘id',
	traffic varchar(255) null comment '交通',
	education varchar(255) null comment '教育',
	mall varchar(255) null comment '商场',
	hospital varchar(255) null comment '医院',
	bank varchar(255) null comment '银行',
	community_support varchar(255) null comment '小区配套',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '周边配套信息';

create index idx_property_id
	on surrounding_info (property_id);

create table if not exists um_certificate_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	app_key varchar(63) null comment '商家对应酷家乐开放平台appkey',
	account_id int not null comment '商家总账号',
	um_apple_app_key varchar(63) null comment '友盟苹果appKey',
	apple_p8_certificate_url varchar(255) null comment '苹果p8证书',
	apple_key_id varchar(63) null comment '友盟苹果keyId',
	apple_team_id varchar(63) null comment '友盟苹果teamId',
	apple_bundle_id varchar(255) null comment '友盟苹果bundleId',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	um_apple_app_secret varchar(127) null comment '友盟苹果appSecret',
	um_android_app_key varchar(127) null comment '友盟安卓appKey',
	um_android_app_secret varchar(127) null comment '友盟安卓appSecret',
	um_android_message_secret varchar(127) null comment '安卓消息secret'
)
comment '友盟设备证书信息表';

create table if not exists user_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	open_id varchar(127) not null comment '微信openId',
	union_id varchar(127) null comment '微信unionId',
	avatar varchar(255) null comment '头像',
	nick_name varchar(127) null comment '昵称',
	phone varchar(15) null comment '手机号',
	city int(10) null comment '城市',
	user_id int(10) null comment '商家账号',
	type tinyint unsigned default 0 not null comment '1 客户 2 置业顾问',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除',
	gender tinyint null comment '性别 0未知 1男性 2女性',
	country varchar(15) null comment '国家',
	province varchar(15) null comment '省份',
	wx_city varchar(15) null comment '微信端城市',
	device_token varchar(127) null comment '置业顾问关联的设备id，用于推送消息',
	device_type varchar(15) null comment '设备操作系统类型'
)
comment '用户信息表';

create index idx_open_id
	on user_info (open_id);

create index idx_phone
	on user_info (phone);

create index idx_user_id
	on user_info (user_id);

create table if not exists user_login_record
(
	id int unsigned auto_increment comment '主键'
		primary key,
	user_id int(10) null comment '商家账号',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '商家用户是否登录记录表';

create index idx_user_id
	on user_login_record (user_id);

create table if not exists user_personal_consultant
(
	id int unsigned auto_increment comment 'id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	property_id int not null comment '楼盘Id',
	customer_id int not null comment '客户Id',
	consultant_id int not null comment '置业顾问Id'
)
comment '客户专属职业顾问表';

create index idx_consultant_id
	on user_personal_consultant (consultant_id);

create index idx_customer_id
	on user_personal_consultant (customer_id);

create table if not exists view_appointment
(
	id int unsigned auto_increment comment '主键'
		primary key,
	open_id varchar(127) not null comment '微信openId',
	property_id int(10) null comment '楼盘项目ID',
	consultant_uid int(10) null comment '置业顾问userId',
	appointment_time datetime default CURRENT_TIMESTAMP not null comment '预约时间',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '线下看房预约表';

create index idx_consultant_uid
	on view_appointment (consultant_uid);

create index idx_open_id
	on view_appointment (open_id);

create table if not exists vr_record
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	vr_session_id int unsigned not null comment 'vr_session表主键',
	property_id int not null comment '楼盘ID',
	customer_req_time datetime null comment '客户发起带看的时间点',
	connected datetime null comment '首次连接时间',
	disconnected datetime null comment '断开连接时间',
	calling_type tinyint null comment '带看呼叫类型 1.抢单 2.指定置业顾问',
	customer_id varchar(127) null comment '用户标识ID',
	plan_id varchar(63) null comment '方案ID',
	floorplan_id int null comment '户型ID',
	consultant_id varchar(31) null comment '置业顾问手机号码',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	user_type tinyint null comment '用户类型：1-普通用戶,2-置业顾问',
	user_id int null comment '用戶id'
)
comment 'vr同屏看房记录表';

create index idx_user_type_user_id
	on vr_record (user_type, user_id);

create index idx_vr_session_id
	on vr_record (vr_session_id);

create table if not exists vr_session
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	property_id int not null comment '楼盘ID',
	disconnected datetime null comment '断开连接时间',
	connected datetime null comment '首次连接时间',
	customer_id varchar(127) null comment '用户标识ID',
	customer_ip varchar(31) null comment '客户机IP',
	consultant_ip varchar(31) null comment '置业顾问机器IP',
	daemon_ip varchar(31) null comment '守护机器IP',
	status varchar(31) default 'ready' null comment '状态，分为ready,connecting,connected,disconnected,finished',
	plan_id varchar(63) null comment '方案ID',
	floorplan_id int null comment '户型ID',
	consultant_id varchar(31) null comment '置业顾问手机号码',
	customer_req_time datetime null comment '客户发起带看的时间点',
	calling_type tinyint null comment '带看呼叫类型 1.抢单 2.指定置业顾问',
	customer_uid int null comment '客户id',
	consultant_uid int null comment '置业顾问id'
)
comment 'vr同屏看房';

create index idx_consultant_uid
	on vr_session (consultant_uid);

create index idx_customer_uid
	on vr_session (customer_uid);

create index idx_property_id
	on vr_session (property_id);

create table if not exists vr_session_comment
(
	id int unsigned auto_increment comment '主键id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	session_id int not null comment '带看id',
	property_id int not null comment '楼盘Id',
	consultant_id int not null comment '置业顾问id',
	customer_id int not null comment '普通用户id',
	comment varchar(255) not null comment '带看评论'
)
comment 'VR带看评价';

create index idx_session_id
	on vr_session_comment (session_id);

create table if not exists vr_session_daily_overview_consultant
(
	id int unsigned auto_increment
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	consultant_id int not null comment '置业顾问id',
	vr_count int not null comment 'VR带看次数',
	vr_time bigint not null comment 'VR带看时长',
	year int not null comment '年份',
	month tinyint not null comment '月',
	date tinyint not null comment '日',
	constraint udx_year_month_date_consultant_id
		unique (year, month, date, consultant_id)
)
comment '带看每日统计-置业顾问';

create index idx_created
	on vr_session_daily_overview_consultant (created);

create table if not exists vr_session_daily_overview_property
(
	id int unsigned auto_increment comment '主键id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	property_id int not null comment '楼盘id',
	vr_time bigint not null comment '带看时长',
	vr_count int not null comment '带看次数',
	year int not null comment '年',
	month tinyint not null comment '月',
	date tinyint not null comment '日',
	constraint udx_year_month_date_property_id
		unique (year, month, date, property_id)
)
comment '楼盘每日带看统计';

create index idx_created
	on vr_session_daily_overview_property (created);

create table if not exists vr_session_floorplan
(
	id int unsigned auto_increment
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	session_id int not null comment '带看记录id',
	property_id int not null comment '楼盘Id',
	floorplan_id int not null comment '户型id',
	last_vr_time datetime default CURRENT_TIMESTAMP not null comment '上一次VR带看时间点',
	vr_time int default 0 not null comment '带看时长，单位秒',
	note varchar(255) null comment '带看笔记内容'
)
comment '带看户型记录';

create index idx_session_id
	on vr_session_floorplan (session_id);

create table if not exists vr_session_push_record
(
	id int unsigned auto_increment comment '主键id'
		primary key,
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间',
	last_modified datetime default CURRENT_TIMESTAMP not null comment '最后修改时间',
	type tinyint not null comment '推送类型：1-VR带看呼叫，2-营销信息推送',
	task_id varchar(255) null comment '推送id',
	title varchar(255) null comment '推送标题',
	content varchar(255) null comment '推送内容',
	send_status varchar(15) null comment '推送状态',
	cancel_status varchar(15) null comment '取消状态',
	device_type varchar(15) null comment '设备类型：iOS、Android',
	session_id int not null comment 'VR带看id'
)
comment 'VR带看APP推送统计';

create index idx_session_id
	on vr_session_push_record (session_id);

create table if not exists white_table_user_info
(
	id int unsigned auto_increment comment '主键'
		primary key,
	user_id int not null comment '用户id',
	type tinyint unsigned not null comment '权限类型 1:3d户型 2:虚实同屏',
	email varchar(127) null comment '邮箱',
	company_name varchar(127) null comment '公司名称',
	created datetime default CURRENT_TIMESTAMP not null comment '创建时间（提交时间）',
	last_modified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	deleted tinyint unsigned default 0 not null comment '是否删除 0未删除 1已删除'
)
comment '白名单用户信息表';

create index idx_user_id
	on white_table_user_info (user_id);

