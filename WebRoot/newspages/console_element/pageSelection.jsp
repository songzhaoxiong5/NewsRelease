 <p align="center" id="pageSelection2"> 当前页数:[${pageScope.pageIndex}/${pageScope.totalPages}]&nbsp; 
 <a href="news_init_index.jsp?dynTopic=${pageScope.dynTopic}&pageIndex=1">首页</a>&nbsp;
 <a href="news_init_index.jsp?dynTopic=${pageScope.dynTopic}&pageIndex=${pageScope.pageIndex-1}">上一页</a>
 <a href="news_init_index.jsp?dynTopic=${pageScope.dynTopic}&pageIndex=${pageScope.pageIndex+1}">下一页</a>&nbsp;
 <a href="news_init_index.jsp?dynTopic=${pageScope.dynTopic}&pageIndex=${pageScope.totalPages}">末页</a>
 </p>
