
### 2D装修设计数据支持

#### 方案所需数据项

- 软装家具3维数据/替换软装数据
- 户型图/户型库/bim
- 门窗


> homedata是包括了一个户型的所有数据，包括家具，户型，图例等信息 @墨禾 

#### HomeData数据结构

- 获取方法 `com.qunhe.instdeco.designapi.clients.HomeDataClient#getHomeData`
```java
public String getHomeData(Long designId, String levelId) throws DesignServiceException {
    List<Pair<String, Object>> params = new ArrayList();
    params.add(new Pair("designid", designId));
    if (StringUtils.isNotBlank(levelId)) {
        params.add(new Pair("levelid", levelId));
    }

    params.add(new Pair("multilevel", 1));
    MethodResult<String> methodResult = this.mHomeDataApi.getHomeData(params);
    return (String)MethodResultUtils.parseMethodResultWithCondition(methodResult);
}
```
- 获取结果结构
`com.qunhe.diybe.module.designmodel.data.HomeData` 

![HomeData数据结构](./bak/homedata.png 'HomeData数据结构')


HomeData
- designHomeData
    - molding <- moldingcomon + /api/floorplancommon 户型中间层
    - furniture <- furniturecommon + /api/furniturecommon 家具中间层

- floorPlanHomeData
    - Level 层
    - Wall 
    - Pillar 
    - Beam 梁
    - FloorHole  表示楼板上的挖洞对象
    - ElementFace 

- layoutHomeData // 方案布局信息
    > @qianyue


metadata
levels
structures
 areas
 rooms
 walls
 corners
 exareas
 areasurfaces
objects
 holes
 furnitures
 layoutfurnitures
 h5layoutfurnitures
 materials
 layoutmaterials
 pillars
 beams
relations
 

#### 获取homeData 数据
通过soa调用
```yml
service:
  vip-list:
    - com.qunhe.instdeco.service.diy.kam-service
```
com.qunhe.kam.client.floorplancommon.api.FloorplanCommonApi

##### 问题
 ~~demo项目项目启动不了.....~~

#### 方案
https://sit.kujiale.com/cloud/tool/h5/diy?designid=3FO4M9F6ABLM&redirecturl=https%3A%2F%2Fsit.kujiale.com%2Fvc%2Fdesign%2F3FO4M9F8I00U%3Fkpm%3DqkWL.64cad2d11d7f6a4b.8a462ea.1608015405423&em=0


##### 名词解释
designhomedata包括了molding和furniture两个信息，要拿这两个信息可以通过中间层数据moldingcommon和furniturecommon去拿

bim后端工具主服务 = kamservice
Floorplan = 布图规划

###

- 户型图生成流程
- 家具位置信息的描述方式和数据结构
- 现有云图获取homedata的接口
- 中间层是怎么用的
- 