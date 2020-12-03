create table if not exists easy_design
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	request_id int unsigned not null comment '唯一索引约束保证一个全景图或者全屋漫游图只有一个轻设计',
	user_id int unsigned not null comment '商家账号id',
	status tinyint unsigned default 0 not null comment '1 处理中,2 失败,3成功',
	design_id int unsigned not null comment '方案id',
	src_design_id int unsigned not null comment '原方案id',
	type tinyint unsigned default 0 not null comment '1:全景图轻设计,2:全屋漫游图轻设计',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	version tinyint unsigned default 1 not null comment '版本号，区分轻设计1.0和2.0',
	constraint uk_req_type_verion
		unique (request_id, type, version)
)
comment '轻设计表';

create table if not exists easy_design_brandgood
(
	id int unsigned auto_increment
		primary key,
	easy_design_id int unsigned not null comment '轻设计表主键',
	version tinyint unsigned default 0 not null comment '0:最新的 1：处理中的',
	brandgood_id int unsigned not null comment '待替换商品id',
	brandgood_id_list varchar(2048) not null comment '替换商品id列表',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	type tinyint unsigned default 1 not null comment '1 软装商品 2硬装贴图类商品',
	replace_type tinyint unsigned default 1 not null comment '1 全屋替换
2.单房间替换',
	custom_id varchar(255) null comment '个性化业务id：比如定制的模型的id'
)
comment '轻设计替换商品表';

create index idx_easy_design_id_version
	on easy_design_brandgood (easy_design_id, version, brandgood_id);

create table if not exists easy_design_modelview_task
(
	id bigint unsigned auto_increment
		primary key,
	brandgood_id int unsigned not null comment '渲染的商品id',
	status tinyint unsigned default 0 not null comment '0-数据准备着,1-处理中,2-失败,3-成功',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	comment varchar(255) null comment '注释',
	constraint uk_bg
		unique (brandgood_id)
)
comment '轻设计modelview渲染任务表';

create table if not exists easy_design_process
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	easy_design_id int unsigned not null comment 'easy_design表的主键',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	status tinyint unsigned not null comment '1 处理中,2 失败,3成功'
)
comment '轻设计表';

create table if not exists easy_design_process_background_pic
(
	id int unsigned auto_increment comment '主键'
		primary key,
	process_task_id int unsigned not null comment '任务id',
	pic_id int unsigned not null comment '图片id',
	pic_url varchar(255) default '' not null comment '背景图渲染的结果url',
	replace_keys varchar(255) not null comment '硬装替换关系',
	light_url varchar(255) default '' not null comment '剔除掉全部软装的渲染图url',
	light_oss_url varchar(255) default '' not null comment '灯场数据上传oss的地址',
	status tinyint unsigned default 0 not null comment '二进制状态表示。',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
);

create index idx_task_id
	on easy_design_process_background_pic (process_task_id);

create table if not exists easy_design_process_material
(
	id int unsigned auto_increment
		primary key,
	process_task_id int unsigned not null comment '轻设计表中的任务处理taskId',
	status tinyint unsigned default 1 not null comment '1处理中,2失败,3成功',
	fail_material_id_list varchar(2048) null comment '失败的materialid',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	material_id_list varchar(2048) null comment '任务对应的material_id'
)
comment '轻设计材质预处理表';

create index idx_task_id
	on easy_design_process_material (process_task_id);

