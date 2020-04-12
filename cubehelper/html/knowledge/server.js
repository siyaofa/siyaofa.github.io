var http = require('http');//创建服务器的
var fs = require('fs');
//引入进来的是模块，模块中有方法，下一步就是使用方法
//Node.js一个最主要的特点：执行的基本都是函数
var documentRoot = 'I:/WebServer';
//创建服务
var myServer = http.createServer(function(req,res){
    //req->请求变量：客户端请求服务器的
    //res->响应变量:服务器要给客户端写回的变量
    //前端页面应该给客户端显示，即写回去
    //这之前应该先把文件内容读出来
    var url = req.url; 
    var file = documentRoot + url;
    fs.readFile( file , function(err,data){
        /*
            err为文件路径
            data为回调函数
                回调函数的一参为读取错误返回的信息，返回空就没有错误
                data为读取成功返回的文本内容
        */
            if(err){
                res.writeHeader(404,{
                    'content-type' : 'text/html;charset="utf-8"'
                });
                res.write('<h1>404错误</h1><p>你要找的页面不存在</p>');
                res.end();
            }else{
                res.writeHeader(200,{
                    'content-type' : 'text/html;charset="utf-8"'
                });
                res.write(data);//将index.html显示在客户端
                res.end();
    
            }
    
        });
 
})
 
 
//服务端等着客户端请求需要做一个监听。通过创建的服务。
//监听
myServer.listen('80',function(err){
    if(err){
        console.log(err);
        throw err;
    }
    console.log("服务器已开启。端口号为:80");
})
 
//浏览器请求服务器。知道当前计算机的ip地址。例如，127.0.0.1:3000
