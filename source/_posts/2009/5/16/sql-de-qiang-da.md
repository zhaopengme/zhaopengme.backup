title: sql的强大
id: 434
categories: 闲言碎语
date: 2009-05-16 00:27:10
tags:
---

我知道sql的查询很复杂，也是很强大，但就没有见过如果强大的，让大家看一句我最近刚写的,就一句sql语句将总数，百分比都出来了！
</br>select t.*,
</br>round(decode(nvl(all_count,0),0,0,send_count/all_count),3)*100 send_count_rate,
</br>round(decode(nvl(all_count,0),0,0,distribute_count/all_count),3)*100 distribute_count_rate,
</br>round(decode(nvl(all_count,0),0,0,success_count/all_count),3)*100 success_count_rate,
</br>round(decode(nvl(all_count,0),0,0,resend_count/all_count),3)*100 resend_count_rate,
</br>round(decode(nvl(all_count,0),0,0,failure_count/all_count),3)*100 failure_count_rate
</br>from
</br>(
</br>select company_name,
</br>sum(case when process_state=1 or process_state=2 or process_state=3 or process_state=4 or process_state=5 then 1 else 0 end) all_count,
</br>sum(case when process_state=1 then 1 else 0 end) send_count,
</br>sum(case when process_state=2 then 1 else 0 end) distribute_count,
</br>sum(case when process_state=3 then 1 else 0 end) success_count,
</br>sum(case when process_state=4 then 1 else 0 end) resend_count,
</br>sum(case when process_state=5 then 1 else 0 end) failure_count
</br>from t_pbb_open_task group by company_name
</br>) t
</br>[![http://lh4.ggpht.com/_uwC7KS2yb2k/Sg2dfuB4pyI/AAAAAAAABok/sIn1ZczVVCg/s800/sql.JPG](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://lh4.ggpht.com/_uwC7KS2yb2k/Sg2dfuB4pyI/AAAAAAAABok/sIn1ZczVVCg/s800/sql.JPG)