create table if not exists easy_design_process_model
(
	id int unsigned auto_increment
		primary key,
	process_task_id int unsigned not null comment 'easy_design_process表主键',
	status tinyint unsigned default 1 not null comment '1 处理中,2 失败,3成功',
	fail_mesh_id_list varchar(2048) null comment '失败的meshid',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
comment '轻设计模型预处理表';

create index idx_task_id
	on easy_design_process_model (process_task_id);

create table if not exists easy_design_process_pic
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	process_task_id int unsigned not null comment '轻设计表中的任务处理taskId',
	pic_id int unsigned not null comment '全景图id',
	status tinyint unsigned default 0 not null comment '1 处理中,2 失败,3成功',
	pic_url varchar(128) null comment '背景图url',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
comment '轻设计全景图表';

create index idx_task_id
	on easy_design_process_pic (process_task_id);

create table if not exists easy_design_task_detail
(
	id bigint unsigned auto_increment
		primary key,
	task_id int unsigned not null comment '主任务id',
	task_type tinyint unsigned not null comment '1-背景图渲染，2-光场图片渲染，3-光场文件渲染，4-3D Viewer渲染',
	task_subject bigint default 0 not null comment '任务执行对象，比如背景图渲染任务的id或模型3dviewer渲染任务id',
	status tinyint unsigned default 0 not null comment '0 数据准备着,1 处理中,2 失败,3成功',
	exec_cnt smallint(3) unsigned default 0 not null comment '执行次数',
	ext_info varchar(1024) null comment '扩展字段，放一些扩展信息',
	start_time datetime null comment '开始时间',
	end_time datetime null comment '结束时间',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	constraint uk_task_subject_type
		unique (task_subject, task_type)
)
comment '轻设计任务详情表';

create index idx_created
	on easy_design_task_detail (created);

create index uk_task_type
	on easy_design_task_detail (task_id, task_type);

create table if not exists easy_design_user_render_count
(
	id bigint unsigned auto_increment
		primary key,
	user_id bigint unsigned not null comment '特殊用户id',
	design_count int unsigned not null comment '用户名下方案数',
	env varchar(10) not null comment '环境-dev/prod',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	constraint uk_user_env
		unique (user_id, env)
)
comment '轻设计用户渲染特殊用户计数表';

create table if not exists ed_task
(
	id bigint unsigned auto_increment
		primary key,
	easy_design_id bigint unsigned not null comment '轻设计id',
	task_type tinyint unsigned not null comment '1-定制模型数据生成',
	status tinyint unsigned default 0 not null comment '0-数据准备着,1-处理中,2-失败,3-成功',
	task_result varchar(255) null comment '任务处理结果（数据url或其他标志），跟业务相关',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
)
comment '轻设计通用任务表';

create index idx_created
	on ed_task (created);

create index idx_ed
	on ed_task (easy_design_id);

create table if not exists my_design
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	name varchar(63) not null comment '设计名称',
	easy_design_id int unsigned default 0 not null comment '轻设计ID',
	img_url varchar(511) default '' not null comment '图片缩略图url',
	fe_data text null comment '前端配置数据',
	created datetime default CURRENT_TIMESTAMP not null
)
comment '我的设计表';

create index idx_easy_design_id
	on my_design (easy_design_id);

create table if not exists ska_rule
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	request_id varchar(32) not null comment '第三方请求标识符',
	user_id int unsigned not null comment '用户id',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	attributes varchar(512) null comment '扩展字段 key-value pairs',
	account_id int unsigned not null comment '根账号的accountId',
	constraint uk_account_id_request_id
		unique (account_id, request_id)
);

create table if not exists ska_rule_brandgood
(
	id int unsigned auto_increment comment '自增主键'
		primary key,
	rule_id int unsigned null comment '规则表的id',
	brandgood_id int unsigned null comment '模型库id',
	status tinyint unsigned null comment '状态 1新建 2已删除',
	created datetime default CURRENT_TIMESTAMP not null,
	lastmodified datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
	constraint udx_rule_brandgood
		unique (rule_id, brandgood_id)
);

create index rule_id
	on ska_rule_brandgood (rule_id);

create table if not exists test_auto
(
	id bigint unsigned auto_increment
		primary key,
	name varchar(255) not null comment 'name',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间'
);

create table if not exists user_easy_design
(
	id bigint unsigned auto_increment
		primary key,
	easy_design_id bigint unsigned not null comment '轻设计id',
	design_id varchar(64) not null comment '方案id',
	user_id bigint unsigned not null comment '用户id',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	type tinyint unsigned default 0 not null comment '1 全景图 2全屋漫游图',
	constraint uniq_easy_design_id_user
		unique (easy_design_id, user_id)
);

create table if not exists user_easy_design_render
(
	id bigint unsigned auto_increment comment '自增主键'
		primary key,
	user_easy_design_id bigint unsigned not null comment '用户轻设计表主键',
	status tinyint unsigned default 0 not null comment '1 已完成 2 失败 3合成全屋漫游图中',
	easy_design_id bigint unsigned not null comment '轻设计id',
	type tinyint unsigned not null comment ' 1全景图 2全屋漫游图',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	user_id bigint unsigned not null comment '用户Id'
);

create table if not exists user_easy_design_render_diff
(
	id int unsigned auto_increment comment '主键'
		primary key,
	user_easy_design_render_id int unsigned not null comment '渲染任务id',
	diff varchar(4096) not null comment 'homedata的diff数据',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	constraint uk_user_easy_design_render_id
		unique (user_easy_design_render_id)
);

create table if not exists user_easy_design_render_pic
(
	id bigint unsigned auto_increment
		primary key,
	user_easy_design_render_id bigint unsigned not null comment '渲染表id',
	src_pic_id bigint unsigned not null comment '原始pic_id',
	pic_id bigint unsigned default 0 not null comment '渲染后的pic_id',
	status tinyint unsigned default 0 not null comment '1渲染成功',
	created timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	lastmodified timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
	attributes varchar(255) default '' not null comment '扩展字段，放一些扩展信息'
);

