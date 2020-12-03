### 烘焙的概念

> 就是把场景中的灯光信息，通过贴图的方式表现出来

比方说，有一把椅子模型，模型上有木纹贴图，现在我用灯光把这个模型照亮了，那么在这里，你所看到的是“被灯光照亮了的木纹椅子”，所需要的元素有3个，分别是椅子模型，木纹贴图，灯光。
那么这时候我们使用烘培，烘焙之后，灯光就可以删除了，这时候我们还是看到“被灯光照亮了的木纹椅子”，但是这时候元素就只有2个，分辨是椅子模型和“被照亮了的木纹贴图”，也就是说木纹贴图和灯光“合体"了。这时候就不需要灯光了。

![材质烘焙](./bak/texture_bak.gif '材质烘焙')


### 烘焙解决的问题

> 灯光越多，流畅度越低。所以经常使用烘培技术，让灯光和贴图*合体*，**节约系统资源**。

> 将3D几何特征转换为2D图像纹理的能力

### 烘焙的技术实现方式, 实现步骤流程

#### 实现方式通俗的描述
![材质烘焙](./bak/baking_procedure.jpg '烘焙过程')

 
#### 使用步骤流程

- 客户端: 对于Java程序准备数据，然后添加任务到redis队列，
- 烘焙服务器: 调用python脚本轮询来执行3dmax 脚本来烘焙的


#### 模型烘焙的优缺点
- 因为它是静态的，而不是动态的,不够真实。再上面的例子中移动猴子头将其阴影留在地板上，而不是随着旋转的视角而实时渲染更新
- **节约系统资源**

#### 烘焙的类型

- 材质烘焙(Texture Baking)
- 动画烘焙(Animation/Simulation Baking)
- 光线烘焙( Light Baking) 游戏引擎使用

### 烘焙项目进展

### 烘焙的输入/输出,配置项



##### 参考链接:

[RayTracing]https://blogs.nvidia.com/blog/2018/03/19/whats-difference-between-ray-tracing-rasterization/

[烘焙]https://cgcookie.com/articles/big-idea-baking

[UV]https://www.zdaiot.com/ImageProcessing/UV%E7%9A%84%E6%A6%82%E5%BF%B5%E5%8F%8A%E4%BD%9C%E7%94%A8/

[法线]https://zh.wikipedia.org/wiki/%E6%B3%95%E7%BA%BF


##### 

![材质烘焙](./bak/raytrace.gif '实时光线追踪')