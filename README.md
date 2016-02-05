# url2leanote

将网页通过`readability`简化并转成`markdown`格式保存到leanote中。
**不支持动态网页(如leanote自带的博客....)和非utf8编码的网页。**

## 使用方法

```
http://server/favour?url=<webpage location>&notebook=<笔记本的**名称**>&token=<账户的token>
```

要是不知道token可以这样

```
http://server/favour?url=<webpage location>&notebook=<笔记本的**名称**>&email=<login email>&pwd=<login pwd>

http://localhost:8080/favour?email=xxx@live.cn&pwd=xxx&url=http://www.cnblogs.com/chenmo-xpw/p/5182950.html&notebook=work
```
如果服务器没挂https那么就......

或者有很多重名的notebook
```
http://server/favour?url=<webpage location>&notebookId=<笔记本的**ID**>&email=<login email>&pwd=<login pwd>
```

## 关于保存图片到leanote的服务器上

目前是**不可以**。
因为我没看懂[API](https://github.com/leanote/leanote/tree/master/app/controllers/api)中`/note/addNote`如何把图片传上去。

## 服务呢？
写好了Dokcerfile等待构建成功中。。。
