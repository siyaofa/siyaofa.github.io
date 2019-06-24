---
layout: default
title: Home
---

<div class="posts">
  {% for post in paginator.posts %}
  <div class="post">
    <h1 class="post-title">
      <a href="{{ site.baseurl }}/{{ post.url }}">
        {{ post.title }}
      </a>
    </h1>

    <span class="post-date">{{ post.date | date_to_string }}</span>

    {{ post.content }}
  </div>
  {% endfor %}
</div>

<div class="pagination">
  {% if paginator.next_page %}
    <a class="pagination-item older" href="{{ site.baseurl }}/page{{paginator.next_page}}">Older</a>
  {% else %}
    <span class="pagination-item older">Older</span>
  {% endif %}
  {% if paginator.previous_page %}
    {% if paginator.page == 2 %}
      <a class="pagination-item newer" href="{{ site.baseurl }}/">Newer</a>
    {% else %}
      <a class="pagination-item newer" href="{{ site.baseurl }}/page{{paginator.previous_page}}">Newer</a>
    {% endif %}
  {% else %}
    <span class="pagination-item newer">Newer</span>
  {% endif %}
</div>


## [软件](pages/software/contents)

实际工作中有一半的时间是花费在软件相关的工作上。

- 软件是做什么的？

- 软件是如何运行的？

- 软件是如何开发和设计的？

- 实际工程中会碰到哪些问题？

## [计算机](pages/computer/contents)

通用计算机组成

## [硬件](pages/hardware/contents)

嵌入式软件开发工程师是不能脱离于硬件的，这一点与应用软件开发工程师是不同的。

- 基础硬件知识

- 工作的硬件

## [控制](pages/controller/contents)

在校项目和工作中有一部分精力花费在伺服运动控制上，故粗略的总结是需要的。

滤波、控制。

## [数学](pages/mathmatic/contents)

工程项目想要做到极致，最终发现 

>条条大路通罗马

罗马就是数学。人类对一切事物的认知可能都只是一种数学表达形式罢了。

复数、线性代数、微分方程
    

## 模式识别

个人片面的理解：机器学习和深度神经网络本质上都是分类器。

只不过有些分类器的模型复杂度很高，如果样本量足够大。模型关键系数被确定下来了，便可以有很好的分类效果。

随着理论的完善，可能未来人类要做的事情就是建立模型和确定如何提取特征的方法了。

目前能产生较大经济效益的主要集中在：推荐系统、图像识别和自然语音处理。

## [算法](pages/algorithm/contents)

零散的记录了一些工作中用到的算法。

## 其他

按专业学科是无法囊括所有的事情，生活处处充满惊喜。

[好友主页](https://blog.csdn.net/root_clive?t=1)
