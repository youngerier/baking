
### 2D装修设计数据支持
- 软装家具3维数据/替换软装数据
- 户型图/户型库/bim
- 门窗


##### homeData包含

HomeData数据结构

![HomeData数据结构](./bak/homedata.png 'HomeData数据结构')


homeData
- designHomeData
    - molding <- moldingcomon + /api/floorplancommon 户型中间层
    - furniture <- furniturecommon + /api/furniturecommon 家具中间层

- floorPlanHomeData
    - Level 层
    - Wall 
    - Pillar 
    - Beam 梁
    - FloorHole 楼板 开洞?
    - ElementFace 

- layoutHomeData


#### 获取homeData 数据
通过soa调用
```yml
service:
  vip-list:
    - com.qunhe.instdeco.service.diy.kam-service
```
com.qunhe.kam.client.floorplancommon.api.FloorplanCommonApi

###### 问题
项目启动不了.....

#### 方案
https://sit.kujiale.com/cloud/tool/h5/diy?designid=3FO4M9F6ABLM&redirecturl=https%3A%2F%2Fsit.kujiale.com%2Fvc%2Fdesign%2F3FO4M9F8I00U%3Fkpm%3DqkWL.64cad2d11d7f6a4b.8a462ea.1608015405423&em=0



designhomedata包括了molding和furniture两个信息，要拿这两个信息可以通过中间层数据moldingcommon和furniturecommon去拿

bim后端工具主服务 = kamservice