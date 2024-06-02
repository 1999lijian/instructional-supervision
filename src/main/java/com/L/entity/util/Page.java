package com.L.entity.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author LIJIAN
 * @Date 2023/12/15 16:06
 */
//分页
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Page {
    //    每页开始元素的索引
    int startIndex;
    //    每页的数量
    int pageSize;
    //    数据总数数据量
    int total;

    //构造方法 startIndex、pageSize
    public Page(int startIndex, int pageSize) {
        super();
        this.startIndex = startIndex;
        this.pageSize = pageSize;


    }

    //    判断是否有上一页
    public boolean isHasPrevious() {
        if (startIndex == 0) {
            return false;
        }
        return true;
    }


    // 判断是否有下一页
    public boolean isHasNext() {
        if (startIndex == getLast()) {
            return false;
        }
        return true;
    }


    // 计算尾页的第一条元素索引
    public int getLast() {
        int last;
        if (0 == total % pageSize) {
            last = total - pageSize;
        } else {
            last = total - total % pageSize;
        }
        last = last < 0 ? 0 : last;
        return last;
    }


    //    计算数据展示的总页数
    public int getTotalPage() {
        int totalPage;
//        数据总数对每页容量进行求余为0，那么就是（数据总数）除以（每页容量）= 总页数；
        //        数据总数对每页容量进行求余不为0，那么就是（数据总数）除以（每页容量）+1 = 总页数；
        if (0 == total % pageSize) {
            totalPage = total / pageSize;
        } else {
            totalPage = total / pageSize + 1;
        }

        if (0 == totalPage || 1 == totalPage) {
            totalPage = 1;
        }
        return totalPage;
    }


}
