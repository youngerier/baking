
### 轻设计问题

##### /ka/api/enterprise/easydesign/v2/create

这个接口发起的酷品秀模型渲染任务的位置 (找到了)
com.qunhe.ka.solution.biz.soa.ModelViewerFacade#sendRenderTasksWithoutCheck


模型的组成(是模型数据 + 贴图) 还有其他吗


渲染任务的产物是什么怎么获取的

设计方案数据包含
homeData 
 - designHomeData
 - floorPlanHomeData
 - layoutHomeData

设计方案数据获取方式

  - com.qunhe.diybe.module.furniturecommon.model.FurnitureCommon // 家具
  - com.qunhe.diybe.module.floorplancommon.model.FloorplanCommonModel // 平面图
  

